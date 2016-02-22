//
//  MeunTableViewCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MeunTableViewCell.h"
#import "Masonry.h"

@interface MeunTableViewCell ()
@property (nonatomic , strong ) UIView *backview;
@end
@implementation MeunTableViewCell

+ (instancetype)setMeunCell:(UITableView *)tableview{
    static NSString *cellIdentifier = @"Cell";
    MeunTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MeunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(20, 15, 35, 35))];
        self.textlabel = [[UILabel alloc]initWithFrame:(CGRectMake(73, 7, kScreenWidth-175, 45))];
        self.tailImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(CGRectGetMaxX(self.textlabel.frame), 20, 10, 10))];
        self.backview  = [[UIView alloc]initWithFrame:(CGRectMake(73, 52, kScreenWidth-53, 1))];
        self.backview.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.headImageView];
        [self addSubview:self.tailImageView];
        [self addSubview:self.textlabel];
        [self addSubview:self.backview];
    }
    return self;
}

@end
