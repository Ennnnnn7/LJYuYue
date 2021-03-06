//
//  LJHomeTableViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJHomeTableViewController.h"
#import "LJModel.h"
#import "UserInfo.h"
#import "MJRefresh.h"
#import "FileHandle.h"
#import "LJNewsCell.h"
#import "MJExtension.h"
#import "LJNetWorkTool.h"
#import "LJTopImageCell.h"
#import "LJLongImageCell.h"
#import "LJThreeImagesCell.h"
#import "NavigationViewController.h"
#import "LJNewsDetailViewController.h"

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import "FavoriteTableViewController.h"
#import "REFrostedViewController.h"



//网络判断
#import "AFNetworking.h"


@interface LJHomeTableViewController ()
//@property (nonatomic,strong) NSMutableData *newsData;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSMutableArray *anotherListArray;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) UIImageView *rightHeadImageView;
@end

@implementation LJHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![UserInfo sharedUserInfo].isJudge) {
        [self changeInternet];
        [UserInfo sharedUserInfo].isJudge = YES;
    }
    [self changeSomeControl];
    [self refresh];
   
}

#pragma mark - /************************* tbv数据源方法 ***************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJModel *model = self.listArray[indexPath.row];
    if (model.hasHead) {
        return [LJTopImageCell addLJTopImageCellWithTableView:tableView model:model];
    }else if (model.imgType){
        return [LJLongImageCell addLJLongImageCellWithTableView:tableView model:model];
    }else if (model.imgextra){
        return [LJThreeImagesCell addLJThreeImagesCellWithTableView:tableView model:model];
    }else{
        return [LJNewsCell addLJNewsCellWithTableView:tableView model:model];
    }
}

#pragma mark - /************************* tbv代理方法 ***************************/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForRow:self.listArray[indexPath.row]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LJNewsDetailViewController *newsDetailVC = [[LJNewsDetailViewController alloc] init];
    LJModel *model = self.listArray[indexPath.row];
    
    // 顶部图片的网址
    if (model.skipID != nil)
    {
        NSString *newString = [model.skipID stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
        NSString *newUrl = [NSString stringWithFormat:@"http://ent.163.com/photoview/%@.html",newString];
        model.url_3w = newUrl;
    }
    
    // 本地 plist 存在即为收藏
    if ([UserInfo sharedUserInfo].isLogin) {
        if ([[FileHandle fileHandle] foundNewsForID:model.docid]) {
            model.isFavorite = YES;
        }
    }
    // 传值推出下一界面
    newsDetailVC.newsModel = model;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}


#pragma mark - 刷新数据
// 上拉刷新和下拉刷新
- (void)refresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.header = header;

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"点击或者上拉加载" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在努力加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了！" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
    // 设置footer
    self.tableView.footer = footer;
    
}

#pragma mark - 网络代理解析数据
// 上拉刷新解析数据
- (void)loadNewData
{
    NSString *string = @"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html";
    [self loadDataForType:1 withURL:string];
}

// 下拉刷新解析数据
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1348648517839/%lu-20.html",(self.listArray.count - self.listArray.count%10)];
    [self loadDataForType:2 withURL:allUrlstring];
}

// 解析方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    [[[LJNetWorkTool sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
//        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray *arrayM = [LJModel objectArrayWithKeyValuesArray:temArray];
                if (type == 1) {
                    self.listArray = arrayM;
                    [self.tableView reloadData];
                    [self.tableView.header endRefreshing];
                }else if(type == 2){
                    [self.listArray addObjectsFromArray:arrayM];
                    [self.tableView reloadData];
                    [self.tableView.footer endRefreshing];
                }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}


#pragma mark - =========== 选择 cell 与 行高==============

- (CGFloat)heightForRow:(LJModel *)model
{
    if (model.hasHead){
//        return 245;
        return KScreenHeight * 0.36;
    }else if(model.imgType) {
//        return 170;
        return KScreenHeight * 0.25;
    }else if (model.imgextra){
//        return 130;
        if (KScreenHeight * 0.2 < 130) {
            return 130;
        }else{
            return KScreenHeight * 0.2;
        }
    }else{
//        return 100;
        if (KScreenHeight * 0.15 < 100) {
            return 100;
        }else
        {
            return KScreenHeight * 0.15;
        }
    }
}

#pragma mark - 改变navigationcontroller 一些控件
- (void)changeSomeControl
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"娱 悦";

        // 修改 title 字体 颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0],NSFontAttributeName,nil]];
    
    // navigationItem左按钮点击执行展示菜单
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_list_icn_order"] style:UIBarButtonItemStylePlain target:(NavigationViewController *)self.navigationController action:@selector(showMenu)];
    
    // navigationItem右按钮点击登陆
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style: UIBarButtonItemStylePlain target:self action:@selector(loginUser)];
    // 注册登陆成功观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRightItem) name:UserSuccessLogin object:nil];
    
    // 注册注销成功观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRightItem) name:UserSuccessCancel object:nil];
    
    if ([UserInfo sharedUserInfo].isLogin == YES) {
        [self changeRightItem];
    }
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)loginUser
{
    if ([UserInfo sharedUserInfo].isLogin == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:naVC animated:YES completion:nil];
    }else
    {
        // 跳转到收藏界面
        FavoriteTableViewController *favoriteVC = [[FavoriteTableViewController alloc] init];
        NavigationViewController *navigationVC = [[NavigationViewController alloc] initWithRootViewController:favoriteVC];
        self.frostedViewController.contentViewController = navigationVC;
        [self.frostedViewController hideMenuViewController];
    }
    
}

- (void)changeRightItem
{
    
    _rightHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _rightHeadImageView.layer.cornerRadius = 20;
    _rightHeadImageView.layer.masksToBounds = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightHeadImageView];
    
    
    if ([UserInfo sharedUserInfo].isLogin == YES) {
        [MBProgressHUD showMessage:nil toView:self.rightHeadImageView];
        NSURL *url = [NSURL URLWithString:[UserInfo sharedUserInfo].headImageUrl];
        [_rightHeadImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [MBProgressHUD hideHUDForView:self.rightHeadImageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginUser)];
            [self.rightHeadImageView addGestureRecognizer:tap];
        }];
    }else
    {
        [_rightHeadImageView removeFromSuperview];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style: UIBarButtonItemStylePlain target:self action:@selector(loginUser)];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
        [UserInfo sharedUserInfo].isLoadImage = NO;
        [self loadNewData];
    }
}

#pragma mark - 网络变化检测
- (void)changeInternet {
    
    //建立网络状态监控类 , 单例
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 当网络状态发生改变的时候调用这个block
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                self.state = @"您当前为WIFI连接";
                [self judgeInternet];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                self.state = @"您当前网络为数据流量";
                [self judgeInternet];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                self.state = @"您当前无网络连接,请设置";
                [self judgeInternet];
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                self.state = @"您当前为未知网络，请检查网络是或否安全";
                [self judgeInternet];
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

//*******************
- (void)judgeInternet {
    //初始化AlertView
    
    UIAlertView *tishi = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:self.state
                                          delegate:self
                                 cancelButtonTitle:@"确认"
                                 otherButtonTitles: nil, nil];
    //显示AlertView
    [tishi show];
}




@end
