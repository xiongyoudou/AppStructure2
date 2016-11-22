//
//  AppTool.m
//  ShopApp
//
//  Created by xiong有都 on 15/11/4.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import "AppTool.h"
#import "UIButton+XYDBlock.h"
#import "LeftSlideViewController.h"
#import "NSObject+XYDAssociatedObject.h"

@implementation AppTool

// 根据图片生成按钮
+ (UIButton *)getBtnImageN:(NSString *)imageN {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    return leftBtn;
}

+ (UIButton *)getBtnImageN:(NSString *)imageN target:(id)target action:(SEL)selector {
    UIButton *leftBtn = [self getBtnImageN:imageN];
    [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return leftBtn;
}

/**
 *  生成导航栏右侧的操作按钮(按钮一般为两个字正好符合下面指定的尺寸)
 *
 *  @param title    按钮内容
 *  @param target   按钮的代理对象
 *  @param selector 按钮执行的方法
 *
 *  @return 返回生成的对象
 */
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft {
    return [self getNaviBarBtn:title target:target action:selector frame:CGRectMake(0, 0, 48, 34) isLeft:isLeft];
}

/**
 *  生成标题式导航栏按钮
 *
 *  @param title    标题
 *  @param target   点击事件的处理者
 *  @param selector 点击后调用方法
 *  @param frame    尺寸
 *
 *  @return 返回按钮
 */
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector frame:(CGRect)frame isLeft:(BOOL)isLeft {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, isLeft ? -5: 0, 0, isLeft ? 0: -5)];
    btn.frame = frame;
    return btn;
}

// 生成图片式样的导航栏按钮
+ (UIButton *)getNavigationBtnImage:(UIImage *)btnImage target:(id)target action:(SEL)selector frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    btn.frame = frame;
    return btn;
}


// 设置控制器导航栏左测的menu
+ (void)setLeftNaviMenuItem:(UIViewController *)ctrl {
    UIButton *menuBtn = [AppTool getNavigationBtnImage:[UIImage imageNamed:@"menu"] target:nil action:nil frame:CGRectMake(0, 0, 20, 18)];
    [menuBtn xyd_addActionHandler:^(NSInteger tag) {
        LeftSlideViewController *slideVCtrl = [self getSlideViewController:ctrl];
        if (slideVCtrl.closed){
            [slideVCtrl openLeftView];
        }else{
            [slideVCtrl closeLeftView];
        }
    }];
    ctrl.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}

+ (LeftSlideViewController *)getSlideViewController:(UIViewController *)ctrl {
    if (!ctrl.tabBarController)return nil;
    LeftSlideViewController *sliderVCtrl = [ctrl.tabBarController xyd_associatedValueForKey:(__bridge const void *)(kLeftSliderVCtrlAssociateObjectKey)];
    return sliderVCtrl;
}

/**
 *  返回文件类型
 *
 *  @param fileName 文件名
 *  @param isFolder 是否是文件夹
 *
 *  @return 文件类型
 */
+ (FileType)getFileTypeWithFileName:(NSString *)fileName isFolder:(BOOL)isFolder {
    if(isFolder) {
        // 文件夹
        return FileTypeFolder;
    }else {
        NSString *pathExtension = [fileName pathExtension];
        if (!pathExtension)return FileTypeUnknown;
        if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"jpg"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"gif"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"png"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"jpeg"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"jpg"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"gif"]) {
            // 图片类型
            return FileTypeImage;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"txt"]) {
            return FileTypeTxt;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"doc"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"docx"]) {
            return FileTypeMicroWord;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"xlsx"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"xls"]) {
            return FileTypeMicroExcel;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"ppt"]) {
            return FileTypePPT;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"zip"]) {
            return FileTypeZip;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"mp4"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"avi"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"mov"]) {
            return FileTypeMovie;
        }else if ([MyTool isEqualCaseInsensitive:pathExtension withStr:@"mp3"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"wav"] || [MyTool isEqualCaseInsensitive:pathExtension withStr:@"wma"]) {
            return FileTypeAudio;
        }else if ([pathExtension isEqualToString:@"rar"]) {
            return FileTypeRar;
        }else if ([pathExtension isEqualToString:@"html"]) {
            return FileTypeHtml;
        }else if ([pathExtension isEqualToString:@"sqlite"] || [pathExtension isEqualToString:@"db"]) {
            return FileTypeSqlite;
        }else {
            return FileTypeUnknown;
        }
    }
}

/**
 *  根据文件类型返回文件所应显示的ICon图标
 *
 *  @param fileType 文件类型
 *
 *  @return 返回对应图片对象
 */
+ (UIImage *)getIconImageWithFileType:(FileType)fileType {
    switch (fileType) {
        case FileTypeFolder:return KFileFolderIcon;
        case FileTypeImage:return KFileImageIcon;
        case FileTypeTxt:return KFileTxtIcon;
        case FileTypeMicroWord:return KFileMicroWordIcon;
        case FileTypeMicroExcel:return KFileMicroExcelIcon;
        case FileTypePPT:return KFilePPTIcon;
        case FileTypeZip:return KFileZipIcon;
        case FileTypeMovie:return KFileMovieIcon;
        case FileTypeAudio:return KFileAudioIcon;
        case FileTypeRar:return KFileRarIcon;
        case FileTypeHtml:return KFileHtmlIcon;
        case FileTypeSqlite:return KFileSqlIcon;
        case FileTypeUnknown:return KFileUnknownIcon;
        default:return KFileUnknownIcon;
    }
}


@end
