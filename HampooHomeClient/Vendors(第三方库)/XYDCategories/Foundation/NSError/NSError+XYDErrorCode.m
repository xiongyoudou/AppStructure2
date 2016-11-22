//
//  NSError+XYDErrorCode.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/11.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "NSError+XYDErrorCode.h"

NSString * const kXYDErrorDomain = @"AVOS Cloud Error Domain";
NSString * const kXYDErrorUnknownText = @"Error Infomation Unknown";
NSInteger const kXYDErrorUnknownErrorCode = NSIntegerMax;
NSInteger const kXYDErrorInternalServer = 1;
NSInteger const kXYDErrorConnectionFailed = 100;
NSInteger const kXYDErrorObjectNotFound = 101;
NSInteger const kXYDErrorInvalidQuery = 102;
NSInteger const kXYDErrorInvalidClassName = 103;
NSInteger const kXYDErrorMissingObjectId = 104;
NSInteger const kXYDErrorInvalidKeyName = 105;
NSInteger const kXYDErrorInvalidPointer = 106;
NSInteger const kXYDErrorInvalidJSON = 107;
NSInteger const kXYDErrorCommandUnavailable = 108;
NSInteger const kXYDErrorIncorrectType = 111;
NSInteger const kXYDErrorInvalidChannelName = 112;
NSInteger const kXYDErrorInvalidDeviceToken = 114;
NSInteger const kXYDErrorPushMisconfigured = 115;
NSInteger const kXYDErrorObjectTooLarge = 116;
NSInteger const kXYDErrorOperationForbidden = 119;
NSInteger const kXYDErrorCacheMiss = 120;
/*! @abstract 121: Keys in NSDictionary values may not include '$' or '.'. */
NSInteger const kXYDErrorInvalidNestedKey = 121;
/*! @abstract 122: Invalid file name. A file name contains only a-zA-Z0-9_. characters and is between 1 and 36 characters. */
NSInteger const kXYDErrorInvalidFileName = 122;
/*! @abstract 123: Invalid ACL. An ACL with an invalid format was saved. This should not happen if you use AVACL. */
NSInteger const kXYDErrorInvalidACL = 123;
/*! @abstract 124: The request timed out on the server. Typically this indicates the request is too expensive. */
NSInteger const kXYDErrorTimeout = 124;
/*! @abstract 125: The email address was invalid. */
NSInteger const kXYDErrorInvalidEmailAddress = 125;
/*! @abstract 127: The mobile phone number was invalid. */
NSInteger const kXYDErrorInvalidMobilePhoneNumber = 127;

NSInteger const kXYDErrorDuplicateValue = 137;


/*! @abstract 139: Role's name is invalid. */
NSInteger const kXYDErrorInvalidRoleName = 139;
/*! @abstract 140: Exceeded an application quota.  Upgrade to resolve. */
NSInteger const kXYDErrorExceededQuota = 140;
/*! @abstract 141: Cloud Code script had an error. */
NSInteger const kXYDScriptError = 141;
/*! @abstract 142: Cloud Code validation failed. */
NSInteger const kXYDValidationError = 142;
/*! @abstract 143: Product purchase receipt is missing */
NSInteger const kXYDErrorReceiptMissing = 143;
/*! @abstract 144: Product purchase receipt is invalid */
NSInteger const kXYDErrorInvalidPurchaseReceipt = 144;
/*! @abstract 145: Payment is disabled on this device */
NSInteger const kXYDErrorPaymentDisabled = 145;
/*! @abstract 146: The product identifier is invalid */
NSInteger const kXYDErrorInvalidProductIdentifier = 146;
/*! @abstract 147: The product is not found in the App Store */
NSInteger const kXYDErrorProductNotFoundInAppStore = 147;
/*! @abstract 148: The Apple server response is not valid */
NSInteger const kXYDErrorInvalidServerResponse = 148;
/*! @abstract 149: Product fails to download due to file system error */
NSInteger const kXYDErrorProductDownloadFileSystemFailure = 149;
/*! @abstract 150: Fail to convert data to image. */
NSInteger const kXYDErrorInvalidImageData = 150;
/*! @abstract 151: Unsaved file. */
NSInteger const kXYDErrorUnsavedFile = 151;
/*! @abstract 153: Fail to delete file. */
NSInteger const kXYDErrorFileDeleteFailure = 153;

