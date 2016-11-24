//
//  NSFileManager+Paths.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ALAsset;

@interface NSFileManager (XYDPaths)

+ (NSString *)xyd_homeDirectoryPath;
/**
 Get URL of Documents directory.
 
 @return Documents directory URL.
 */
+ (NSURL *)xyd_documentsURL;

/**
 Get path of Documents directory.
 
 @return Documents directory path.
 */
+ (NSString *)xyd_documentsPath;

/**
 Get URL of Library directory.
 
 @return Library directory URL.
 */
+ (NSURL *)xyd_libraryURL;

/**
 Get path of Library directory.
 
 @return Library directory path.
 */
+ (NSString *)xyd_libraryPath;

/**
 Get URL of Caches directory.
 
 @return Caches directory URL.
 */
+ (NSURL *)xyd_cachesURL;

/**
 Get path of Caches directory.
 
 @return Caches directory path.
 */
+ (NSString *)xyd_cachesPath;

+ (NSString *)MIMEType:(NSString *)filePathOrName;
+ (NSString *)MIMETypeFromPath:(NSString *)fullPath;
+(NSString *)contentTypeForImageData:(NSData *)data;
+ (NSString*)MD5ForFile:(NSString*)filePath;
+ (NSString*)SHAForFile:(NSString *)filePath;
+ (NSString*)SHAForFile:(NSString *)filePath chunkSizeForReadingData:(size_t)chunkSizeForReadingData;

/**
 Adds a special filesystem flag to a file to avoid iCloud backup it.
 
 @param path Path to a file to set an attribute.
 */
+ (BOOL)xyd_addSkipBackupAttributeToFile:(NSString *)path;

/**
 Get available disk space.
 
 @return An amount of available disk space in Megabytes.
 */
+ (double)xyd_availableDiskSpace;

+ (BOOL)xyd_fileExist:(NSString *)path;
+ (unsigned long long)xyd_fileSizeForPath:(NSString *)path;
+ (float)xyd_folderSizeAtPath:(NSString*) folderPath;
+ (NSString *)xyd_getFileSizeWithByteCounts:(long long)byteCounts;
+ (BOOL)xyd_createFile:(NSString *)path;
+ (void)xyd_createDirectoryIfNeeded:(NSString *)path;
+ (BOOL)xyd_removeFile:(NSString *)path;
+ (void)xyd_clearFileInPath:(NSString *)path;
+ (BOOL)xyd_deleteFilesInDirectory:(NSString *)dirPath moreThanDays:(NSInteger)numberOfDays;
+ (BOOL)xyd_writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset;
+ (NSData *)xyd_isValidResumeData:(NSData *)data;

@end
