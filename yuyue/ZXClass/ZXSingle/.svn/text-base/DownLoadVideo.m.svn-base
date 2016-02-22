//
//  DownLoadVideo.m
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DownLoadVideo.h"



static DownLoadVideo *downLoadVideoSingle = nil;


@interface DownLoadVideo()

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSURLSession *session;

@end


@implementation DownLoadVideo

+ (DownLoadVideo *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        downLoadVideoSingle = [[DownLoadVideo alloc]init];
        
    });
    return downLoadVideoSingle;
}

//MARK:--下载
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (void)change:(NSString *)str{
    
    
    if ([str isEqualToString:@"NO"]) {
        [self.task cancel];
        self.task = nil;
        NSLog(@"取消下载  - %@" , str);
    } else {
        [self start:str];
        NSLog(@"正在下载- %@" , str);
    }
}



/**
 *  从零开始
 */
- (void)start:(NSString *)str
{
    
    // 1.得到session对象
    self.session = [NSURLSession sharedSession];
    // 2.创建一个下载task
    NSURL *url = [NSURL URLWithString:str];
    self.task = [_session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        //创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        //拿到 caches 的路径
        NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) [0];
        //在 caches 后面拼接 Video 路径
        NSString *video = [caches stringByAppendingPathComponent:@"Video"];
        //用caches-- video 的路径创建文件夹 Video 文件夹
        [mgr createDirectoryAtPath:video withIntermediateDirectories:YES attributes:nil error:nil];
        
        //用 caches-- video 的路径 , 创建下载的 MP4文件的路径 , 就在后面拼接
        //创建文件的文件名 ,  response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
        NSString *file = [video stringByAppendingPathComponent:response.suggestedFilename];

       
        // AtPath : 剪切前的文件路径
        // ToPath : 剪切后的文件路径
        if (self.task) {
            [mgr moveItemAtPath:location.path toPath:file error:nil];
            
            self.pushName(response.suggestedFilename);//Block返回视频名字
            //可在这里设置标志位
            self.didDownload = YES;
            NSLog(@"下载成功 , 并且转到 Video");
        }
 
    }];
    
    // 3.开始任务
    [self.task resume];
    
}



@end
