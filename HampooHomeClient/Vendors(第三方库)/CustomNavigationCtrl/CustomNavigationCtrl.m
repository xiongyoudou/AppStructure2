//
//  CustomNavigationCtrl.m
//  自我提高大杂烩
//
//  Created by iMac on 14-10-17.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import "CustomNavigationCtrl.h"

@interface CustomNavigationCtrl ()<UINavigationControllerDelegate> {
    
}

@end

@implementation CustomNavigationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//将某个视图作为导航栏视图控制器的根视图，并返回该导航栏视图控制器
+ (CustomNavigationCtrl *)configNavigationCtrlwithRootVC:(UIViewController *)vc andImageName:(UIImage *)barBackgroundImage OrColor:(UIColor *)barBackColor {
    CustomNavigationCtrl *navCtrl = [[CustomNavigationCtrl alloc] initWithRootViewController:vc];
    if (barBackgroundImage) {
        [navCtrl.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
    }else {
        [[UINavigationBar appearance] setBarTintColor:barBackColor];//设置导航栏背景的颜色
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//设置比如返回按钮字体的颜色
    }
    
    //设置标题的颜色
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:19], NSFontAttributeName, nil]];
    
    return navCtrl;
}


#pragma mark 拦截push过程, 隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // PS:[[UINavigationController alloc] initWithRootViewController:vc];过程实质上也是push, 所以下面要加个判断
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
