//
//  LJNewsDetailViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJNewsDetailViewController.h"
#import "LoginViewController.h"
#import "LJNewsDetailView.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "FileHandle.h"
#import "UserInfo.h"
#import "LJModel.h"

@interface LJNewsDetailViewController ()<MBProgressHUDDelegate,UserInfoDelegate>
@property (nonatomic,strong) NSMutableArray *unarchiverDataArray;
@property (nonatomic,strong) NSMutableArray *ljDataArray;
@property (nonatomic,strong) NSMutableData *archiverData;
@property (nonatomic,strong) UIWebView *newsWebView;
@property (nonatomic,strong) NSData *unarchiverData;
@property (nonatomic,strong) NSString *dataPath;
@property (nonatomic,strong) MBProgressHUD *HUD;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) UIView *loadAView;
@end

@implementation LJNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.newsWebView];
    [self changeNavigationItem];
    [self addLoadHUD];
    self.ljDataArray = [NSMutableArray array];
}

// 修改 NavigationItem
- (void)changeNavigationItem
{
    
    // 左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"night_icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backToHomeVC)];
    
//    // 右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"whiteheart"] style:(UIBarButtonItemStylePlain) target:self action:@selector(collectNews)];
    // 根据是否收藏改变红心颜色
    if (self.newsModel.isFavorite) {
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"redheart"]];
        
    }else
    {
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"whiteheart"]];
    }
    // 设置左右按钮的颜色
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor redColor]];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}

// 添加加载转
- (void)addLoadHUD
{
    // 加载转
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = @"正在加载……";
    [_HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

// 视图懒加载
- (UIWebView *)newsWebView
{
    if (_newsWebView == nil) {
        _newsWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, kScreenWidth, KScreenHeight + 44)];
//        [MBProgressHUD showMessage:@"正在加载……"];
        NSString *string = _newsModel.url_3w;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
        [_newsWebView loadRequest:request];
//        [MBProgressHUD hideHUD];
        _newsWebView.scrollView.bounces = NO;
    }
    return _newsWebView;
}


// pop 到上一个 controller
- (void)backToHomeVC
{
    [self.newsWebView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


// 清楚 Web 缓存
- (void)viewDidDisappear:(BOOL)animated
{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

#pragma mark - 右收藏按钮操作
- (void)collectNews
{
    _userInfo =[UserInfo sharedUserInfo];
    _userInfo.delegate = self;
    if (NO == _userInfo.isLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:naVC animated:YES completion:nil];
    }else // 用户已经登陆过
    {
        [self favoriteNews];
    }
}

- (void)favoriteNews
{
    //【添加操作】
    // 1.用户登陆成功后 执行回调方法 把该活动添加到数据库
    // 添加之前需要对该活动进行判断 如果已经添加 提示已经添加 没有添加 则插入到数据库 并且把 activity 的添加标识改为 yes
    
    // 在数据库中 根据 id 查找是否存在
    // 已经收藏 提示
    if ([[FileHandle fileHandle] foundNewsForID:self.newsModel.docid]) {
        _newsModel.isFavorite = NO;
        [self performSelector:@selector(showMBProgressHUD) withObject:nil afterDelay:0.5];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"whiteheart"]];
        [[FileHandle fileHandle] removeNewsForID:self.newsModel.docid];
    }else // 未收藏 添加到数据库中
    {
        _newsModel.isFavorite = YES;  // 收藏标识
            [self performSelector:@selector(showMBProgressHUD) withObject:nil afterDelay:0.5];
            [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"redheart"]];
        
            NSDictionary *myDict = @{@"title":self.newsModel.title,@"url_3w":self.newsModel.url_3w,@"replyCount":self.newsModel.replyCount,@"digest":self.newsModel.digest,@"imgsrc":self.newsModel.imgsrc,@"docid":self.newsModel.docid};
            [[FileHandle fileHandle] addNewsInFileDic:myDict ID:self.newsModel.docid];
        
    }
}
#pragma mark - hideAlertView:
- (void)hideAlertView:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)showMBProgressHUD
{
    if (self.newsModel.isFavorite) {
        [MBProgressHUD showSuccess:@"收藏成功！"];
    }else
    {
        [MBProgressHUD showSuccess:@"取消收藏成功！"];
    }
    
}

#pragma mark - 加载转设置
// 加载时间为4秒
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(4);
}

// 加载 alert 消失
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}

- (void)userInfo:(UserInfo *)userInfo select:(BOOL)isLogin
{
    [self favoriteNews];
}
@end
