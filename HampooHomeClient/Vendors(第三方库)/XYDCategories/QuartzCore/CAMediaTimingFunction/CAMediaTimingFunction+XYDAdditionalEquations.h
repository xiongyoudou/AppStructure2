//
//  CAMediaTimingFunction+AdditionalEquations.h
//
//  Created by Heiko Dreyer on 02.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//  https://github.com/bfolder/UIView-Visuals

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (JKAdditionalEquations)


///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInCirc;
+(CAMediaTimingFunction *)xyd_easeOutCirc;
+(CAMediaTimingFunction *)xyd_easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInCubic;
+(CAMediaTimingFunction *)xyd_easeOutCubic;
+(CAMediaTimingFunction *)xyd_easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInExpo;
+(CAMediaTimingFunction *)xyd_easeOutExpo;
+(CAMediaTimingFunction *)xyd_easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInQuad;
+(CAMediaTimingFunction *)xyd_easeOutQuad;
+(CAMediaTimingFunction *)xyd_easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInQuart;
+(CAMediaTimingFunction *)xyd_easeOutQuart;
+(CAMediaTimingFunction *)xyd_easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInQuint;
+(CAMediaTimingFunction *)xyd_easeOutQuint;
+(CAMediaTimingFunction *)xyd_easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInSine;
+(CAMediaTimingFunction *)xyd_easeOutSine;
+(CAMediaTimingFunction *)xyd_easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)xyd_easeInBack;
+(CAMediaTimingFunction *)xyd_easeOutBack;
+(CAMediaTimingFunction *)xyd_easeInOutBack;

@end
