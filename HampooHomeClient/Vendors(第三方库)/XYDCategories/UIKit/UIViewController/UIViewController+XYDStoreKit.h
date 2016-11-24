//
//  UIViewController+StoreKit.h
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//  https://github.com/mergesort/UIViewController-StoreKit

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (XYDStoreKit)

@property NSString *xyd_campaignToken;
@property (nonatomic, copy) void (^xyd_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^xyd_loadedStoreKitItemBlock)(void);

- (void)xyd_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)xyd_appURLForIdentifier:(NSInteger)identifier;

+ (void)xyd_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)xyd_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)xyd_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)xyd_IDFromITunesURL:(NSString*)URLString;

@end
