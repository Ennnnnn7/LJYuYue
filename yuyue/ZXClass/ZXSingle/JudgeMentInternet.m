//
//  JudgeMentInternet.m
//  提示框测试两次判断(一次提示一次网络判断)
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "JudgeMentInternet.h"
#import "AFNetworking.h"

static JudgeMentInternet *judgeMent;

@implementation JudgeMentInternet

+ (JudgeMentInternet *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        judgeMent = [[JudgeMentInternet alloc]init];
    });
    return judgeMent;
}


//MARK:--监测网络变化
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
//网络变化检测
- (void)changeInternet {
    
    //建立网络状态监控类 , 单例
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 当网络状态发生改变的时候调用这个block
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                self.isWifi = YES;
                self.status = @"Wifi";
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                self.isWifi = NO;
                self.status = @"data";
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:{
                self.isWifi = NO;
                self.status = @"nointernet";
            }
                break;
                
            case AFNetworkReachabilityStatusUnknown:{
                self.isWifi = NO;
                self.status = @"unknowinternet";
            }
                break;
            default:
                break;
        }
    }];
    
    // 开始监控
    [mgr startMonitoring];
}

//如果控制器没了 , 就不再监控
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


@end
