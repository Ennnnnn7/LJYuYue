//
//  FavoriteTableViewHeaderFooterView.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FavoriteTableViewHeaderFooterView.h"
#import "Favorite.h"
#import "Masonry.h"

@interface FavoriteTableViewHeaderFooterView ()
@property (nonatomic , strong ) UIButton *headerbutton;
@property (nonatomic , strong ) UILabel *headlabel;
@property (nonatomic , strong ) UIImageView *loveImage;

@end

@implementation FavoriteTableViewHeaderFooterView

+ (instancetype)setheaderView:(UITableView *)tableview{
    static NSString *headerID = @"header";
    FavoriteTableViewHeaderFooterView *header = [tableview dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!header) {
        header = [[FavoriteTableViewHeaderFooterView alloc]initWithReuseIdentifier:headerID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerbutton = [[UIButton alloc]init];
        self.headerbutton.backgroundColor = [UIColor whiteColor];
        self.headerbutton.layer.borderWidth = 1;
        self.headerbutton.layer.borderColor = [UIColor grayColor].CGColor;
        
        self.headlabel = [[UILabel alloc]init];
        self.loveImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redheart"]];
        [self.headerbutton addSubview:self.loveImage];
        [self.headerbutton addSubview:self.headlabel];
        
        [self.headerbutton addTarget:self action:@selector(show) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:self.headerbutton];
    }
    return self;
}

- (void)setFavorite:(Favorite *)favorite{
    _favorite = favorite;
    
    [self.headerbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.loveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25,25));
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    [self.headlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50,25));
        make.right.equalTo(self.loveImage.mas_left).offset(-5);
        make.top.mas_equalTo(10);
    }];
    
    self.headlabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)favorite.content.count];
    self.headlabel.textAlignment = NSTextAlignmentRight;
    
    [self.headerbutton setTitle:favorite.name forState:(UIControlStateNormal)];
    [self.headerbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}

- (void)show{
    self.favorite.isShow = !self.favorite.isShow;
    self.favoriteblock();
}

@end
