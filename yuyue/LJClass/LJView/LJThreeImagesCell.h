//
//  LJThreeImagesCell.h
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJModel;

@interface LJThreeImagesCell : UITableViewCell
@property (nonatomic,strong) LJModel *model;
+ (instancetype)addLJThreeImagesCellWithTableView:(UITableView *)tableView model:(LJModel *)model;
@end
