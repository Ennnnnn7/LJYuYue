//
//  UserInfo.h
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UserInfo;
// 委托代理
@protocol UserInfoDelegate <NSObject>
- (void)userInfo:(UserInfo *)userInfo select:(BOOL)isLogin;
@end

// 单例类 用来获取用户登陆状态
@interface UserInfo : NSObject
@property (nonatomic,assign) BOOL isLogin; // 是否登陆
@property (nonatomic,assign) id<UserInfoDelegate> delegate;
@property (nonatomic,strong) UIImage *headImage;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *headImageUrl;
@property(nonatomic , assign)BOOL isJudge;

@property (nonatomic,assign) BOOL isLoadImage;

+ (UserInfo *)sharedUserInfo;

@end
