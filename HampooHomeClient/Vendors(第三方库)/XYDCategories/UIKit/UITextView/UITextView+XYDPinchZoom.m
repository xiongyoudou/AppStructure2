//
//  UITextView+PinchZoom.m
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//

#import "UITextView+XYDPinchZoom.h"
#import "objc/runtime.h"

static int xyd_minFontSizeKey;
static int xyd_maxFontSizeKey;
static int xyd_zoomEnabledKey;

@implementation UITextView (XYDPinchZoom)

- (void)setXyd_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &xyd_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)xyd_maxFontSize
{
    return [objc_getAssociatedObject(self, &xyd_maxFontSizeKey) floatValue];
}

- (void)setXyd_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &xyd_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)xyd_minFontSize
{
    return [objc_getAssociatedObject(self, &xyd_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.isxyd_zoomEnabled) return;

    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;

    pointSize = MAX(MIN(pointSize, self.xyd_maxFontSize), self.xyd_minFontSize);

    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}


- (void)setXyd_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &xyd_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;

        self.xyd_minFontSize = self.xyd_minFontSize ?: 8.0f;
        self.xyd_maxFontSize = self.xyd_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)isxyd_zoomEnabled
{
    return [objc_getAssociatedObject(self, &xyd_zoomEnabledKey) boolValue];
}

@end
