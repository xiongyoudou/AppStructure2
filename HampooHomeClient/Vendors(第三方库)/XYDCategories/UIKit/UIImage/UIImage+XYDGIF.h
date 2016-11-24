//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYDGIF)

+ (UIImage *)xyd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)xyd_animatedGIFWithData:(NSData *)data;

- (UIImage *)xyd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
