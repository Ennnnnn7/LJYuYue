//
//  HotVideoListViewController.h
//  yuyue
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "NavigationViewController.h"
#import "SisterViewController.h"
#import "FreshVideoListTableViewCell.h"
#import "Fresh.h"
#import "MJRefresh.h"
#import "DownLoadVideo.h"
#import "LoginViewController.h"


@interface SisterViewController () <UITableViewDelegate , UITableViewDataSource>

//最新视频列表
@property (strong, nonatomic) UITableView *freshVideoListTableView;

//数据数组
@property(nonatomic ,strong) NSMutableArray *freshVideoListArray;
// cell 实例
@property(nonatomic ,strong) FreshVideoListTableViewCell *freshCell;

//上拉刷新计数
@property(nonatomic ,assign) int upCount;


@end


@implementation SisterViewController


- (void)viewDidLoad {
    
    NSLog(@"%@",NSHomeDirectory());
    [super viewDidLoad];
    
    
    
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    _freshVideoListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    self.freshVideoListTableView.delegate = self;
    self.freshVideoListTableView.dataSource = self;
    //取消 cell线
    self.freshVideoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_freshVideoListTableView];

#pragma mark -- MJ下拉刷新
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的 刷新的方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupRefresh)];
    
    // 设置文字
    [header setTitle:@"向下拉动刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开释放" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.freshVideoListTableView.header = header;
    
#pragma mark -- MJ上拉加载
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    
//    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.freshVideoListTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [footer setTitle:@"点击或者上拉加载" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在努力加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了！" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
    // 设置footer
    self.freshVideoListTableView.footer = footer;

    
}


//MARK:--下拉刷新
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//

- (void)setupRefresh {
    //解析数据
    _upCount = 20;
    [self resolve:@"http://api.budejie.com/api/api_open.php?a=newlist&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=20&sub_flag=1&type=41&udid=&ver=3.6"];
    
    [self.freshVideoListTableView reloadData];
    
}
//MARK:--上拉加载
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (void)loadNewData{
    _upCount += 10 ;
    NSLog(@"%d",_upCount);
    //解析数据
    [self resolve:[NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?a=newlist&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=%d&sub_flag=1&type=41&udid=&ver=3.6",_upCount]];

}

- (NSMutableArray *)freshVideoListArray{
    if (!_freshVideoListArray) {
        _freshVideoListArray = [NSMutableArray array];
    }
    return _freshVideoListArray;
}

//MARK:--数据解析
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//

- (void)resolve:(NSString *)str {
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; // NSLog(@"1%@" , request);
    NSOperationQueue *queue= [NSOperationQueue mainQueue];  //NSLog(@"2%@" , queue);
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         
         //没网时
         if (connectionError || data == nil) {
             return;
         }
         
         NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         [self.freshVideoListArray removeAllObjects];
         [self.freshVideoListArray addObjectsFromArray:[Fresh freshlistArray:dataDic[@"list"]]];
         
         
         // 拿到当前的下拉刷新控件，结束刷新状态
         [self.freshVideoListTableView.footer endRefreshing];
         [self.freshVideoListTableView.header endRefreshing];
         [self.freshVideoListTableView reloadData];
         if (_upCount >=30) {
             [self.freshVideoListTableView.footer noticeNoMoreData];
         }
     }];
}


//MARK:--TableView
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
//cell 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.freshVideoListArray.count;
}

// cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int height = [((Fresh *)self.freshVideoListArray[indexPath.row]).height intValue];
    int width = [((Fresh *)self.freshVideoListArray[indexPath.row]).width intValue];
    
    if ((height * (kScreenWidth-40) /(width+1)) >= (kScreenWidth-25)) {
        return  (height * (kScreenWidth-100) / (width+1)) + 70;
    }else{
        return  (height * (kScreenWidth-40) / (width+1)) + 70;
    }
    
}


//cell重用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *freshcell = @"freshYES";
    self.freshCell = [tableView dequeueReusableCellWithIdentifier:freshcell];
    if (self.freshCell == nil) {
        self.freshCell = [[FreshVideoListTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:freshcell];
    }

    self.freshCell.fresh = self.freshVideoListArray[indexPath.row];
    
    
    
    
    //消除点击 Cell 的阴影
    UIView *clear = [[UIView alloc]initWithFrame:_freshCell.frame];
    clear.backgroundColor = [UIColor whiteColor];
    _freshCell.selectedBackgroundView = clear;
    
    
    /**********************************************/
    __weak typeof(self) weakSelf = self;
    
    self.freshCell.loginBlock = ^{
        LoginViewController *lovc = [[LoginViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:lovc];
        [weakSelf.navigationController presentViewController:navc animated:YES completion:nil];
    };
    self.freshCell.reloadDataBlock = ^{
        [weakSelf.freshVideoListTableView reloadData];
    };
    
    
    //下载
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    DownLoadVideo *down = [DownLoadVideo defaultInstance];
    self.freshCell.downBlock = ^(NSString *str){
        [weakSelf.freshVideoListTableView reloadData];
        NSLog(@"进入下载 Block");
        [down change:str];
        
    };
    //播放
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    
    self.freshCell.movieBlock = ^(NSString *str){
        NSLog(@"%@",str);
        NSURL *url = [NSURL URLWithString:str];
        weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];;
        [weakSelf.playerVC.moviePlayer setScalingMode:(MPMovieScalingModeNone)];
        [weakSelf.playerVC.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        [weakSelf.playerVC.moviePlayer.backgroundView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]];
        [weakSelf.playerVC.moviePlayer.backgroundView setFrame:weakSelf.view.bounds];
        // 注册一个播放结束的通知
        [[NSNotificationCenter defaultCenter]addObserver:weakSelf selector:@selector(end:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        // 弹出模态窗口(全屏)，播放视频。
        [weakSelf presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
        // 用play 方法，电影播放控制器会自动将视图切换到电影播放器并开始播放
        [weakSelf.playerVC.moviePlayer play];
    };
    
    return self.freshCell;
}


//播放完成自己移除
- (void)end:(id)sender
{
    //移除播放通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.playerVC.view removeFromSuperview];
    self.playerVC = nil;// 释放资源
}
//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
