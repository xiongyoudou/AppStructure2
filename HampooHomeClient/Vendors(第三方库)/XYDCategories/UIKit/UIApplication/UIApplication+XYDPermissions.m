//
//  UIApplication-Permissions.m
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//

#import "UIApplication+XYDPermissions.h"
#import <objc/runtime.h>

//Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

typedef void (^XYDLocationSuccessCallback)();
typedef void (^XYDLocationFailureCallback)();

static char XYDPermissionsLocationManagerPropertyKey;
static char XYDPermissionsLocationBlockSuccessPropertyKey;
static char XYDPermissionsLocationBlockFailurePropertyKey;

@interface UIApplication () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *xyd_permissionsLocationManager;
@property (nonatomic, copy) XYDLocationSuccessCallback xyd_locationSuccessCallbackProperty;
@property (nonatomic, copy) XYDLocationFailureCallback xyd_locationFailureCallbackProperty;
@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
-(XYDPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return XYDPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return XYDPermissionAccessDenied;
            break;
            
        default:
            return XYDPermissionAccessGranted;
            break;
    }
}

-(XYDPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return XYDPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return XYDPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return XYDPermissionAccessRestricted;
            break;
            
        default:
            return XYDPermissionAccessUnknown;
            break;
    }
}

-(XYDPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return XYDPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return XYDPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return XYDPermissionAccessRestricted;
            break;
            
        default:
            return XYDPermissionAccessUnknown;
            break;
    }
}

-(XYDPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            return XYDPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return XYDPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return XYDPermissionAccessRestricted;
            break;
            
        default:
            return XYDPermissionAccessUnknown;
            break;
    }
    return XYDPermissionAccessUnknown;
}

-(XYDPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return XYDPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return XYDPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return XYDPermissionAccessRestricted;
            break;
            
        default:
            return XYDPermissionAccessUnknown;
            break;
    }
}

-(XYDPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return XYDPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return XYDPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return XYDPermissionAccessRestricted;
            break;
            
        default:
            return XYDPermissionAccessUnknown;
            break;
    }
    return XYDPermissionAccessUnknown;
}


#pragma mark - Request permissions
-(void)xyd_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)xyd_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

-(void)xyd_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)xyd_requestAccessToMotionWithSuccess:(void(^)())accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

-(void)xyd_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

-(void)xyd_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


#pragma mark - Needs investigating
/*
 -(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted {
 //REQUIRES DELEGATE - NEEDS RETHINKING
 }
 */

-(void)xyd_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    self.xyd_permissionsLocationManager = [[CLLocationManager alloc] init];
    self.xyd_permissionsLocationManager.delegate = self;
    
    self.xyd_locationSuccessCallbackProperty = accessGranted;
    self.xyd_locationFailureCallbackProperty = accessDenied;
    [self.xyd_permissionsLocationManager startUpdatingLocation];
}


#pragma mark - Location manager injection
-(CLLocationManager *)xyd_permissionsLocationManager {
    return objc_getAssociatedObject(self, &XYDPermissionsLocationManagerPropertyKey);
}

-(void)setXyd_permissionsLocationManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &XYDPermissionsLocationManagerPropertyKey, manager, OBJC_ASSOCIATION_RETAIN);
}

-(XYDLocationSuccessCallback)locationSuccessCallbackProperty {
    return objc_getAssociatedObject(self, &XYDPermissionsLocationBlockSuccessPropertyKey);
}

-(void)setXyd_locationSuccessCallbackProperty:(XYDLocationSuccessCallback)locationCallbackProperty {
    objc_setAssociatedObject(self, &XYDPermissionsLocationBlockSuccessPropertyKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY);
}

-(XYDLocationFailureCallback)locationFailureCallbackProperty {
    return objc_getAssociatedObject(self, &XYDPermissionsLocationBlockFailurePropertyKey);
}

-(void)setXyd_locationFailureCallbackProperty:(XYDLocationFailureCallback)locationFailureCallbackProperty {
    objc_setAssociatedObject(self, &XYDPermissionsLocationBlockFailurePropertyKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY);
}


#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorized) {
        self.locationSuccessCallbackProperty();
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationFailureCallbackProperty();
    }
}

@end
