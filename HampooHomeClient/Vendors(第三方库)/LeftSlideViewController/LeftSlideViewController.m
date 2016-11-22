//
//  LeftSlideViewController.m
//  LeftSlideViewController
//
//  Created by huangzhenyu on 15/06/18.
//  Copyright (c) 2015年 huangzhenyu. All rights reserved.

#import "LeftSlideViewController.h"


@interface LeftSlideViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat _scalef;  //实时横向位移
}

@property (nonatomic,strong) UIView *leftOperateV;      //侧边栏需要控制缩放，偏移的视图
@property (nonatomic,strong) UIView *leftMaskView;      //左侧蒙版
@property (nonatomic,strong) UIView *rightMaskView;     //右侧蒙版
@end


@implementation LeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 @brief 初始化侧滑控制器
 @param leftVC 左视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController <LeftSideVCtrlProtocol> *)leftVC andMainView:(UIViewController *)mainVC {
    if(self = [super init]){
        self.speedf = vSpeedFloat;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        [self addChildViewController:self.leftVC];
        [self addChildViewController:self.mainVC];
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        
        self.leftVC.view.hidden = YES;
        
        [self.view addSubview:self.leftVC.view];
        
        //左侧蒙版
        UIView *leftView = [[UIView alloc] init];
        leftView.frame = self.leftVC.view.bounds;
        leftView.backgroundColor = [UIColor blackColor];
        leftView.alpha = 0.5;
        self.leftMaskView = leftView;
        [self.leftVC.view addSubview:leftView];
        
        //右侧蒙版
        UIView *rightView = [[UIView alloc] init];
        rightView.frame = self.leftVC.view.bounds;
        rightView.backgroundColor = [UIColor blackColor];
        rightView.alpha = 0;
        self.rightMaskView = rightView;
        [self.mainVC.view addSubview:rightView];
        
        //获取左侧tableview
//        for (UIView *obj in self.leftVC.view.subviews) {
//            if ([obj isKindOfClass:[UITableView class]]) {
//                self.leftOperateV = (UITableView *)obj;
//            }
//        }
        self.leftOperateV = self.leftVC.view; // 对整个视图（不仅仅是tableview）进行处理
        
        self.leftOperateV.backgroundColor = [UIColor clearColor];
        self.leftOperateV.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, kScreenHeight);
        //设置左侧tableview的初始位置和缩放系数
        self.leftOperateV.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        self.leftOperateV.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        
        [self.view addSubview:self.mainVC.view];
        self.closed = YES;//初始时侧滑窗关闭
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);

    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (kScreenWidth - kMainPageDistance))){
        CGFloat recCenterX = rec.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2) {
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = rec.view.center.y;
        rec.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - kMainPageScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftOperateV.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftOperateV.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.leftMaskView.alpha = tempAlpha;
        
        //tempAlpha kMainPageAlpha~0
        CGFloat mainTempAlpha = kMainPageAlpha * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.rightMaskView.alpha = mainTempAlpha;
    }else{
        //超出范围，
        if (self.mainVC.view.x < 0){
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.mainVC.view.x > (kScreenWidth - kMainPageDistance)){
            [self openLeftView];
            _scalef = 0;
        }
    }
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance){
            if (self.closed){
                [self openLeftView];
            }else{
                [self closeLeftView];
            }
        }else{
            if (self.closed){
                [self closeLeftView];
            }else{
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self.closed = YES;
        
        self.leftOperateV.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        self.leftOperateV.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.leftMaskView.alpha = kLeftAlpha;
        self.rightMaskView.alpha = 0;
        
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.closed = YES;
    
    self.leftOperateV.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
    self.leftOperateV.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    
    self.leftMaskView.alpha = kLeftAlpha;
    self.rightMaskView.alpha = 0;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,kMainPageScale,kMainPageScale);
    self.mainVC.view.center = kMainPageCenter;
    self.closed = NO;
    
    self.leftOperateV.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
    self.leftOperateV.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.leftMaskView.alpha = 0;
    self.rightMaskView.alpha = kMainPageAlpha;
    
    [UIView commitAnimations];
    [self disableTapButton];
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */

- (void)setPanEnabled: (BOOL) enabled
{
    [self.pan setEnabled:enabled];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
//        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
//        NSLog(@"响应侧滑");
        return YES;
    }
}

@end
