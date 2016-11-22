//
//  LTCilentUser.m
//  LTClient
//
//  Created by Frank on 16/10/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "LTCilentUser.h"

@implementation LTCilentUser
- (id)initWithLtid:(NSString *)ltid andNickName:(NSString *)nickName andState:(int)state
{
    if (self = [super init]) {
        self.ltid = ltid;
        self.nickName = nickName;
        self.state = state;
    }
    return self;
}


- (id)initWithId:(NSInteger)i_d andLtid:(NSString *)ltid andNickName:(NSString *)nickName andState:(NSInteger)state
{
    if(self = [super init]){
        self.i_d = i_d;
        self.ltid = ltid;
        self.nickName = nickName;
        self.state = state;
    }
    return self;
}

@end

