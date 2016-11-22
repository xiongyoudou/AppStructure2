//
//  UIView+Toast.m
//  Toast
//
//  Copyright 2014 Charles Scalesse.
//


#import "UIView+XYDToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat XYDToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat XYDToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat XYDToastHorizontalPadding   = 10.0;
static const CGFloat XYDToastVerticalPadding     = 10.0;
static const CGFloat XYDToastCornerRadius        = 10.0;
static const CGFloat XYDToastOpacity             = 0.8;
static const CGFloat XYDToastFontSize            = 16.0;
static const CGFloat XYDToastMaxTitleLines       = 0;
static const CGFloat XYDToastMaxMessageLines     = 0;
static const NSTimeInterval XYDToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat XYDToastShadowOpacity       = 0.8;
static const CGFloat XYDToastShadowRadius        = 6.0;
static const CGSize  XYDToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    XYDToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval XYDToastDefaultDuration  = 3.0;

// image view size
static const CGFloat XYDToastImageViewWidth      = 80.0;
static const CGFloat XYDToastImageViewHeight     = 80.0;

// activity
static const CGFloat XYDToastActivityWidth       = 100.0;
static const CGFloat XYDToastActivityHeight      = 100.0;
static const NSString * XYDToastActivityDefaultPosition = @"center";

// interaction
static const BOOL XYDToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * XYDToastTimerKey         = @"XYDToastTimerKey";
static const NSString * XYDToastActivityViewKey  = @"XYDToastActivityViewKey";
static const NSString * XYDToastTapCallbackKey   = @"XYDToastTapCallbackKey";

// positions
NSString * const XYDToastPositionTop             = @"top";
NSString * const XYDToastPositionCenter          = @"center";
NSString * const XYDToastPositionBottom          = @"bottom";

@interface UIView (XYDToastPrivate)

- (void)xyd_hideToast:(UIView *)toast;
- (void)xyd_toastTimerDidFinish:(NSTimer *)timer;
- (void)xyd_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)xyd_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)xyd_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)xyd_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@implementation UIView (XYDToast)

#pragma mark - Toast Methods

- (void)xyd_makeToast:(NSString *)message {
    [self xyd_makeToast:message duration:XYDToastDefaultDuration position:nil];
}

- (void)xyd_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self xyd_viewForMessage:message title:nil image:nil];
    [self xyd_showToast:toast duration:duration position:position];
}

- (void)xyd_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self xyd_viewForMessage:message title:title image:nil];
    [self xyd_showToast:toast duration:duration position:position];
}

- (void)xyd_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self xyd_viewForMessage:message title:nil image:image];
    [self xyd_showToast:toast duration:duration position:position];
}

- (void)xyd_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self xyd_viewForMessage:message title:title image:image];
    [self xyd_showToast:toast duration:duration position:position];
}

- (void)xyd_showToast:(UIView *)toast {
    [self xyd_showToast:toast duration:XYDToastDefaultDuration position:nil];
}


- (void)xyd_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self xyd_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)xyd_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self xyd_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (XYDToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(xyd_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:XYDToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(xyd_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &XYDToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &XYDToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)xyd_hideToast:(UIView *)toast {
    [UIView animateWithDuration:XYDToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)xyd_toastTimerDidFinish:(NSTimer *)timer {
    [self xyd_hideToast:(UIView *)timer.userInfo];
}

- (void)xyd_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &XYDToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &XYDToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self xyd_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)xyd_makeToastActivity {
    [self xyd_makeToastActivity:XYDToastActivityDefaultPosition];
}

- (void)xyd_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &XYDToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XYDToastActivityWidth, XYDToastActivityHeight)];
    activityView.center = [self xyd_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:XYDToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = XYDToastCornerRadius;
    
    if (XYDToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = XYDToastShadowOpacity;
        activityView.layer.shadowRadius = XYDToastShadowRadius;
        activityView.layer.shadowOffset = XYDToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &XYDToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:XYDToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)xyd_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &XYDToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:XYDToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &XYDToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)xyd_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:XYDToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + XYDToastVerticalPadding);
        } else if([point caseInsensitiveCompare:XYDToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - XYDToastVerticalPadding);
}

- (CGSize)xyd_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)xyd_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = XYDToastCornerRadius;
    
    if (XYDToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = XYDToastShadowOpacity;
        wrapperView.layer.shadowRadius = XYDToastShadowRadius;
        wrapperView.layer.shadowOffset = XYDToastShadowOffset;
    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:XYDToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(XYDToastHorizontalPadding, XYDToastVerticalPadding, XYDToastImageViewWidth, XYDToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = XYDToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = XYDToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:XYDToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * XYDToastMaxWidth) - imageWidth, self.bounds.size.height * XYDToastMaxHeight);
        CGSize expectedSizeTitle = [self xyd_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = XYDToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:XYDToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * XYDToastMaxWidth) - imageWidth, self.bounds.size.height * XYDToastMaxHeight);
        CGSize expectedSizeMessage = [self xyd_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = XYDToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + XYDToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;

    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + XYDToastHorizontalPadding;
        messageTop = titleTop + titleHeight + XYDToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (XYDToastHorizontalPadding * 2)), (longerLeft + longerWidth + XYDToastHorizontalPadding));    
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + XYDToastVerticalPadding), (imageHeight + (XYDToastVerticalPadding * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
        
    return wrapperView;
}

@end
