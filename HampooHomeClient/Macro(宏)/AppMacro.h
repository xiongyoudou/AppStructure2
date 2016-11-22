//
//  AppMacro.h
//  MiniPC
//
//  Created by xiongyoudou on 16/4/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define KNotFirstLoad @"notFirstLoad"
#define KNavBarColor COLOR(20,155,255,1)
#define KSectionBGColor COLOR(235,235,235,1)
#define KConnectedDeviceId @"connectedDeviceId"
#define KMyPassword @"myPassword"
#define KMyToken @"myToken"
#define KIsAutoBackUp @"isAutoBackUp"
#define KCoreDataAutoIncreaseNum @"coreDataAutoIncreaseNum"
#define KTagDefine 1000

#define KDownloadPath   [NSString stringWithFormat:@"%@/downloadPath",kCachesPath] // 下载文件后放置的路径
#define KUploadTempPath [NSString stringWithFormat:@"%@/uploadTempPath",kCachesPath] // 上传文件时需要将相册图片/视频暂时存放在沙盒中，成功之后暂时不清除，因为可能需要本地浏览，手动删除时再清除

// 最近的自动备份的时间
#define KLatestAutoBackupTime @"latestAutoBackupTime"

// 文件夹类型Icon
#define KFileFolderIcon [UIImage imageNamed:@"list_folder"]
// 图片类型
#define KFileImageIcon [UIImage imageNamed:@"list_photo"]
// txt文本类型
#define KFileTxtIcon [UIImage imageNamed:@"list_txt"]
// word类型
#define KFileMicroWordIcon [UIImage imageNamed:@"list_word"]
// excel类型
#define KFileMicroExcelIcon [UIImage imageNamed:@"list_excel"]
// ppt类型
#define KFilePPTIcon [UIImage imageNamed:@"list_ppt"]
// zip压缩包类型
#define KFileZipIcon [UIImage imageNamed:@"list_zip"]
// 视频类型
#define KFileMovieIcon [UIImage imageNamed:@"list_video"]
// 音频类型
#define KFileAudioIcon [UIImage imageNamed:@"list_audio"]
// Rar压缩包类型
#define KFileRarIcon [UIImage imageNamed:@"list_rar"]
// html类型
#define KFileHtmlIcon [UIImage imageNamed:@"list_html"]
// 数据库文件类型
#define KFileSqlIcon [UIImage imageNamed:@"list_sql"]
// 未知文件类型
#define KFileUnknownIcon [UIImage imageNamed:@"list_unknown"]

#endif /* AppMacro_h */
