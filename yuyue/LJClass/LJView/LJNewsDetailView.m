//
//  LJNewsDetailView.m
//  yuyue
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJNewsDetailView.h"

@implementation LJNewsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _newsWebView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _newsWebView.backgroundColor = [UIColor blueColor];
        [self addSubview:_newsWebView];
        
        
        
        
    }
    return self;
}

+(LJNewsDetailView *)ljNewsDetailViewWithFrame:(CGRect)frame
{
    return [[LJNewsDetailView alloc] initWithFrame:frame];
}



@end
