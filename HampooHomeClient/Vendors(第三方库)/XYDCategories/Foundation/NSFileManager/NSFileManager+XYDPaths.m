//
//  NSFileManager+Paths.m

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSFileManager+XYDPaths.h"
#import "HttpTool.h"
#include <sys/xattr.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSFileManager (XYDPaths)

#pragma mark - 读取信息相关方法

/// Base path, all paths depend it
+ (NSString *)xyd_homeDirectoryPath {
#if AV_IOS_ONLY
    return NSHomeDirectory();
#else
    return nil;
#endif
}

+ (NSURL *)xyd_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)xyd_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}


+ (NSURL *)xyd_documentsURL
{
    return [self xyd_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)xyd_documentsPath
{
    return [self xyd_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)xyd_libraryURL
{
    return [self xyd_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)xyd_libraryPath
{
    return [self xyd_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)xyd_cachesURL
{
    return [self xyd_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)xyd_cachesPath
{
    return [self xyd_pathForDirectory:NSCachesDirectory];
}

+ (NSString *)MIMEType:(NSString *)filePathOrName {
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePathOrName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    
    CFRelease(UTI);
    return MIMEType ? (__bridge_transfer NSString *)MIMEType : @"application/octet-stream";
}

+ (NSString *)MIMETypeFromPath:(NSString *)fullPath
{
    NSURL* fileUrl = [NSURL fileURLWithPath:fullPath];
    NSURLRequest* fileUrlRequest = [[NSURLRequest alloc] initWithURL:fileUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:.1];
    NSError* error = nil;
    NSURLResponse* response = nil;
    [HttpTool sendSynchronousRequest:fileUrlRequest returningResponse:&response error:&error];
    NSString* mimeType = [response MIMEType];
    return mimeType;
}

+(NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

+ (NSString*)MD5ForFile:(NSString*)filePath {
    
    int chunkSizeForReadingData=1024*8;
    CFReadStreamRef readStream = NULL;
    
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) return nil;
    
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,fileURL);
    if (!readStream) return nil;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) return nil;
    
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    didSucceed = !hasMoreData;
    
    NSString *result = nil;
    if (didSucceed) {
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5_Final(digest, &hashObject);
        
        char hash[2 * sizeof(digest) + 1];
        for (size_t i = 0; i < sizeof(digest); ++i) {
            snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
        }
        result = [NSString stringWithCString:(const char *)hash encoding:NSUTF8StringEncoding];
    }
    
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

+ (NSString*)SHAForFile:(NSString *)filePath {
    int chunkSizeForReadingData=1024*8;
    return [self SHAForFile:filePath chunkSizeForReadingData:chunkSizeForReadingData];
}

+ (NSString*)SHAForFile:(NSString *)filePath chunkSizeForReadingData:(size_t)chunkSizeForReadingData {
    
    CFReadStreamRef readStream = NULL;
    
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) return nil;
    
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,fileURL);
    if (!readStream) return nil;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) return nil;
    
    
    // Initialize the hash object
    CC_SHA1_CTX hashObject;
    CC_SHA1_Init(&hashObject);
    
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_SHA1_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    didSucceed = !hasMoreData;
    
    NSString *result = nil;
    if (didSucceed) {
        unsigned char digest[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1_Final(digest, &hashObject);
        
        char hash[2 * sizeof(digest) + 1];
        for (size_t i = 0; i < sizeof(digest); ++i) {
            snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
        }
        result = [NSString stringWithCString:(const char *)hash encoding:NSUTF8StringEncoding];
    }
    
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}


// 防治iCloud自动同步该路径
+ (BOOL)xyd_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

// 可用磁盘空间
+ (double)xyd_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.xyd_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

+ (BOOL)xyd_fileExist:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

// 获取路径文件的大小
+ (unsigned long long)xyd_fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float)xyd_folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self xyd_fileSizeForPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


// 根据实际字节大小调整显示内容
+ (NSString *)xyd_getFileSizeWithByteCounts:(long long)byteCounts {
    NSString *fileSize;
    CGFloat fsize = byteCounts / 1024.0;
    if (fsize <= 1024) {
        fileSize = [NSString stringWithFormat:@"%.1fKB",fsize];
    }else {
        fsize = fsize / 1024.0;
        if (fsize <= 1024) {
            fileSize = [NSString stringWithFormat:@"%.1fM",fsize];
        }else {
            fsize = fsize / 1024.0;
            fileSize = [NSString stringWithFormat:@"%.1fG",fsize];
        }
    }
    return fileSize;
}


#pragma mark - 操作文件/路径 相关方法
+ (BOOL)xyd_createFile:(NSString *)path
{
    BOOL ret = [[NSFileManager defaultManager] createFileAtPath:path contents:[NSData data] attributes:nil];
    return ret;
}

+ (void)xyd_createDirectoryIfNeeded:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

+ (BOOL)xyd_removeFile:(NSString *)path
{
    NSError * error = nil;
    BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    return ret;
}

// 清理某个路径下的文件
+ (void)xyd_clearFileInPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}


