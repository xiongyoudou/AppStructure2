//
//  UIImage+BetterFace.h
//  bf
//
//  Created by liuyan on 13-11-25.
//  Copyright (c) 2013年 Croath. All rights reserved.
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XYDAccuracy) {
    XYDAccuracyLow = 0,
    XYDAccuracyHigh,
};

@interface UIImage (XYDBetterFace)

- (UIImage *)xyd_betterFaceImageForSize:(CGSize)size
                           accuracy:(XYDAccuracy)accurary;

@end
