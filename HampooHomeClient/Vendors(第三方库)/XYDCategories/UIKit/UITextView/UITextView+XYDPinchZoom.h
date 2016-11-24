//
//  UITextView+PinchZoom.h
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//
//  Based on Aral Balkan snippet.

// https://github.com/cfr/UITextView-PinchZoom
//  Simple pinch-zoom category for UITextView

/*
 UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
 [self.view addSubview:textView];
 textView.zoomEnabled = YES;
 textView.minFontSize = 10;
 textView.maxFontSize = 40;
*/
#import <UIKit/UIKit.h>

@interface UITextView (XYDPinchZoom)

@property (nonatomic) CGFloat xyd_maxFontSize, xyd_minFontSize;

@property (nonatomic, getter = isxyd_zoomEnabled) BOOL xyd_zoomEnabled;

@end
