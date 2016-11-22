//
//  UIApplication-Permissions.h
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//  https://github.com/JackRostron/UIApplication-Permissions
//   Category on UIApplication that adds permission helpers


#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

typedef enum {
    XYDPermissionTypeBluetoothLE,
    XYDPermissionTypeCalendar,
    XYDPermissionTypeContacts,
    XYDPermissionTypeLocation,
    XYDPermissionTypeMicrophone,
    XYDPermissionTypeMotion,
    XYDPermissionTypePhotos,
    XYDPermissionTypeReminders,
} XYDPermissionType;

typedef enum {
    XYDPermissionAccessDenied, //User has rejected feature
    XYDPermissionAccessGranted, //User has accepted feature
    XYDPermissionAccessRestricted, //Blocked by parental controls or system settings
    XYDPermissionAccessUnknown, //Cannot be determined
    XYDPermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    XYDPermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} XYDPermissionAccess;

@interface UIApplication (XYDPermissions)

//Check permission of service. Cannot check microphone or motion without asking user for permission
-(XYDPermissionAccess)xyd_hasAccessToBluetoothLE;
-(XYDPermissionAccess)xyd_hasAccessToCalendar;
-(XYDPermissionAccess)xyd_hasAccessToContacts;
-(XYDPermissionAccess)xyd_hasAccessToLocation;
-(XYDPermissionAccess)xyd_hasAccessToPhotos;
-(XYDPermissionAccess)xyd_hasAccessToReminders;

//Request permission with callback
-(void)xyd_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)xyd_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)xyd_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)xyd_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)xyd_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//Instance methods
-(void)xyd_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//No failure callback available
-(void)xyd_requestAccessToMotionWithSuccess:(void(^)())accessGranted;

//Needs investigating - unsure whether it can be implemented because of required delegate callbacks
//-(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted;

@end
