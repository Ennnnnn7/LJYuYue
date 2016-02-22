//
//  FavoriteTableViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "NavigationViewController.h"
#import "FavoriteTableViewHeaderFooterView.h"
#import "Favorite.h"
#import "LJModel.h"
#import "LJLongImageCell.h"
#import "LJThreeImagesCell.h"
#import "LJNewsCell.h"
#import "LJTopImageCell.h"
#import "BJTextTableViewCell.h"
#import "BJText.h"
#import "BJPictureTableViewCell.h"
#import "BJPicture.h"
#import "FileHandle.h"
#import "Fresh.h"
#import "FreshVideoListTableViewCell.h"
#import "LJNewsDetailViewController.h"
#import "UserInfo.h"


@interface FavoriteTableViewController ()
@property (nonatomic , strong ) NSMutableDictionary *receiveDic;
@property (nonatomic , strong ) NSMutableArray *receiveArray;


@end

@implementation FavoriteTableViewController

- (NSMutableDictionary *)receiveDic{
    if (!_receiveDic) {
        _receiveDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileHandle fileHandle].userPlist];
    }
    return _receiveDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cm2_list_icn_order"] style:(UIBarButtonItemStylePlain) target:(NavigationViewController *)self.navigationController action:@selector(showMenu)];
    self.tableView.sectionHeaderHeight = 50;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.title = @"收 藏";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0],NSFontAttributeName,nil]];
    
    [self lodData];
}

#pragma mark - 数据
- (NSMutableArray *)receiveArray{
    if (!_receiveArray) {
        _receiveArray = [[NSMutableArray alloc]initWithCapacity:4];
    }
    return _receiveArray;
}

- (void)lodData{
    self.receiveArray = nil;
    self.receiveDic = nil;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:[Favorite favorite:self.receiveDic]];
    [self.receiveArray addObjectsFromArray: [Favorite favorite:self.receiveDic]];
    for (int i = 0; i < 4; i++) {
        Favorite *favorite = arr[i];
        if ([favorite.name isEqualToString:@"news"]) {
            [self.receiveArray replaceObjectAtIndex:0 withObject:favorite];
        }
        if ([favorite.name isEqualToString:@"texts"]) {
            [self.receiveArray replaceObjectAtIndex:1 withObject:favorite];
        }
        if ([favorite.name isEqualToString:@"pictures"]) {
            [self.receiveArray replaceObjectAtIndex:2 withObject:favorite];
        }
        if ([favorite.name isEqualToString:@"videos"]) {
            [self.receiveArray replaceObjectAtIndex:3 withObject:favorite];
        }
    }
}

#pragma mark - 设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FavoriteTableViewHeaderFooterView *headerview = [FavoriteTableViewHeaderFooterView setheaderView:tableView];
    headerview.favorite = self.receiveArray[section];
    __weak typeof(self) weakSelf = self;
    headerview.favoriteblock = ^(){
        [weakSelf.tableView reloadData];
    };
    return headerview;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.receiveArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Favorite *favorite = self.receiveArray[section];
    return favorite.isShow ? favorite.content.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Favorite *favorite = self.receiveArray[indexPath.section];
    switch (indexPath.section) {
        case 0:{
            LJModel *model = favorite.content[indexPath.row];
            return [LJNewsCell addLJNewsCellWithTableView:tableView model:model];
        }break;
        case 1:{
            BJText *model = favorite.content[indexPath.row];
            BJTextTableViewCell *cell = [BJTextTableViewCell setTextCell:tableView];
            
            __weak typeof(self) weakSelf = self;
            cell.reloadblock = ^(){
                [weakSelf.tableView reloadData];
            };
            cell.text = model;
            return cell;
        }break;
        case 2:{
            BJPicture *model = favorite.content[indexPath.row];
            BJPictureTableViewCell *cell = [BJPictureTableViewCell setPictureCell:tableView];
            __weak typeof(self) weakSelf = self;
            cell.reloadblock = ^(){
                [weakSelf.tableView reloadData];
            };
            cell.picture = model;
            return cell;
        }break;
        case 3:{
            static NSString *freshcell = @"freshYES";
            FreshVideoListTableViewCell *freshCell = [tableView dequeueReusableCellWithIdentifier:freshcell];
            if (freshCell == nil) {
                freshCell = [[FreshVideoListTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:freshcell];
            }
            freshCell.fresh = favorite.content[indexPath.row];
            //播放
            //▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
            __weak typeof(self) weakSelf = self;
            freshCell.movieBlock = ^(NSString *str){
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
            freshCell.reloadDataBlock = ^{
                [weakSelf.tableView reloadData];
            };
            return freshCell;
        }break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            if (KScreenHeight * 0.15 < 100) {
                return 100;
            }else{
                return KScreenHeight *0.15;
            }
        }break;
        case 1:{
            Favorite *favorite = self.receiveArray[indexPath.section];
            BJText *model = favorite.content[indexPath.row];
            return [BJTextTableViewCell cellHeightforText:model] + 11;
        }break;
        case 2:{
            return 230;
        }break;
        case 3:{
            Favorite *favorite = self.receiveArray[indexPath.section];
            Fresh *fresh =  favorite.content[indexPath.row];
            int height = [fresh.height intValue];
            int width = [fresh.width intValue];
            
            if ((height * (kScreenWidth-40) /(width+1)) >= (kScreenWidth-25)) {
                return  (height * (kScreenWidth-100) / (width+1)) + 70;
            }else{
                return  (height * (kScreenWidth-40) / (width+1)) + 70;
            }
        }break;
        default:
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0) {
        return;
    }
    
    LJNewsDetailViewController *newsDetailVC = [[LJNewsDetailViewController alloc] init];
    Favorite *favorite = self.receiveArray[indexPath.section];
    LJModel *model = favorite.content[indexPath.row];
    
    // 顶部图片的网址
//    if (model.skipID != nil)
//    {
//        NSString *newString = [model.skipID stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
//        NSString *newUrl = [NSString stringWithFormat:@"http://ent.163.com/photoview/%@.html",newString];
//        model.url_3w = newUrl;
//    }
    
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


//播放完成自己移除
- (void)end:(id)sender
{
    //移除播放通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.playerVC.view removeFromSuperview];
    self.playerVC = nil;// 释放资源
}
@end
