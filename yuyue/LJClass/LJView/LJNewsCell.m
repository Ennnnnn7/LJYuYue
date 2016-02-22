//
//  LJNewsCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJNewsCell.h"
#import "LJModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define kLabelWidth (kScreenWidth * 0.6)

@interface LJNewsCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *synopsisLabel;
@property (nonatomic,strong) UIImageView *headImageView;
@end

@implementation LJNewsCell
- (UIView *)backView
{
    if (_backView == nil) {
//        _backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10,90)];
        _backView = [[UIView alloc] init];
        _backView.layer.borderWidth = 1;
        _backView.layer.cornerRadius = 10;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = [UIColor grayColor].CGColor;
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

-  (UIImageView *)headImageView
{
    if (_headImageView == nil) {
//        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,100, 80)];
        _headImageView= [[UIImageView alloc] init];
        [self.backView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, _headImageView.frame.origin.y, kLabelWidth, 30)];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_backView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)synopsisLabel
{
    if (_synopsisLabel == nil) {
//        _synopsisLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, CGRectGetMaxY(_titleLabel.frame) + 5, kLabelWidth, 45)];
        _synopsisLabel = [[UILabel alloc] init];
        _synopsisLabel.numberOfLines = 0;
        _synopsisLabel.textColor = [UIColor grayColor];
        _synopsisLabel.font = [UIFont systemFontOfSize:14];
        [_backView addSubview:_synopsisLabel];
    }
    return _synopsisLabel;
}

- (UILabel *)commentLabel
{
    if (_commentLabel == nil) {
//        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 65, 60, 20)];
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.textAlignment = NSTextAlignmentRight;
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
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-kScreenWidth *0.7);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.equalTo(weakSelf.headImageView.mas_top).offset(30);
    }];
    
    [self.synopsisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(5);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(kScreenWidth * 0.5);
        make.top.equalTo(weakSelf.backView.mas_bottom).offset(-25);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
    }];
    
    if (_model != model) {
        NSString *imageSandboxPath = nil;
        if (model.headImage == nil) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"picholder"]];
        }else
        {
            self.headImageView.image = [UIImage imageNamed:imageSandboxPath];
        }
        
        
        self.titleLabel.text = model.title;
        self.synopsisLabel.text = model.digest;
        
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


+ (instancetype)addLJNewsCellWithTableView:(UITableView *)tableView model:(LJModel *)model
{
    NSString *cellIdentifier = @"NewsCell";
    LJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LJNewsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    cell.model = model;
    return cell;
}


@end
