//
//  BJPictureTableViewCell.h
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BJPicture;
typedef void(^LoveBlock)();
@interface BJPictureTableViewCell : UITableViewCell
@property (nonatomic , copy ) LoveBlock loveblock;
@property (nonatomic , copy ) LoveBlock reloadblock;

@property (nonatomic , strong ) BJPicture *picture;

+ (instancetype)setPictureCell:(UITableView *)tableview;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
