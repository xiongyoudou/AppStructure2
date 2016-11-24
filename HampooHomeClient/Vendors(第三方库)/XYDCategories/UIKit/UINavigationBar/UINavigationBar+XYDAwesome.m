//
//  UINavigationBar+XYDAwesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+XYDAwesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (XYDAwesome)
static char xyd_overlayKey;

- (UIView *)xyd_overlay
{
    return objc_getAssociatedObject(self, &xyd_overlayKey);
}

- (void)setXyd_overlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &xyd_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xyd_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.xyd_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.xyd_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.xyd_overlay.userInteractionEnabled = NO;
        self.xyd_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.xyd_overlay atIndex:0];
    }
    self.xyd_overlay.backgroundColor = backgroundColor;
}

- (void)xyd_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)xyd_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)xyd_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.xyd_overlay removeFromSuperview];
    self.xyd_overlay = nil;
}

@end
