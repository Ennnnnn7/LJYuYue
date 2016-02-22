//
//  BJPictureTableViewCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJPictureTableViewCell.h"
#import "BJPicture.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "MBProgressHUD+MJ.h"
#import "Masonry.h"
#import "UserInfo.h"
#import "FileHandle.h"

#define bMakeSize [self makeSize]

@interface BJPictureTableViewCell () <UserInfoDelegate>

@property (nonatomic , copy ) NSString *cdn_img;
@property (nonatomic , copy ) NSString *text;
@property (nonatomic , copy ) NSString *gifFistFrame;

@property (nonatomic , assign ) NSInteger height;
@property (nonatomic , assign ) NSInteger is_gif;
@property (nonatomic , assign ) NSInteger width;
@property (nonatomic , assign ) NSInteger t;

@property (nonatomic , strong ) UILabel *textlable;
@property (nonatomic , strong ) UIImageView *picview;
@property (nonatomic , strong ) UILabel *timelable;
@property (nonatomic , strong ) UILabel *contentlable;
@property (nonatomic , strong ) UIView *cover;
@property (nonatomic , strong ) UIImageView *gifview;
@property (nonatomic , strong ) UIImageView *bigimageview;
@property (nonatomic , strong ) UIScrollView *bigScroll;
@property (nonatomic , strong ) UIActivityIndicatorView *circleLoadView;
@property (nonatomic , strong ) UIView *view;

@property (nonatomic , strong ) UIButton *lovebutton;

@property (nonatomic , strong) NSThread *thread1;
@end

@implementation BJPictureTableViewCell
+ (instancetype)setPictureCell:(UITableView *)tableview{
    static NSString *cellID = @"picture";
    BJPictureTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BJPictureTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view = [[UIView alloc]init];
        self.view.layer.cornerRadius = 4;
        self.view.layer.masksToBounds = YES;
        self.view.layer.borderWidth = 1;
        
        self.textlable = [[UILabel alloc]init];
        self.textlable.numberOfLines = 0;
        [self.view addSubview:self.textlable];
        
        self.lovebutton = [[UIButton alloc]init];
        [self.lovebutton addTarget:self action:@selector(love) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.lovebutton];
        
        self.timelable = [[UILabel alloc]init];
        self.timelable.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.timelable];
        
        //设置 cell 中 image 的属性
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(look)];
        self.picview = [[UIImageView alloc]init];
        self.picview.layer.cornerRadius = 4;
        self.picview.layer.masksToBounds = YES;
        [self.picview addGestureRecognizer:tap];
        self.picview.userInteractionEnabled = YES;
        [self.picview setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:self.picview];
        
        self.contentlable = [[UILabel alloc]init];
        self.contentlable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.contentlable.layer.cornerRadius = 4;
        self.contentlable.layer.masksToBounds = YES;
        self.contentlable.textColor = [UIColor whiteColor];
        self.contentlable.textAlignment = NSTextAlignmentCenter;
        [self.picview addSubview:self.contentlable];
        
        
        [self addSubview:self.view];
    }
    return self;
}
#pragma mark - 点击 love 实现；
- (void)love{
    
    if ([UserInfo sharedUserInfo].isLogin) {
        [self login];
    }
    
    if (![UserInfo sharedUserInfo].isLogin) {
        self.loveblock();
        [UserInfo sharedUserInfo].delegate = self;
    }
    
}

- (void)userInfo:(UserInfo *)userInfo select:(BOOL)isLogin{
    [self login];
}

- (void)login{
    if (![UserInfo sharedUserInfo].isLogin){
        return ;
    };
    
    self.picture.islove = !self.picture.islove;
    
    if (self.picture.islove) {
        if (!self.picture.gifFistFrame) {
            NSDictionary *dic = @{ @"text":self.picture.text , @"t":@(self.picture.t) ,@"cdn_img":self.picture.cdn_img,@"height":@(self.picture.height) ,@"is_gif":@(self.picture.is_gif) ,@"width":@(self.picture.width) ,@"id":@(self.picture.ID)};
            [[FileHandle fileHandle] addPictureInFileDic:dic ID:self.picture.ID];
        }else{
            NSDictionary *dic = @{ @"text":self.picture.text , @"t":@(self.picture.t) ,@"cdn_img":self.picture.cdn_img,@"gifFistFrame":self.picture.gifFistFrame ,@"height":@(self.picture.height) ,@"is_gif":@(self.picture.is_gif) ,@"width":@(self.picture.width) ,@"id":@(self.picture.ID)};
            [[FileHandle fileHandle] addPictureInFileDic:dic ID:self.picture.ID];
        }
    }else {
        [[FileHandle fileHandle] removePictureForID:self.picture.ID];
    }
    self.reloadblock();
}

