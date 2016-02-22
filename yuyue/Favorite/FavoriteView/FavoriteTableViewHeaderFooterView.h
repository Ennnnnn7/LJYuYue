//
//  FavoriteTableViewHeaderFooterView.h
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Favorite;

typedef void(^FavoriteBlock)();
@interface FavoriteTableViewHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic , strong ) Favorite *favorite;
@property (nonatomic , copy ) FavoriteBlock favoriteblock;

+ (instancetype)setheaderView:(UITableView *)tableview;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
    
@end
