//
//  HotVideoListTableViewCell.m
//  yuyue
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HotVideoListTableViewCell.h"
#import "Fresh.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "JudgeMentInternet.h"
#import "DownLoadVideo.h"
#import "UserInfo.h"
#import "FileHandle.h"

#define leftEdge 20

@interface HotVideoListTableViewCell()<UserInfoDelegate>

//判断是否下载的对话框
@property(nonatomic ,strong) UIAlertView *downLoad;
//判断网络状态的对画框
@property(nonatomic ,strong) UIAlertView *internet;

@end


@implementation HotVideoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    //调用单例
    JudgeMentInternet *judgeMent = [JudgeMentInternet defaultInstance];
    //判断网络
    [judgeMent changeInternet];
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //标题
        _text = [[UILabel alloc]init];
        //行数为0 ,是自动换行
        _text.numberOfLines = 0 ;
        _text.font = [UIFont fontWithName: @"Helvetica-Bold"size:13];
        [self.contentView addSubview:_text];
        
        
        //收藏
        _collect = [[UIButton alloc]init];
        [_collect setBackgroundImage:[UIImage imageNamed:@"whiteheart"] forState:UIControlStateNormal];
        [_collect addTarget:self action:@selector(collect:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_collect];
        
        //视频封面
        _cdn_img = [[UIImageView alloc]init];
        [self.contentView addSubview:_cdn_img];
        _play = [[UIButton alloc]init];
        [_play addTarget:self action:@selector(play:) forControlEvents:(UIControlEventTouchUpInside)];
        [_play setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.contentView addSubview:_play];
        
        
        //视频时长
        _videotime = [[UILabel alloc]init];
        _videotime.font = [UIFont fontWithName: @"Helvetica-Bold"size:13];
        [self.contentView addSubview:_videotime];
        
        //播放次数
        _playcount = [[UILabel alloc]init];
        _playcount.font = [UIFont fontWithName: @"Helvetica-Bold"size:13];
        [self.contentView addSubview:_playcount];
    }
    return self;
}

//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
//用modle赋值
- (void)setFresh:(Fresh *)fresh {
    
    _fresh = fresh;
    
    if ([UserInfo sharedUserInfo].isLogin) {
        if ([[FileHandle fileHandle] foundVideoForID:_fresh.ID]) {
            _fresh.isCollect = YES;
        }
    }
    
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    //约束
    //标题 + 发布时间
    NSString *strTime = [fresh.created_at substringFromIndex:5];
    NSString *str = [NSString stringWithFormat:@"%@ - %@" ,strTime, fresh.text];
    
    _text.text = str;
    //标题约束
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftEdge); //据最左面
        make.top.mas_equalTo(8);  //据上面
        make.right.mas_equalTo(-35); //具右面 , 为负值
        make.height.mas_equalTo(30);
    }];
    
    //收藏
    if (_fresh.isCollect) {
        [_collect setBackgroundImage:[UIImage imageNamed:@"redheart"] forState:UIControlStateNormal];
        
    }else{
        [_collect setBackgroundImage:[UIImage imageNamed:@"whiteheart"] forState:UIControlStateNormal];
    }
    //收藏约束
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //图片
    
    [self.cdn_img sd_setImageWithURL:[NSURL URLWithString:fresh.image_small]];
    [_cdn_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftEdge);
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-30);
        
    }];
    
    // 视频时长
    int time = [fresh.videotime intValue];
    int timeMin = time /60 ;
    int timeSec = time - timeMin * 60 ;
    if (timeSec < 10) {
        _videotime.text = [NSString stringWithFormat:@"时长 %d:0%d",timeMin ,timeSec + 1];
    }else{
        _videotime.text = [NSString stringWithFormat:@"时长 %d:%d",timeMin ,timeSec + 1];
    }

    //视频长度
    [_videotime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(leftEdge);
        make.bottom.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
    
    //热度
    _playcount.text = [NSString stringWithFormat:@"热度:%ld",fresh.playcount];
    [_playcount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.bottom.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    
    //播放按钮
    [_play mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.center.equalTo(self.contentView);
    }];
    
}

//播放按钮
- (void)play:(UIButton *)button {
    self.movieBlockHot(_fresh.videouri);
}


//MARK:--收藏下载逻辑判断
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※//
//收藏按钮
- (void)collect:(UIButton *)button {
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    
    DownLoadVideo *downLoadVideoSingle = [DownLoadVideo defaultInstance];
    
    
    if (![UserInfo sharedUserInfo].isLogin) {
        self.loginBlockHot();
        [UserInfo sharedUserInfo].delegate = self;
        
    }else{
        [self collected];
        if ( _fresh.isCollect) {
            NSLog(@"进入下载提示框");
            [self judgeDownLoadalert];
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        }else{//取消收藏
            //判断是否下载完毕 , 如果是就从沙盒删除
            if (downLoadVideoSingle.didDownload) {
                NSLog(@"从沙盒中删除 , 还没有写 , 视频名字%@",self.fresh.videoName);
                [self removeFile];
                downLoadVideoSingle.didDownload = NO;
                _fresh.isDownload = NO;
            }
            
            //判断是否正在下载 , 如果是,就取消下载
            if (self.fresh.isDownload == 1) {
                [self cancelDownload];
                self.downBlockHot(@"NO");
                NSLog(@"取消下载");
                
            }else{
                self.reloadDataBlockHot();
            }
        }
    }

}
- (void)userInfo:(UserInfo *)userInfo select:(BOOL)isLogin {
    
    [self collected];
    self.fresh.isCollect = NO;
}

