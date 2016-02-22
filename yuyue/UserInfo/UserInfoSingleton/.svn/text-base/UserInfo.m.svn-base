//
//  UserInfo.m
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo *)sharedUserInfo
{
    static UserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfo alloc] init];
    });
    return userInfo;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLogin = NO; // 初始状态为未登录状态
    }
    return self;
}


@end
