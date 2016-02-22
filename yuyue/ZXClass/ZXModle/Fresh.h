//
//  Fresh.h
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fresh : NSObject

//最新视频

//视频封面图片
@property(nonatomic ,copy) NSString *cdn_img;
@property(nonatomic ,copy) NSString *image_small;

//发表时间
@property(nonatomic ,copy) NSString *created_at;
//视频高度
@property(nonatomic ,copy) NSString *height;
//视频宽度
@property(nonatomic ,copy) NSString *width;

//ID
@property(nonatomic ,assign)NSInteger ID;

//视频标题
@property(nonatomic ,copy) NSString *text;
//视频网址
@property(nonatomic ,copy) NSString *videouri;
//视频长度
@property(nonatomic ,copy) NSString *videotime;

//播放次数
@property(nonatomic ,assign) NSInteger playcount;


//视频服务器建议名字
@property(nonatomic ,copy) NSString *videoName;

//是否收藏
@property(nonatomic ,assign) BOOL isCollect;

//是否下载
@property(nonatomic ,assign) BOOL isDownload;

//是否播放
@property(nonatomic ,assign) BOOL isPlay;

@property(nonatomic ,strong) NSIndexPath *index;
@property(nonatomic ,assign) NSInteger row;

//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)freshWithDict:(NSDictionary *)dict;
+ (NSArray *)freshlistArray:(NSMutableArray *)array;

@end











