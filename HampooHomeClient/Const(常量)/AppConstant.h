//
//  AppConstant.h
//  MiniPC
//
//  Created by xiongyoudou on 16/4/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FileType) {
    FileTypeFolder,                 // 文件夹
    FileTypeImage,                  // 图片
    FileTypeTxt,                    // 文本
    FileTypeMicroWord,              // word
    FileTypeMicroExcel,             // excel
    FileTypePPT,                    // ppt
    FileTypeZip,                    // zip
    FileTypeMovie,                  // 视频
    FileTypeAudio,                  // 音频
    FileTypeRar,                    // rar
    FileTypeHtml,                   // html
    FileTypeSqlite,                 // 数据库文件
    FileTypeUnknown,                // 未知
};

@interface AppConstant : NSObject

// 登录令牌
extern NSString *myToken;

@end
