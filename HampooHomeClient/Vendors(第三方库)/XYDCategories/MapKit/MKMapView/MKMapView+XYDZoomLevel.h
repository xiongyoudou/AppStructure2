//
//  MKMapView+ZoomLevel.h

//
//  Created by Jakey on 15/4/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

//http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/

#import <MapKit/MapKit.h>

@interface MKMapView (XYDZoomLevel)

- (void)xyd_setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
