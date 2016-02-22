//
//  BJTextTableViewCell.m
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJTextTableViewCell.h"
#import "BJText.h"
#import "Masonry.h"
#import "FileHandle.h"
#import "UserInfo.h"


@interface BJTextTableViewCell () <UserInfoDelegate>
@property (nonatomic , strong ) UILabel *textlabel;
@property (nonatomic , strong ) UILabel *timelabel;
@property (nonatomic , strong ) UIButton *lovebutton;
@property (nonatomic , strong ) UIView *view;
@property (nonatomic , strong ) UIView *backview;
@property (nonatomic , assign ) BOOL islove;
@end

@implementation BJTextTableViewCell
+ (CGFloat )heightforstring:(NSString *)str{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18],NSFontAttributeName, nil];
    CGRect bound = [str boundingRectWithSize:(CGSizeMake(kScreenWidth - 10, 1000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return bound.size.height;
}
+ (CGFloat )cellHeightforText:(BJText *)text{
    CGFloat strHeight = [self heightforstring:text.text];
    CGFloat constHight = 40;
    CGFloat finalHeight = strHeight +constHight;
    return finalHeight > 22 ? finalHeight : 22;
}

+ (instancetype)setTextCell:(UITableView *)tableview{
    static NSString *textID = @"TextCell";
    BJTextTableViewCell *textCell = [tableview dequeueReusableCellWithIdentifier:textID];
    if (!textCell) {
        textCell = [[BJTextTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:textID];
    }
    return textCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view = [[UIView alloc]init];
        self.view.layer.cornerRadius = 4;
        self.view.layer.masksToBounds = YES;
        self.view.layer.borderWidth = 1;
        self.view.layer.borderColor = [UIColor grayColor].CGColor;
        [self.contentView addSubview:self.view];
        
        self.timelabel = [[UILabel alloc]init];
        
        self.lovebutton = [[UIButton alloc]init];
        [self.lovebutton addTarget:self action:@selector(love) forControlEvents:(UIControlEventTouchUpInside)];
        self.backview = [[UIView alloc]init];
        self.backview.backgroundColor = [UIColor blackColor];
        
        self.textlabel = [[UILabel alloc]init];

        [self.view addSubview:self.timelabel];
        [self.view addSubview:self.backview];
        [self.view addSubview:self.textlabel];
        [self.view addSubview:self.lovebutton];
        
    }
    return self;
}
- (void)love{
    
    if ([UserInfo sharedUserInfo].isLogin) {
        [self login];
    }
    
    if (![UserInfo sharedUserInfo].isLogin) {
        self.loveTextblock();
        [UserInfo sharedUserInfo].delegate = self;
    }
    
}

- (void)userInfo:(UserInfo *)userInfo select:(BOOL)isLogin{
    [self login];
}

- (void)login{
    if (![UserInfo sharedUserInfo].isLogin){
        return ;
    };
    
    self.text.islove = !self.text.islove;
    
    if (self.text.islove) {
        NSDictionary *dic = @{ @"text":self.text.text , @"t":@(self.text.t) , @"id":@(self.text.ID)};
        [[FileHandle fileHandle] addTextInFileDic:dic ID:self.text.ID];
    }else {
        if ([[FileHandle fileHandle] foundTextForID:self.text.ID]) {
            [[FileHandle fileHandle] removeTextForID:self.text.ID];
        }
    }
    self.reloadblock();
}


- (void)setText:(BJText *)text{
    
    _text = text;
    
    __weak typeof(self) weakSelf = self;
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(5);
        make.right.and.bottom.mas_equalTo(-5);
    }];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(5);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(30);
    }];
    [self.lovebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timelabel.mas_right);
        make.top.and.height.equalTo(weakSelf.timelabel);
        make.right.mas_equalTo(5);
    }];
    [self.textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timelabel.mas_bottom);
        make.left.mas_equalTo(5);
        make.right.bottom.mas_equalTo(-5);
    }];
    
    
    self.textlabel.numberOfLines = 0;
    self.textlabel.text = text.text;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:text.t];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"   yyyy/MM/dd HH:mm"];
    self.timelabel.text = [myFormatter stringFromDate:date];
    
    if ([UserInfo sharedUserInfo].isLogin) {
        if ([[FileHandle fileHandle] foundTextForID:self.text.ID]) {
            self.text.islove = YES;
        }
    }
    
    if (self.text.islove) {
        [self.lovebutton setImage:[UIImage imageNamed:@"redheart"] forState:(UIControlStateNormal)];
    } else {
        [self.lovebutton setImage:[UIImage imageNamed:@"whiteheart"] forState:(UIControlStateNormal)];
    }
    
    self.textlabel.textColor = [UIColor blackColor];
    
}


@end
