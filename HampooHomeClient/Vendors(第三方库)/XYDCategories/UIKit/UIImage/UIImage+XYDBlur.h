//
//  UIImage+Blur.h

//
//  Created by Jakey on 15/6/5.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (XYDBlur)

- (UIImage *)xyd_lightImage;
- (UIImage *)xyd_extraLightImage;
- (UIImage *)xyd_darkImage;
- (UIImage *)xyd_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)xyd_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)xyd_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)xyd_blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
@end
