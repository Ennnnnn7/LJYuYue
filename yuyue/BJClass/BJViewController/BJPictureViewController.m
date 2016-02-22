//
//  BJPictureViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJPictureViewController.h"
#import "NavigationViewController.h"
#import "BJPictureTableViewCell.h"
#import "BJPicture.h"
#import "MJRefresh.h"
#import "FileHandle.h"
#import "Masonry.h"
#import "LoginViewController.h"


@interface BJPictureViewController () < UITableViewDataSource , UITableViewDelegate , NSURLConnectionDelegate , NSURLConnectionDataDelegate >
@property (nonatomic , strong ) UITableView *pictureTV;
@property (nonatomic , strong ) NSMutableArray *receiveArray;
@property (nonatomic , assign ) NSInteger page;
@property (nonatomic , strong ) NSMutableData *receiveData;
@end

@implementation BJPictureViewController

- (UITableView *)pictureTV{
    if (!_pictureTV) {
        _pictureTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, KScreenHeight-64)];
        _pictureTV.delegate = self;
        _pictureTV.dataSource = self;
        [self.view addSubview:_pictureTV];
    }
    return _pictureTV;
}

- (NSArray *)receiveArray{
    if (!_receiveArray) {
        _receiveArray = [NSMutableArray array];
    }
    return _receiveArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pictureTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pictureTV.rowHeight = 230;
    [self refresh];
    
}

#pragma mark - 设置 cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BJPictureTableViewCell *cell = [BJPictureTableViewCell setPictureCell:tableView];
    cell.picture = self.receiveArray[indexPath.row];
    __weak typeof(self) blockself = self;
    cell.loveblock = ^(){
        LoginViewController *lovc = [[LoginViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:lovc];
        [blockself.navigationController presentViewController:navc animated:YES completion:nil];
    };
    cell.reloadblock = ^(){
        [blockself.pictureTV reloadData];
    };
    return cell;
}


#pragma mark - 上拉刷新，下拉加载
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
    self.pictureTV.header = header;
    
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
    self.pictureTV.footer = footer;
    
}
- (void)loadNewData
{
    
    self.page = 20;
    [self loadPictureData];
}

- (void)loadMoreData
{
    self.page += 10;
    [self loadPictureData];
}

#pragma mark - 解析数据
- (void)loadPictureData{
    
    NSURL *url = [[NSURL alloc]initWithString: bjPictureUrl(self.page)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.receiveData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.receiveData options:0 error:nil];
    NSArray *array = [NSArray arrayWithObject:[dic objectForKey:@"list"]];
    if(_receiveArray) self.receiveArray = nil;
    [self.receiveArray addObjectsFromArray:[BJPicture picture:array[0]]];
    [self.pictureTV.header endRefreshing];
    [self.pictureTV.footer endRefreshing];
    [self.pictureTV reloadData];
    if(self.page >= 50) [self.pictureTV.footer noticeNoMoreData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.pictureTV deselectRowAtIndexPath:indexPath animated:YES];
}

@end
