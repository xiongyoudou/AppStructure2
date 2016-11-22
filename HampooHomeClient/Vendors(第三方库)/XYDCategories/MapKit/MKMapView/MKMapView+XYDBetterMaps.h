//
//  MKMapView+BetterMaps.h

//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/xjunior/BetterMaps


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (XYDBetterMaps)
- (void)xyd_zoomToFitAnnotationsAnimated:(BOOL)animated;
@end