// 移除某个路径下面的文件，该文件有超过numberOfDays的时间没有被使用（修改）
+ (BOOL)xyd_deleteFilesInDirectory:(NSString *)dirPath moreThanDays:(NSInteger)numberOfDays {
    BOOL success = NO;
    NSDate *nowDate = [NSDate date];
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:dirPath error:&error];
    if (error == nil) {
        for (NSString *path in directoryContents) {
            NSString *fullPath = [dirPath stringByAppendingPathComponent:path];
            NSDate *lastModified = [self lastModified:fullPath];
            if ([nowDate timeIntervalSinceDate:lastModified] < numberOfDays * 24 * 3600)
                continue;
            
            BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
            if (!removeSuccess) {
                NSLog(@"remove error happened");
                success = NO;
            }
        }
    } else {
        NSLog(@"remove error happened");
        success = NO;
    }
    
    return success;
}

// 存储Asset大文件至沙盒
+ (BOOL)xyd_writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset {
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (!handle) {
        return NO;
    }
    static const NSUInteger BufferSize = 1024*1024;
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    uint8_t *buffer = calloc(BufferSize, sizeof(*buffer));
    NSUInteger offset = 0, bytesRead = 0;
    do {
        @try {
            bytesRead = [rep getBytes:buffer fromOffset:offset length:BufferSize error:nil];
            [handle writeData:[NSData dataWithBytesNoCopy:buffer length:bytesRead freeWhenDone:NO]];
            offset += bytesRead;
        } @catch (NSException *exception) {
            free(buffer);
            return NO;
        }
    } while (bytesRead > 0);
    free(buffer);
    return YES;
}

// 验证resumeData是否依旧有效
+ (NSData *)xyd_isValidResumeData:(NSData *)data {
    if (!data || [data length] < 1) return nil;
    NSError *error;
    NSDictionary *resumeDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (!resumeDictionary || error) return nil;
    NSString *localFilePath = [resumeDictionary objectForKey:@"NSURLSessionResumeInfoLocalPath"]; // ios8上有该字段
    if ([localFilePath length] < 1) {
        NSString *tempFileName = [resumeDictionary objectForKey:@"NSURLSessionResumeInfoTempFileName"]; // ios9上有该字段
        localFilePath = [NSString stringWithFormat:@"%@/%@",kTempPath,tempFileName];
        if (localFilePath.length < 1) {
            return nil;
        }
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
        return isExists ? data : nil;
    }else {
        // 如果有该路径，需要将绝对路径替换成每次生成的路径
        NSString *tempFileName = [MyTool getRearStrOn:localFilePath byDeleteStr:@"/tmp/"];
        localFilePath = [NSString stringWithFormat:@"%@%@",kTempPath,tempFileName];
        [resumeDictionary setValue:localFilePath forKey:@"NSURLSessionResumeInfoLocalPath"];
        NSData *newResumeData = [NSPropertyListSerialization dataWithPropertyList:resumeDictionary format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
        return newResumeData;
    }
}

#pragma mark - private methods

// 获取指定路径文件的修改日期
// assume the file is exist
+ (NSDate *)lastModified:(NSString *)fullPath {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:NULL];
    return [fileAttributes fileModificationDate];
}


@end
