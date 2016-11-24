//
//  IntroductionVCtrl.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/7.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "IntroductionVCtrl.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"

@interface IntroductionVCtrl ()<EAIntroDelegate>

@end

@implementation IntroductionVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initIntroductionView];
}

// 初始化引导页
- (void)initIntroductionView {
    UIView *rootView = self.view;
    
    BOOL isIphone4 = KWindowSize.height==480?YES:NO;
    BOOL isIphone5 = KWindowSize.height==568?YES:NO;
    NSMutableArray *pageArr = [NSMutableArray array];
    for (int i = 1;i <= 5;i++){
        NSString *imageName;
        if (isIphone4){
            imageName = [NSString stringWithFormat:@"%d_launch-4h",i];
        }else if (isIphone5){
            imageName = [NSString stringWithFormat:@"%d_launch-5h",i];
        }
        else{
            imageName = [NSString stringWithFormat:@"%d_launch",i];
        }
        EAIntroPage *page = [EAIntroPage page];
        //        page.bgImage = [UIImage imageNamed:imageName];//不能设置为背景图片，因为背景图片不会有滑动效果，而是渐进效果
        page.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        page.titleIconPositionY = 0;
        [pageArr addObject:page];
    }
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:pageArr];
    intro.pageControlY = 20;
    intro.scrollView.bounces = NO;
    
    intro.skipButton.hidden = YES;
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if (self.didIntroFinishBlock) {
        self.didIntroFinishBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
