//
//  LTCilentUser.h
//  LTClient
//
//  Created by Frank on 16/10/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTCilentUser : NSObject
/** 用户id */
@property (nonatomic,assign)NSInteger i_d;
/** 长牙id */
@property (nonatomic,strong)NSString *ltid;
/** 昵称 */
@property (nonatomic,strong)NSString *nickName;
/** 状态 */
@property (nonatomic,assign)NSInteger state;

-(id)initWithLtid:(NSString *)ltid andNickName:(NSString *)nickName andState:(int)state;

-(id)initWithId:(NSInteger)i_d andLtid:(NSString *)ltid andNickName:(NSString *)nickName andState:(NSInteger)state;

@end