/*! @abstract 200: Username is missing or empty */
NSInteger const kXYDErrorUsernameMissing = 200;
/*! @abstract 201: Password is missing or empty */
NSInteger const kXYDErrorUserPasswordMissing = 201;
/*! @abstract 202: Username has already been taken */
NSInteger const kXYDErrorUsernameTaken = 202;
/*! @abstract 203: Email has already been taken */
NSInteger const kXYDErrorUserEmailTaken = 203;
/*! @abstract 204: The email is missing, and must be specified */
NSInteger const kXYDErrorUserEmailMissing = 204;
/*! @abstract 205: A user with the specified email was not found */
NSInteger const kXYDErrorUserWithEmailNotFound = 205;
/*! @abstract 206: The user cannot be altered by a client without the session. */
NSInteger const kXYDErrorUserCannotBeAlteredWithoutSession = 206;
/*! @abstract 207: Users can only be created through sign up */
NSInteger const kXYDErrorUserCanOnlyBeCreatedThroughSignUp = 207;
/*! @abstract 208: An existing account already linked to another user. */
NSInteger const kXYDErrorAccountAlreadyLinked = 208;
/*! @abstract 209: User ID mismatch */
NSInteger const kXYDErrorUserIdMismatch = 209;
/*! @abstract 210: The username and password mismatch. */
NSInteger const kXYDErrorUsernamePasswordMismatch = 210;
/*! @abstract 211: Could not find user. */
NSInteger const kXYDErrorUserNotFound = 211;
/*! @abstract 212: The mobile phone number is missing, and must be specified. */
NSInteger const kXYDErrorUserMobilePhoneMissing = 212;
/*! @abstract 213: An user with the specified mobile phone number was not found. */
NSInteger const kXYDErrorUserWithMobilePhoneNotFound = 213;
/*! @abstract 214: Mobile phone number has already been taken. */
NSInteger const kXYDErrorUserMobilePhoneNumberTaken = 214;
/*! @abstract 215: Mobile phone number isn't verified. */
NSInteger const kXYDErrorUserMobilePhoneNotVerified = 215;

/*! @abstract 250: Linked id missing from request */
NSInteger const kXYDErrorLinkedIdMissing = 250;
/*! @abstract 251: Invalid linked session */
NSInteger const kXYDErrorInvalidLinkedSession = 251;

/*! Local file not found */
NSInteger const kXYDErrorFileNotFound = 400;

/*! File Data not available */
NSInteger const kXYDErrorFileDataNotAvailable = 401;

@implementation NSError (XYDErrorCode)

+(NSError *)errorWithCode:(NSInteger)code
{
    return [NSError errorWithDomain:kXYDErrorDomain code:code userInfo:nil];
}

+ (NSError *)errorWithText:(NSString *)text {
    return [self errorWithCode:0 errorText:text];
}

+(NSError *)errorWithCode:(NSInteger)code errorText:(NSString *)text {
    if (!code) { code = 0; }
    NSDictionary *errorInfo=@{
                              @"code":@(code),
                              @"error":text, //???: should we remove this key
                              NSLocalizedDescriptionKey:NSLocalizedString(text, nil), //TODO: add localized error descriptions
                              };
    
    NSError *err= [NSError errorWithDomain:kXYDErrorDomain
                                      code:code
                                  userInfo:errorInfo];
    
    
    return err;
}

+(NSError *)internalServerError
{
    return [NSError errorWithDomain:kXYDErrorDomain code:kXYDErrorInternalServer userInfo:nil];
}

+(NSError *)fileNotFoundError
{
    NSError *error = [self errorWithCode:kXYDErrorFileNotFound errorText:@"File not found."];
    return error;
}

+(NSError *)dataNotAvailableError
{
    NSError * error = [self errorWithCode:kXYDErrorFileDataNotAvailable errorText:@"File data not available."];
    return error;
}

/**
 {
 "code": 105,
 "error": "invalid field name: bl!ng"
 }
 
 递归找到一个 error 为止
 */
+ (NSError *)errorFromJSON:(id)JSON {
    if (!JSON) {
        return nil;
    }
    
    NSError *returnError = nil;
    
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        if ([self _isDictionaryError:JSON]) {
            returnError = [self _errorFromDictionary:JSON];
        } else {
            for (NSString *key in [JSON allKeys]) {
                id child = [JSON objectForKey:key];
                
                if ([child isKindOfClass:[NSDictionary class]] && [self _isDictionaryError:child]) {
                    returnError = [self _errorFromDictionary:child];
                    break;
                }
            }
        }
    } else if ([JSON isKindOfClass:[NSArray class]]) {
        for (id JSON1 in [JSON copy]) {
            returnError = [[self class] errorFromJSON:JSON1];
            if (returnError) {
                break;
            }
        }
    }
    
    if (returnError) NSLog(@"error: %@", returnError);
    
    return returnError;
}

+ (NSString *)errorTextFromError:(NSError *)error {
    NSString *JSONString = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    
    return [JSON objectForKey:@"error"];
}

+ (NSError *)errorFromAVError:(NSError *)error
{
    NSString *JSONString = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
    if (JSONString == nil) {
        return error;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:NULL];
    if ([dict objectForKey:@"code"] == nil) {
        return error;
    }
    return [self errorFromJSON:dict];
}

#pragma mark - Internal Methods
+ (NSError *)_errorFromDictionary:(NSDictionary *)dic {
    if (![self _isDictionaryError:dic]) return nil;
    
    NSString *errorString = [dic objectForKey:@"error"];
    NSNumber *code = [dic objectForKey:@"code"];
    if (!code || ((id)code == [NSNull null])) {
        code = @(kXYDErrorUnknownErrorCode);
    }
    if (!errorString || ((id)errorString == [NSNull null])) {
        errorString = kXYDErrorUnknownText;
    }
    return [self errorWithCode:code.integerValue errorText:errorString];
}

+ (BOOL)_isDictionaryError:(NSDictionary *)dic {
    NSString *errorString = [dic objectForKey:@"error"];
    NSNumber *code = [dic objectForKey:@"code"];
    if (((id)code == [NSNull null]) && ((id)errorString == [NSNull null])) {
        return NO;
    }
    if (code) {
        return YES;
    }
    
    if (errorString) {
        return YES;
    }
    
    return NO;
}

@end
