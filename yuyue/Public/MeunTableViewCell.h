//
//  MeunTableViewCell.h
//  yuyue
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeunTableViewCell : UITableViewCell

@property (nonatomic , strong ) UIImageView *headImageView;

@property (nonatomic , strong ) UIImageView *tailImageView;

@property (nonatomic , strong ) UILabel *textlabel;

+ (instancetype)setMeunCell:(UITableView *)tableview;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
