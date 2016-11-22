//
//  UIButton+Submitting.m
//  FXCategories
//
//  Created by foxsofter on 15/4/2.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIButton+XYDSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *xyd_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *xyd_spinnerView;
@property(nonatomic, strong) UILabel *xyd_spinnerTitleLabel;

@end

@implementation UIButton (XYDSubmitting)

- (void)xyd_beginSubmitting:(NSString *)title {
    [self xyd_endSubmitting];
    
    self.xyd_submitting = @YES;
    self.hidden = YES;
    
    self.xyd_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.xyd_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.xyd_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.xyd_modalView.layer.borderWidth = self.layer.borderWidth;
    self.xyd_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.xyd_modalView.bounds;
    self.xyd_spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.xyd_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.xyd_spinnerView.bounds;
    self.xyd_spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.xyd_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.xyd_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.xyd_spinnerTitleLabel.text = title;
    self.xyd_spinnerTitleLabel.font = self.titleLabel.font;
    self.xyd_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.xyd_modalView addSubview:self.xyd_spinnerView];
    [self.xyd_modalView addSubview:self.xyd_spinnerTitleLabel];
    [self.superview addSubview:self.xyd_modalView];
    [self.xyd_spinnerView startAnimating];
}

- (void)xyd_endSubmitting {
    if (!self.isJKSubmitting.boolValue) {
        return;
    }
    
    self.xyd_submitting = @NO;
    self.hidden = NO;
    
    [self.xyd_modalView removeFromSuperview];
    self.xyd_modalView = nil;
    self.xyd_spinnerView = nil;
    self.xyd_spinnerTitleLabel = nil;
}

- (NSNumber *)isJKSubmitting {
    return objc_getAssociatedObject(self, @selector(setXyd_submitting:));
}

- (void)setXyd_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setXyd_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)xyd_spinnerView {
    return objc_getAssociatedObject(self, @selector(setXyd_spinnerView:));
}

- (void)setXyd_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setXyd_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)xyd_modalView {
    return objc_getAssociatedObject(self, @selector(setXyd_modalView:));

}

- (void)setXyd_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setXyd_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)xyd_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setXyd_spinnerTitleLabel:));
}

- (void)setXyd_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setXyd_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
