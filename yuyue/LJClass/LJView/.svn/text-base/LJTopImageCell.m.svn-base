//
//  LJTopImageCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJTopImageCell.h"
#import "LJModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
@interface LJTopImageCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *pngImageView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIImageView *mainImageView;
@end

@implementation LJTopImageCell

- (UIImageView *)mainImageView
{
    if (_mainImageView == nil) {
//        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,KScreenHeight * 0.33)];
        _mainImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mainImageView];
    }
    return _mainImageView;
}

- (UIImageView *)pngImageView
{
    if (_pngImageView == nil) {
//        _pngImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 219, 22, 22)];
        _pngImageView = [[UIImageView alloc] init];
        _pngImageView.image = [UIImage imageNamed:@"night_photoset_list_cell_icon"];
        [self.contentView addSubview:_pngImageView];
    }
    return _pngImageView;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pngImageView.frame) + 5,self.pngImageView.frame.origin.y,260,self.pngImageView.frame.size.height)];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame )+ 10, self.titleLabel.frame.origin.y,13, self.titleLabel.frame.size.height)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [self.contentView addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)setModel:(LJModel *)model
{
    __weak typeof(self) weakSelf = self;
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-30);
    }];
    [self.pngImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(weakSelf.mainImageView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pngImageView.mas_right).offset(5);
        make.top.equalTo(weakSelf.pngImageView);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-5);
    }];
    if (_model != model) {
        if (model.headImage == nil) {
            [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"picholder"]];
        }else
        {
            self.mainImageView.image = model.headImage;
        }
        self.titleLabel.text = model.title;
    }
}

+ (instancetype)addLJTopImageCellWithTableView:(UITableView *)tableView model:(LJModel *)model
{
    NSString *cellIdentifier = @"TopImageCell";
    LJTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LJTopImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    cell.model = model;
    return cell;

}


@end
