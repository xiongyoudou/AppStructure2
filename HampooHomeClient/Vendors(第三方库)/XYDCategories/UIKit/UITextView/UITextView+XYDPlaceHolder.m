//
//  UITextView+PlaceHolder.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+XYDPlaceHolder.h"
static const char *xyd_placeHolderTextView = "xyd_placeHolderTextView";
@implementation UITextView (XYDPlaceHolder)
- (UITextView *)xyd_placeHolderTextView {
    return objc_getAssociatedObject(self, xyd_placeHolderTextView);
}
- (void)setXyd_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, xyd_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)xyd_addPlaceHolder:(NSString *)placeHolder {
    if (![self xyd_placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setXyd_placeHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.xyd_placeHolderTextView.hidden = YES;
    // if (self.textViewDelegate) {
    //
    // }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.xyd_placeHolderTextView.hidden = NO;
    }
}

@end
