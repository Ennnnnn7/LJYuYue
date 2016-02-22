//
//  LJThreeImagesCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LJThreeImagesCell.h"
#import "LJModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define kImageViewHeight 80
#define kImageViewWidth (kScreenWidth - 30) * 0.33
#define kImageViewY CGRectGetMaxY(_titleLabel.frame)

@interface LJThreeImagesCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UIImageView *thirdImageView;
@property (nonatomic,strong) UIImageView *firstImageView;
@property (nonatomic,strong) UIImageView *secondImageView;
@end


@implementation LJThreeImagesCell



- (UIView *)backView
{
    if (_backView == nil) {
//        _backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10,120)];
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 10;
        _backView.layer.borderColor = [UIColor grayColor].CGColor;
        _backView.layer.borderWidth = 1;
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth * 0.7, 30)];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.backView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)commentLabel
{
    if (_commentLabel == nil) {
//        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.2, 30)];
//        _commentLabel.center = CGPointMake(kScreenWidth - 55, self.titleLabel.center.y);
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textAlignment = NSTextAlignmentRight;
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = [UIColor grayColor];
        [self.backView addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (UIImageView *)firstImageView
{
    if (_firstImageView == nil) {
//        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, kImageViewY, kImageViewWidth, kImageViewHeight)];
        _firstImageView = [[UIImageView alloc] init];
        [_backView addSubview:_firstImageView];
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView
{
    if (_secondImageView == nil) {
//        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.firstImageView.frame) + 7.5, kImageViewY, kImageViewWidth, kImageViewHeight)];
        _secondImageView = [[UIImageView alloc] init];
        [_backView addSubview:_secondImageView];
    }
    return _secondImageView;
}

- (UIImageView *)thirdImageView
{
    if (_thirdImageView == nil) {
//        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.secondImageView.frame) + 7.5, kImageViewY, kImageViewWidth, kImageViewHeight)];
        _thirdImageView = [[UIImageView alloc] init];
        [_backView addSubview:_thirdImageView];
    }
    return _thirdImageView;
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
        make.right.mas_equalTo(-80);
        make.bottom.equalTo(weakSelf.backView.mas_top).offset(35);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(5);
        make.top.equalTo(weakSelf.titleLabel);
        make.right.mas_equalTo(-5);
        make.bottom.equalTo(weakSelf.titleLabel);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(5);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-(kScreenWidth * 0.655));
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.firstImageView.mas_right).offset(5);
        make.size.and.top.equalTo(weakSelf.firstImageView);
    }];

    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.secondImageView.mas_right).offset(5);
        make.bottom.and.top.equalTo(weakSelf.secondImageView);
        make.right.mas_equalTo(-5);
    }];
    
    if (_model != model) {
        self.titleLabel.text = model.title;
        // 如果回复太多就改成几点几万
        CGFloat count =  [model.replyCount intValue];
        NSString *displayCount = nil;
        if (count > 10000) {
            displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
        }else{
            displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
        }
        self.commentLabel.text = displayCount;
        
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"picholder"]];
        if (model.imgextra.count == 2) {
            [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:model.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"picholder"]];
            [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:model.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"picholder"]];
        }
    }
}

+ (instancetype)addLJThreeImagesCellWithTableView:(UITableView *)tableView model:(LJModel *)model
{
    NSString *cellIdentifier = @"ImagesCell";
    LJThreeImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LJThreeImagesCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    cell.model = model;
    return cell;
}











@end
