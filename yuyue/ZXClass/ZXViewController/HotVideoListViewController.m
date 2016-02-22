//
//  HotVideoListViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HotVideoListViewController.h"
#import "HotVideoListTableViewCell.h"
#import "Fresh.h"
#import "MJRefresh.h"
#import "DownLoadVideo.h"
#import "LoginViewController.h"


@interface HotVideoListViewController ()<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic ,strong) UITableView *hotVideoListTableView;


//数据源数组
@property(nonatomic ,strong) NSMutableArray *hotVideoListArray;

//CELL
@property(nonatomic ,strong) HotVideoListTableViewCell *hotCell;

//上拉计数
@property(nonatomic ,assign) int upCount;


@end

@implementation HotVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //解析数据
    [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=20&sub_flag=1&type=41&udid=&ver=3.6"];
    
    //配置 tableView
    _hotVideoListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 69, kScreenWidth, KScreenHeight-69)];
    self.hotVideoListTableView.delegate = self;
    self.hotVideoListTableView.dataSource = self;
    //取消 cell线
    self.hotVideoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_hotVideoListTableView];
    
    
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
    self.hotVideoListTableView.header = header;
    
    #pragma mark -- MJ上拉加载
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//

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
    self.hotVideoListTableView.footer = footer;
}




//MARK:--下拉刷新
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//

- (void)setupRefresh {
    
  [self.hotVideoListArray removeAllObjects];
    //解析数据
    _upCount = 20;
    [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=20&sub_flag=1&type=41&udid=&ver=3.6"];
   
    [self.hotVideoListTableView reloadData];
    
}
//MARK:--上拉加载
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (void)loadNewData{
    _upCount += 20 ;
    
    if (_upCount  == 40) {
    [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=40&sub_flag=1&type=41&udid=&ver=3.6"];
    }
    if (_upCount  == 60) {
        [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=60&sub_flag=1&type=41&udid=&ver=3.6"];
    }
    if (_upCount  == 80) {
        [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=80&sub_flag=1&type=41&udid=&ver=3.6"];
    }
    if (_upCount  == 100) {
        [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=100&sub_flag=1&type=41&udid=&ver=3.6"];
    }
    if (_upCount  == 120) {
        [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=120&sub_flag=1&type=41&udid=&ver=3.6"];
    }
    if (_upCount  == 140) {
        [self resolve:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=79C90406-DB8A-4758-9466-DEDB502C2A14&c=video&client=iphone&device=ios%20%E8%AE%BE%E5%A4%87&from=ios&jbk=0&mac=&market=&openudid=3739a3941c7bb4f82c78c8c53228edcb4a14f0d0&page=0&per=140&sub_flag=1&type=41&udid=&ver=3.6"];
    }

   
}


- (NSMutableArray *)hotVideoListArray {
    if (!_hotVideoListArray) {
        _hotVideoListArray = [NSMutableArray array];
    }
    return _hotVideoListArray;
}
//MARK:--解析数据
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (void)resolve:(NSString *)str {
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];  //NSLog(@"1%@" , request);
    NSOperationQueue *queue= [NSOperationQueue mainQueue];  //NSLog(@"2%@" , queue);
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //没网时
        if (connectionError || data == nil) {
            return;
        }

        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self.hotVideoListArray removeAllObjects];
        
        NSLog(@"%d",self.hotVideoListArray.count);
        [self.hotVideoListArray addObjectsFromArray:[Fresh freshlistArray:dataDic[@"list"]]];
        NSLog(@"%d",self.hotVideoListArray.count);
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.hotVideoListTableView.footer endRefreshing];
        [self.hotVideoListTableView.header endRefreshing];
        [self.hotVideoListTableView reloadData];
        if (_upCount >= 140) {
            [self.hotVideoListTableView.footer noticeNoMoreData];
        }
        
    }];
    
}


//MARK:--配置 tableView
//▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotVideoListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height = [((Fresh *)self.hotVideoListArray[indexPath.row]).height intValue];
    int width = [((Fresh *)self.hotVideoListArray[indexPath.row]).width intValue];
    
    if ((height * (kScreenWidth-40) /(width+1)) >= (kScreenWidth-25)) {
        return  (height * (kScreenWidth-100) / (width+1)) + 70;
    }else{
        return  (height * (kScreenWidth-40) / (width+1)) + 70;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *hotcell = @"hotCell";
    self.hotCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hotcell];
    if (self.hotCell == nil) {
        self.hotCell = [[ HotVideoListTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:hotcell];
    }
    
    self.hotCell.fresh = self.hotVideoListArray[indexPath.row];
    
    //消除点击 Cell 的阴影
    UIView *clear = [[UIView alloc]initWithFrame:_hotCell.frame];
    clear.backgroundColor = [UIColor whiteColor];
    _hotCell.selectedBackgroundView = clear;

    
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
     __weak typeof(self) weakSelf = self;
    self.hotCell.loginBlockHot = ^{
        LoginViewController *lovc = [[LoginViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:lovc];
        [weakSelf.navigationController presentViewController:navc animated:YES completion:nil];
    };
    
    self.hotCell.reloadDataBlockHot = ^{
        [weakSelf.hotVideoListTableView reloadData];
    };
    //下载
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    DownLoadVideo *down = [DownLoadVideo defaultInstance];
    self.hotCell.downBlockHot = ^(NSString *str){
        [weakSelf.hotVideoListTableView reloadData];
        NSLog(@"进入下载 Block");
        [down change:str];
        
    };
    //播放
    //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
    
    self.hotCell.movieBlockHot = ^(NSString *str){
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

    return self.hotCell;
  
}
//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
//播放完成自己移除
- (void)end:(id)sender
{
    //移除播放通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.playerVC.view removeFromSuperview];
    self.playerVC = nil;// 释放资源
    
    _hotVideoListTableView.frame =CGRectMake(0, 0, kScreenWidth, KScreenHeight);
}



//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
