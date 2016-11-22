//
//  FileHelper.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/25.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject
+ (void)writeDictDataToPlistFile:(NSMutableDictionary *)aSaveDic fileName:(NSString *)fileName;
+ (void)writeDict:(NSDictionary *)dict toPath:(NSString *)filePath;
+ (NSMutableDictionary *)getPlistFileData:(NSString *)fileName;
+ (BOOL)writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset;
+ (NSData *)isValidResumeData:(NSData *)data;
+ (void)createFilePahtIfNotExists:(NSString *)path;
+ (NSString *)getFileNamePath:(NSString *)fileName;
+ (BOOL)isExistAtDocumentFile:(NSString *)fileName;
+ (BOOL)isExistAtPath:(NSString *)filePath;
+ (void)deleteDocumentFile:(NSString *)fileName;
+ (NSString *)getFolderNamePath:(NSString *)folderName fileName:(NSString *)fileName PathExtension:(NSString *)pathExtension;
+ (BOOL)deleteWithContentPath:(NSString *)path;
+ (NSString *)getFileSizeWithByteCounts:(long long)byteCounts;
+ (unsigned long long)fileSizeForPath:(NSString *)path;
+ (float)folderSizeAtPath:(NSString*) folderPath;
+ (void)clearCache:(NSString *)path;

@end
