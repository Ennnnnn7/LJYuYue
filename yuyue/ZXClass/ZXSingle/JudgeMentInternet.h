//
//  JudgeMentInternet.h
//  提示框测试两次判断(一次提示一次网络判断)
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JudgeMentInternet;

@interface JudgeMentInternet : NSObject

@property(nonatomic ,assign) BOOL isWifi;
@property(nonatomic ,strong) NSString *status;

+ (JudgeMentInternet *)defaultInstance;
- (void)changeInternet;
@end
