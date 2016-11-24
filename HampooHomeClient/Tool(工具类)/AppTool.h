//
//  AppTool.h
//  ShopApp
//
//  Created by xiong有都 on 15/11/4.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class FileData;

/**
 *  与程序相关的工具方法
 */
@interface AppTool : NSObject

+ (UIButton *)getBtnImageN:(NSString *)imageN target:(id)target action:(SEL)selector;
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft;
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector frame:(CGRect)frame isLeft:(BOOL)isLeft;
+ (UIButton *)getNavigationBtnImage:(UIImage *)btnImage target:(id)target action:(SEL)selector frame:(CGRect)frame;
+ (void)setLeftNaviMenuItem:(UIViewController *)ctrl;
+ (FileType)getFileTypeWithFileName:(NSString *)fileName isFolder:(BOOL)isFolder;
+ (UIImage *)getIconImageWithFileType:(FileType)fileType;

@end
