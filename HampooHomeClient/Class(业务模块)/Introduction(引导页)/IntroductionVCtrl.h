//
//  IntroductionVCtrl.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/7.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "BaseVCtrl.h"

@interface IntroductionVCtrl : BaseVCtrl

typedef void (^DidIntroFinishBlock)();

@property (copy,nonatomic) DidIntroFinishBlock didIntroFinishBlock;

@end
