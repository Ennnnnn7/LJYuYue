//
//  LJNetWorkTool.m
//  yuyue
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJNetWorkTool.h"

@implementation LJNetWorkTool
+ (instancetype)sharedNetworkTools
{
    static LJNetWorkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
//        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURL *url = nil;
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        instance.res
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}
@end
