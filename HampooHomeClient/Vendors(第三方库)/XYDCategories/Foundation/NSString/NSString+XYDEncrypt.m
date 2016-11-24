//
//  NSString+XYDEncrypt.m

//
//  Created by Jakey on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+XYDEncrypt.h"
#import "NSData+XYDEncrypt.h"
#import "NSData+XYDBase64.h"

@implementation NSString (XYDEncrypt)
-(NSString*)xyd_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] xyd_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted xyd_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)xyd_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData xyd_dataWithBase64EncodedString:self] xyd_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)xyd_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] xyd_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted xyd_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)xyd_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData xyd_dataWithBase64EncodedString:self] xyd_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
