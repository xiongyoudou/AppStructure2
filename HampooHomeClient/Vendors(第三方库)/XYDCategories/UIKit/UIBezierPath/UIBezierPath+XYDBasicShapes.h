//
//  UIBezierPath+XYDBasicShapes.h
//  Example
//
//  Created by Pierre Dulac on 26/02/13.
//  Copyright (c) 2013 Pierre Dulac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (XYDBasicShapes)

+ (UIBezierPath *)xyd_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)xyd_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)xyd_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)xyd_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)xyd_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)xyd_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
