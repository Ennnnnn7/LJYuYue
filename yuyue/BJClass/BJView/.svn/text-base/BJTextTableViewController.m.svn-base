//
//  BJTextTableViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJTextTableViewController.h"
#import "NavigationViewController.h"
#import "MJRefresh.h"
#import "BJText.h"
#import "BJTextTableViewCell.h"
#import "BJPictureViewController.h"
#import "LoginViewController.h"


@interface BJTextTableViewController () < NSURLConnectionDelegate >
@property (nonatomic , assign ) NSInteger page;
@property (nonatomic , strong ) NSMutableArray *receiveArray;
@property (nonatomic , strong ) NSMutableData *receiveData;
@property (nonatomic , strong ) UISegmentedControl *segment;
@property (nonatomic , strong ) BJTextTableViewController *textTVC;
@property (nonatomic , strong ) BJPictureViewController *pictureVC;
@end

@implementation BJTextTableViewController


- (BOOL)shouldAutorotate{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (NSMutableArray *)receiveArray{
    if (!_receiveArray) {
        _receiveArray = [NSMutableArray array];
    }
    return _receiveArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refresh];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.receiveArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJTextTableViewCell *cell = [BJTextTableViewCell setTextCell:tableView];
    cell.text = self.receiveArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.loveTextblock = ^(){
        LoginViewController *lovc = [[LoginViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:lovc];
        [weakSelf.navigationController presentViewController:navc animated:YES completion:nil];
    };
    
    cell.reloadblock = ^(){
        [weakSelf.tableView reloadData];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BJText *text = self.receiveArray[indexPath.row];
    return [BJTextTableViewCell cellHeightforText:text] + 11;
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
    NSURL *url = [[NSURL alloc]initWithString: bjTexteUrl(self.page)];
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
    [self.receiveArray addObjectsFromArray:[BJText text:array[0]]];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [self.tableView reloadData];
    if(self.page >= 50) [self.tableView.footer noticeNoMoreData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