/************/
- (void)collected {
    _fresh.isCollect = !_fresh.isCollect ;

    if (_fresh.isCollect) {

  NSDictionary *dic =@{ @"text":self.fresh.text , @"videouri":self.fresh.videouri , @"videotime":self.fresh.videotime , @"playcount":@(self.fresh.playcount), @"image_small":self.fresh.image_small , @"ID":@(self.fresh.ID),@"height":self.fresh.height,@"width":self.fresh.width,@"created_at":self.fresh.created_at };


        [[FileHandle fileHandle] addVideoInFileDic:dic ID:_fresh.ID];
        
    }else {
        [[FileHandle fileHandle] removeVideoForID:_fresh.ID];
    }

}

//MARK:--删除文件
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (void)removeFile {
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //拿到 caches 的路径
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) [0];
    //在 caches 后面拼接 Video 路径
    NSString *video = [caches stringByAppendingPathComponent:@"Video"];
    //找到文件路径
    NSString *file = [video stringByAppendingPathComponent:self.fresh.videoName];
    
    [mgr removeItemAtPath:file error:nil];
}

//MARK:--提示框1:判断是否下载
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※//
- (void)judgeDownLoadalert {
    //初始化AlertView
   _downLoad = [[UIAlertView alloc] initWithTitle:@"收藏成功"
                                           message:@"是否将该视频下载到本地"
                                          delegate:self
                                 cancelButtonTitle:@"谢谢不用!"
                                 otherButtonTitles:@"好的", nil];
    //显示AlertView
    [_downLoad show];

}


//MARK:--提示框2:判断网络状态以及下载
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※//
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == _downLoad) {
        //调用网络判断单例
        JudgeMentInternet *judgeMent = [JudgeMentInternet defaultInstance];
        
        NSLog(@"下载的网络状态%@" , judgeMent.status);
        
        //对话框判断
        if(_internet == nil){
            
            if (buttonIndex == 1) {
                
                if (judgeMent.isWifi) {
                    NSLog(@"开始下载");
                    self.fresh.isDownload = YES;//确认下载
                    self.downBlockHot(_fresh.videouri);
                    //接收返回视频的名字
                    [DownLoadVideo defaultInstance].pushName = ^(NSString *str){
                        self.fresh.videoName = str;
                    };
    
                } else{
                    [self judgeInternet:judgeMent.status];
                }
            }else{
                NSLog(@"第一个对话框取消");
                self.reloadDataBlockHot();
                self.fresh.isDownload = NO;//确认下载
            }
            
        }else{
            self.internet = nil;
            
            if([judgeMent.status isEqualToString:@"nointernet"]){
                NSLog(@"不管点那个都没用");
                self.fresh.isDownload = NO;
                
            } else{
                if (buttonIndex == 1) {
                    NSLog(@"直接下");
                    //接收返回视频的名字
                    [DownLoadVideo defaultInstance].pushName = ^(NSString *str){
                        self.fresh.videoName = str;
                    };
                    self.fresh.isCollect = YES;
                    self.downBlockHot(_fresh.videouri);
                    self.fresh.isDownload = YES;//确认下载
                    
                }else{
                    NSLog(@"不下载");
                    
                }
            }
            
        }
        
    }else {
        NSLog(@"nimade");
    }
    
}
//MARK:--提示框3:取消下载
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※//

- (void)cancelDownload {
    //初始化AlertView
    UIAlertView *cancel = [[UIAlertView alloc]init];
    cancel = [[UIAlertView alloc] initWithTitle:@"取消收藏"
                                      message:@"下载任务已被取消"
                                     delegate:nil
                            cancelButtonTitle:@"确定"
                            otherButtonTitles: nil, nil];
    //显示AlertView
    [cancel show];
}


//MARK:--网络判断
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//

- (void)judgeInternet:(NSString *)str{
    NSString *massage = [[NSString alloc]init];
    
    if([str isEqualToString:@"data"]){
        massage = @"您现在的网络状态为数据流量 ,不是WIFI 环境 ,是否继续下载?";
        //初始化AlertView
        _internet = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:massage
                                              delegate:self
                                     cancelButtonTitle:@"谢谢不用!"
                                     otherButtonTitles:@"下载", nil];
    }
    if([str isEqualToString:@"nointernet"]){
        massage = @" 没有网络连接, 请检查网络!!";
        //初始化AlertView
        _internet = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:massage
                                              delegate:self
                                     cancelButtonTitle:@"稍后再试"
                                     otherButtonTitles:@"马上去设置网络", nil]; //编号1
    }
    if([str isEqualToString:@"unknowinternet"]){
        massage = @"您现在的网络状态是未知网络,是否继续下载?";
        //初始化AlertView
        _internet = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:massage
                                              delegate:self
                                     cancelButtonTitle:@"谢谢不用!"
                                     otherButtonTitles:@"下载", nil];
    }
    
    //显示AlertView
    [_internet show];
}


@end