#pragma mark - 加载数据
//设置数据
- (void)setPicture:(BJPicture *)picture{
    _picture = picture;
    __weak typeof(self) weakSelf = self;
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(5);
        make.right.and.bottom.mas_equalTo(-5);
    }];
    [self.textlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(5);
        make.height.mas_equalTo(180);
        make.width.mas_equalTo((kScreenWidth-20)/2);
    }];
    [self.lovebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(weakSelf.textlable.mas_bottom);
        make.width.mas_equalTo(40);
        make.bottom.mas_equalTo(-5);
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lovebutton.mas_right);
        make.top.equalTo(weakSelf.textlable.mas_bottom);
        make.right.equalTo(weakSelf.picview.mas_left).offset(-5);
        make.bottom.mas_equalTo(-5);
    }];
    [self.picview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo((kScreenWidth-20)/2);
        make.top.mas_equalTo(5);
        make.left.mas_equalTo((kScreenWidth-20)/2);
    }];
    [self.contentlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    if ([UserInfo sharedUserInfo].isLogin) {
        if ([[FileHandle fileHandle] foundPicturesForID:self.picture.ID]) {
            self.picture.islove = YES;
        }
    }
    
    self.textlable.text = picture.text;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:picture.t];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    self.timelable.text = [myFormatter stringFromDate:date];
    self.timelable.font = [UIFont systemFontOfSize:12];
    
    self.is_gif = picture.is_gif;
    self.width = picture.width;
    self.height = picture.height;
    self.cdn_img = picture.cdn_img;
    
    if (self.picture.islove) {
        [self.lovebutton setImage:[UIImage imageNamed:@"redheart"] forState:(UIControlStateNormal)];
    } else {
        [self.lovebutton setImage:[UIImage imageNamed:@"whiteheart"] forState:(UIControlStateNormal)];
    }

    if (picture.is_gif) {
        self.contentlable.hidden = NO;
        [self.picview sd_setImageWithURL:[NSURL URLWithString:picture.gifFistFrame]];
        self.contentlable.text = @"GIF";
    }else{
        [self.picview sd_setImageWithURL:[NSURL URLWithString:picture.cdn_img]];
        self.contentlable.hidden = YES;
    }
    
}
#pragma mark - 点击图片后实现
//懒加载菊花转
- (UIActivityIndicatorView *)circleLoadView{
    if (!_circleLoadView) {
        _circleLoadView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
        [_circleLoadView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _circleLoadView;
}
//懒加载背景
- (UIView *)cover{
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.superview.superview.window addSubview:_cover];
        _cover.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(look)];
        [_cover addGestureRecognizer:tap];
        self.circleLoadView.center = self.superview.center;
        [_cover addSubview:self.circleLoadView];
        _cover.alpha = 0.0;
    }
    return _cover;
}
- (void)chengeCover{
    self.cover.alpha = 0.5;
    [self.circleLoadView startAnimating];
}

//懒加载大图
- (UIImageView *)bigimageview{
    if (!_bigimageview) {
        _bigimageview = [[UIImageView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(look)];
        [_bigimageview addGestureRecognizer:tap];
        _bigimageview.userInteractionEnabled = YES;
    }
    return _bigimageview;
}
- (UIScrollView *)bigScroll{
    if (!_bigScroll) {
        _bigScroll = [[UIScrollView alloc]init];
        _bigScroll.bounces = NO;
        _bigScroll.backgroundColor = [UIColor whiteColor];
    }
    return _bigScroll;
}

// 多线程加载数据
- (NSThread *)thread1{
    if (!_thread1) {
        _thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(loadData) object:nil];
    }
    return _thread1;
}
//放大查看的方法
- (void)look{
    if (self.cover.alpha == 0.0) {
        // 设置背景
//        self.superview.superview.window.userInteractionEnabled = NO;
        [self chengeCover];
        // 加载数据
        [self.thread1 start];//开启
    }else{
        [self.thread1 cancel];
        self.thread1 = nil;
        [self.circleLoadView stopAnimating];
        if (_bigScroll) [self.bigScroll removeFromSuperview] , self.bigScroll = nil ;
        if (_bigimageview) [self.bigimageview removeFromSuperview] , self.bigimageview = nil;
        if (_gifview) [self.gifview removeFromSuperview] , self.gifview = nil;
        self.cover.alpha = 0.0;
    }
}

#pragma mark - 数据加载；
- (void)loadData{
    
        NSURL *url = [NSURL URLWithString:self.cdn_img];
        self.bigimageview.frame =CGRectMake(0, 0,bMakeSize.width,bMakeSize.height);
        
        if (self.is_gif) {
            self.bigimageview.center = CGPointMake(self.cover.bounds.size.width / 2, self.cover.bounds.size.height / 2 - 30);
            NSData *data = [[NSData alloc]initWithContentsOfURL:url];
            
            self.bigimageview.image = [UIImage sd_animatedGIFWithData:data];
            [self.circleLoadView stopAnimating];
            [self.superview.superview.window addSubview:self.bigimageview];
            
        }else{
            
            [self.bigimageview sd_setImageWithURL:url];
            
            if (bMakeSize.height <= KScreenHeight - 100 ) {
                self.bigimageview.center = CGPointMake(self.cover.bounds.size.width / 2, self.cover.bounds.size.height / 2 - 30);
                [self.circleLoadView stopAnimating];
                [self.superview.superview.window addSubview:self.bigimageview];
                
            }else{
                self.bigScroll.frame = CGRectMake(0, 64, bMakeSize.width, KScreenHeight - 100);
                self.bigScroll.center = CGPointMake(self.cover.bounds.size.width / 2, self.cover.bounds.size.height / 2 - 30);
                self.bigScroll.contentOffset = CGPointMake(0, 0);
                self.bigScroll.contentSize = bMakeSize;
                [self.bigimageview sd_setImageWithURL:url];
                [self.bigScroll addSubview:self.bigimageview];
                
                [self.circleLoadView stopAnimating];
                [self.superview.superview.window addSubview:self.bigScroll];
            }
        }
    
    [self.thread1 cancel];//关闭
    self.thread1 = nil;
//    self.superview.superview.window.userInteractionEnabled = YES;
}
// 设置宽高
- (CGSize)makeSize{
    CGFloat tatle = kScreenWidth - 20;
    CGFloat W = self.width ;
    CGSize size = CGSizeMake(self.width, self.height);
    if (W >= tatle) {
        CGFloat H = tatle * self.height / W ;
        size = CGSizeMake(tatle, H);
    }
    return size;
}


@end
