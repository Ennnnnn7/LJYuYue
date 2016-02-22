//
//  DownLoadVideo.h
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DownLoadVideo;
typedef void(^MovieNameBlock)(NSString *str);


@interface DownLoadVideo : NSObject

//是否下载完成
@property(nonatomic ,assign) BOOL didDownload;

@property(nonatomic ,copy) MovieNameBlock pushName;


+ (DownLoadVideo *)defaultInstance;

- (void)change:(NSString *)str;


@end
