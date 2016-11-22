//
//  ScanPhotoesViewCtrl.m
//  JiaXiaoTong
//
//  Created by xiongyoudou on 14-1-17.
//  Copyright (c) 2014年 xiongyoudou. All rights reserved.
//

#import "ScanPhotoesViewCtrl.h"
#import "XYDBottomBarCell.h"

@interface ScanPhotoesViewCtrl () {
    UIBarButtonItem *doneButton;
}
@end

@implementation ScanPhotoesViewCtrl

//下面两个方法为IOS6.0及以后方法
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (id)init {
    if ([super init]) {
        _dataDictArr = [NSMutableArray array];
        _photoesArray = [NSMutableArray array];
        _thumbsArray = [NSMutableArray array];
    }
    return self;
}

// 大部分图片浏览器操作都有同样的配置，如某属性不一样，在此方法后面重置
-(void)initByDelegate {
    self.delegate = self;
    self.displayActionButton = NO;      // 不显示分享按钮
    self.displayNavArrows = NO;         // 不显示左箭头、右箭头来切换上下图片的按钮
    self.displaySelectionButtons = YES; // 是否在图片上显示打钩的图片按钮
    self.alwaysShowControls = NO;       // 时刻显示控件，不会自动消失
    self.zoomPhotosToFill = NO;         // 自动收缩图片以显示完整图片
    self.isShowGridBtn = NO;            // 不显示grid按钮
    self.isScrollToBottom = YES;        // 自动滚动到底部
    self.delayToHideElements = NSIntegerMax;      // 工具栏不会每隔几秒之后隐藏
}


- (void)viewDidLoad{
    [super viewDidLoad];
    _selections = [NSMutableArray new];
    for (int i = 0; i < self.photoesArray.count; i++) {
    //存储图片是否选择的数组，利用所有的默认数据初始化
        [_selections addObject:[NSNumber numberWithBool:NO]];
    }
}


// 重置此方法，设置导航栏颜色
- (void)setNavBarAppearance:(BOOL)animated {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor blackColor];
    navBar.shadowImage = nil;
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleBlackTranslucent;
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    navBar.shadowImage = nil;
}

// 重载父类的方法
- (BOOL)isShowGridBtn {
    return self.enableGrid && _isShowGridBtn;
}

#pragma mark - MWPhotoBrowserDelegate，所有的数据代理方法

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photoesArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    //大图数据代理方法
    if (index < self.photoesArray.count) {
        MWPhoto *photo = self.photoesArray[index];
        return photo;
    }
    return nil;
}

//小图数据代理方法
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.thumbsArray.count) {
       return self.thumbsArray[index];
    }
    return nil;
}

- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
    return nil;
}

//图片已经展示之后进入此方法
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
}

//判断当前图片是否选中
- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//当某一张图片视图的选中状态发生改变时，进入此代理方法
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];//数组个数是确定的，直接替换就好
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (UIBarButtonItem *)photoBrowserRightTopBarItem:(MWPhotoBrowser *)photoBrowser {
    if ([self isShowingGrid]) {
        doneButton = [self getRightTopBarItemWithTitle:@"全选"];
        return doneButton;
    }else {
        // 直接返回nil，右上角按钮居然还在，因此只隐藏文字。
        doneButton = [self getRightTopBarItemWithTitle:@""];
        return doneButton;
    }
}

- (UIBarButtonItem *)photoBrowserBackBarItem:(MWPhotoBrowser *)photoBrowser {
    UIButton *backBtn = [AppTool getBtnImageN:@"nav_back" target:self action:@selector(clickBackBtn)];
    backBtn.frame = CGRectMake(0,0,10,44);
    return [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (UIBarButtonItem *)getRightTopBarItemWithTitle:(NSString *)title {
   UIBarButtonItem  *barItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(title, nil) style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];//在图片一张都没有选中的时候，右上角按钮文字显示“取消”，当选中至少一张之后，按钮文字变为“确定”
    barItem.tintColor = [UIColor whiteColor];
    // Set appearance
    if ([UIBarButtonItem respondsToSelector:@selector(appearance)])
    {
        [barItem setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
        [barItem setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsCompact];
        [barItem setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateHighlighted];
    }
    return barItem;
}

- (NSArray *)photoBrowserToolBarItems:(MWPhotoBrowser *)photoBrowser {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpace.width = 32; // To balance action button
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    XYDBottomBarCell *downloadCell = [self getBottomBtnWithTitle:@"下载" imageName:@"white_download" action:@selector(downloadImage)];
    downloadCell.textLabel.textColor = COLOR(136, 136, 136, 1.0);
    XYDBottomBarCell *deleteCell = [self getBottomBtnWithTitle:@"删除" imageName:@"white_delete" action:@selector(deleteImage)];
    deleteCell.textLabel.textColor = COLOR(136, 136, 136, 1.0);
    UIBarButtonItem *downloadItem = [[UIBarButtonItem alloc] initWithCustomView:downloadCell];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithCustomView:deleteCell];
    switch (_fromWhichKind) {
        case FromLocalTransport: {
            return @[flexSpace,deleteItem,flexSpace];
        }break;
        case FromServerDropBox: {
            return @[flexSpace,downloadItem,fixedSpace,deleteItem,flexSpace];
        }break;
        default:break;
    }
    return nil;
}

- (XYDBottomBarCell *)getBottomBtnWithTitle:(NSString *)title imageName:(NSString *)imageName action:(SEL)action {
    XYDBottomBarCell *cell = (XYDBottomBarCell *)[MyTool getNibViewByNibName:@"XYDBottomBarCell"];
    [cell.backgroundBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [cell configWithBarData:[XYDBottomBarData getBarDataWith:title imageName:imageName ctrl:nil]];
    return cell;
}


// 下载
- (void)downloadImage {
    NSDictionary *dataDict = _dataDictArr[self.currentIndex];
    if (_downloadDataBlcok) {
        _downloadDataBlcok(dataDict);
    }
}

// 删除
- (void)deleteImage {
    if (_dataDictArr.count > self.currentIndex) {
        NSDictionary *dataDict = _dataDictArr[self.currentIndex];
        if (_deleteDataBlock) {
            _deleteDataBlock(dataDict);
        }
    }
}


// 点击右上角全选按钮
- (void)doneButtonPressed {
    if (![self isShowingGrid])return;
    // 刷新当前显示的cell
    [self selectAllCell];
    doneButton = [self getRightTopBarItemWithTitle:self.isSelectAll ? @"全不选" : @"全选"];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    for (int i = 0;i < [[self photoesArray] count];i ++) {
        [self photoBrowser:self photoAtIndex:i selectedChanged:self.isSelectAll];
    }
}


- (CGRect)frameForToolbarAtOrientation:(UIInterfaceOrientation)orientation {
    CGFloat height = 44;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
//        UIInterfaceOrientationIsLandscape(orientation)) height = 32;
    return CGRectIntegral(CGRectMake(0, [self frameForBrowserView].size.height - height, self.view.bounds.size.width, height));
}

- (void)deleteCurrentPhoto {
    [_dataDictArr removeObjectAtIndex:self.currentIndex];
    [_thumbsArray removeObjectAtIndex:self.currentIndex];
    [_photoesArray removeObjectAtIndex:self.currentIndex];
    if (_photoesArray.count) {
        [self reloadData];
    }else {
        [[DialogTool sharedInstance]modifyTextOnTextHud:@"所有文件完成" dismissAfterDelay:kHudDelay andWorkDone:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)dealloc {
    KMyLog(@"Scan Photo Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
