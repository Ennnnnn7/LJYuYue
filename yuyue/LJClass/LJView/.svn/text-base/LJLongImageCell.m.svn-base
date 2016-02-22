//
//  LJLongImageCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJLongImageCell.h"
#import "LJModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define kControlWidth kScreenWidth - 20

@interface LJLongImageCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UIImageView *headImageView;
@end

@implementation LJLongImageCell

- (UIView *)backView
{
    if (_backView == nil) {
//        _backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10,160)];
        _backView = [[UIView alloc] init];
        _backView.layer.borderColor = [UIColor grayColor].CGColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 10;
        _backView.layer.borderWidth = 1;
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kControlWidth, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.backView addSubview:_titleLabel];

    }
    return _titleLabel;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
//        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame) + 5, kControlWidth, 90)];
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor cyanColor];
        [_backView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)commentLabel
{
    if (_commentLabel == nil) {
//        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.headImageView.frame) + 5, kControlWidth, 30)];
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = [UIColor grayColor];
        [_backView addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (void)setModel:(LJModel *)model
{
    __weak typeof(self) weakSelf = self;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(5);
        make.right.and.bottom.mas_equalTo(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(5);
        make.top.equalTo(weakSelf.backView.mas_top).offset(5);
        make.right.mas_equalTo(-5);
        make.bottom.equalTo(weakSelf.backView.mas_top).offset(35);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(5);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-30);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(5);
        make.top.equalTo(weakSelf.headImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
    }];
    
    if (_model != model) {
        self.titleLabel.text = model.title;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"picholder"]];
        // 如果回复太多就改成几点几万
        CGFloat count =  [model.replyCount intValue];
        NSString *displayCount = nil;
        if (count > 10000) {
            displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
        }else{
            displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
        }
        self.commentLabel.text = displayCount;
    }
}

+ (instancetype)addLJLongImageCellWithTableView:(UITableView *)tableView model:(LJModel *)model
{
    NSString *cellIdentifier = @"BigImageCell";
    LJLongImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LJLongImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    cell.model = model;
    return cell;
}

@end
