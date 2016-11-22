//
//  ScanPhotoesViewCtrl.h
//  JiaXiaoTong
//
//  Created by xiongyoudou on 14-1-17.
//  Copyright (c) 2014年 xiongyoudou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

// 本来为了封装的考虑，不应在此耦合此属性，但问题也不大
typedef NS_ENUM(NSInteger,FromWhichKind){
    FromServerDropBox,      // 从网盘中进入
    FromLocalTransport,     // 从本地传输记录进入
};

// 删除网盘文件/删除传输记录文件
typedef void (^DeleteDataBlock)(id data);

@interface ScanPhotoesViewCtrl : MWPhotoBrowser<MWPhotoBrowserDelegate> {
     NSMutableArray *_selections;
}
// 大图
@property (nonatomic,strong) NSMutableArray *photoesArray;
// 预览图
@property (nonatomic,strong) NSMutableArray *thumbsArray;

// 该数组存储的是用于下载/删除操作必须的参数字典
@property (nonatomic,strong) NSMutableArray *dataDictArr;

// 第一张图片是否动画形式出现/最后一张图片是否动画形式消失
@property (nonatomic,assign) BOOL isAnimateOnAppearAndDisAppear;
// 允许选择的最大图片数量
@property (nonatomic,assign) NSUInteger maxSelectedCount;
// gid样式时是否显示左下角grid按钮
@property (nonatomic,assign) BOOL isShowGridBtn;
@property (nonatomic,assign) FromWhichKind fromWhichKind;
@property (nonatomic,copy) DeleteDataBlock deleteDataBlock;
@property (nonatomic,copy) void (^downloadDataBlcok)(id data);

- (void)initByDelegate;
- (void)deleteCurrentPhoto;

@end
