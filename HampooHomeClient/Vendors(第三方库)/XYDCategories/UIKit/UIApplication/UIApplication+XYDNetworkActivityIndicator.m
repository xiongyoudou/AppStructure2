//
//  UIApplication+XYDNetworkActivityIndicator.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "UIApplication+XYDNetworkActivityIndicator.h"

#import <libkern/OSAtomic.h>

@implementation UIApplication (XYDNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsxxx;

#pragma mark Public API

- (void)xyd_beganNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

- (void)xyd_endedNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

@end
