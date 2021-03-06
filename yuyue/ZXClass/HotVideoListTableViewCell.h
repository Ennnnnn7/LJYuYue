//
//  HotVideoListTableViewCell.h
//  yuyue
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@class Fresh;
typedef void(^MyBlock)();
typedef void(^MovieBlock)(NSString *str);

@interface HotVideoListTableViewCell : UITableViewCell  <UIAlertViewDelegate>



@property(nonatomic ,strong) UILabel *text;  //视频标题
@property(nonatomic ,strong) UIButton *collect; //收藏按钮
@property(nonatomic ,strong) UIImageView *cdn_img; //视频封面图
@property(nonatomic ,strong) UILabel *created_at; //发表时间
@property(nonatomic ,strong) UILabel *videotime; //视频长度
@property(nonatomic ,strong) UILabel *playcount; //播放次数


//Modle
@property(nonatomic ,strong) Fresh *fresh;

//视频播放按钮
@property(nonatomic ,strong) UIButton *play;

//block回调空 ,只用来实现方法
@property(nonatomic ,copy) MyBlock reloadDataBlockHot;
@property(nonatomic ,copy) MyBlock loginBlockHot;
@property(nonatomic ,copy) MovieBlock movieBlockHot;
@property(nonatomic ,copy) MovieBlock downBlockHot;

@end