//
//  UIImageView+BetterFace.h
//  bf
//
//  Created by croath on 13-10-22.
//  Copyright (c) 2013年 Croath. All rights reserved.
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

@interface UIImageView (XYDBetterFace)

@property (nonatomic) BOOL xyd_needsBetterFace;
@property (nonatomic) BOOL xyd_fast;

void xyd_hack_uiimageview_bf();
- (void)xyd_setBetterFaceImage:(UIImage *)image;

@end
