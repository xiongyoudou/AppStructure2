//
//  FileHelper.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/25.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "FileTool.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation FileTool

#pragma mark - 文件读写
//  写文件
+ (void)writeDictDataToPlistFile:(NSMutableDictionary *)aSaveDic fileName:(NSString *)fileName {
    [aSaveDic writeToFile:[self getFileNamePath:fileName] atomically:YES];
}

+ (void)writeDict:(NSDictionary *)dict toPath:(NSString *)filePath {
    BOOL isSuccess = [dict writeToFile:filePath atomically:YES];
    NSLog(@"%d",isSuccess);
}

// 读取文件
+ (NSMutableDictionary *)getPlistFileData:(NSString *)fileName {
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithContentsOfFile:[self getFileNamePath:fileName]];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    return dict;
}

// 存储大文件至沙盒
+ (BOOL)writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset {
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
+ (NSData *)isValidResumeData:(NSData *)data {
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

#pragma mark - 获取文件路径 & 根据路径判断文件是否存在

+ (void)createFilePahtIfNotExists:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //不存在即创建，初始化contents（文件内容）、attributes（文件属性）为nil
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

+ (NSString *)getFileNamePath:(NSString *)fileName {
    NSString * filePath = [kDocumentsPath stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //不存在即创建，初始化contents（文件内容）、attributes（文件属性）为nil
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

// 获取文件夹路径/不存在即创建
+ (NSString *)getFolderNamePath:(NSString *)folderName fileName:(NSString *)fileName PathExtension:(NSString *)pathExtension {
    NSString * folderPath = [kDocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",folderName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        //不存在即创建，初始化contents（文件内容）、attributes（文件属性）为nil
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];;
    }
    if (fileName && pathExtension) {
        return [[folderPath stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:pathExtension];
    } else {
        return folderPath;
    }
}

+ (BOOL)isExistAtDocumentFile:(NSString *)fileName {
    NSString * filePath = [kDocumentsPath stringByAppendingPathComponent:fileName];
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) ? YES : NO;
}

+ (BOOL)isExistAtPath:(NSString *)filePath {
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) ? YES : NO;
}

#pragma  mark - 文件删除
// 沙盒文件删除
+ (void)deleteDocumentFile:(NSString *)fileName
{
    NSString * filePath = [kDocumentsPath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
// 根据沙盒文件路径删除
+ (BOOL)deleteWithContentPath:(NSString *)path
{
    NSError *error=nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:&error];
    }
    if (error) {
        KMyLog(@"删除文件时出现问题:%@",[error localizedDescription]);
        return NO;
    }
    return YES;
}

#pragma mark - 文件大小相关 & 清理缓存

// 根据实际字节大小调整显示内容
+ (NSString *)getFileSizeWithByteCounts:(long long)byteCounts {
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

// 获取路径文件的大小
+ (unsigned long long)fileSizeForPath:(NSString *)path {
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
+ (float)folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeForPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

// 清理缓存
+ (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

@end
