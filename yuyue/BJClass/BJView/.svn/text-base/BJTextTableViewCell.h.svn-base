//
//  BJTextTableViewCell.h
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BJText;
typedef void(^LoveTextBlock)();
@interface BJTextTableViewCell : UITableViewCell
@property (nonatomic , copy ) LoveTextBlock loveTextblock;
@property (nonatomic , copy ) LoveTextBlock reloadblock;

@property (nonatomic , strong ) BJText *text;

+ (instancetype)setTextCell:(UITableView *)tableview;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat )heightforstring:(NSString *)str;

+ (CGFloat )cellHeightforText:(BJText *)text;

@end
