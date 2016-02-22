//
//  BJPicture.h
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJPicture : NSObject
@property (nonatomic , copy ) NSString *cdn_img;
@property (nonatomic , copy ) NSString *text;
@property (nonatomic , copy ) NSString *gifFistFrame;

@property (nonatomic , assign ) NSInteger height;
@property (nonatomic , assign ) NSInteger is_gif;
@property (nonatomic , assign ) NSInteger width;
@property (nonatomic , assign ) NSInteger t;
@property (nonatomic , assign ) NSInteger ID;

@property (nonatomic , assign ) BOOL islove;

- (instancetype)initWithDict:(NSDictionary *)dictionary;

+ (instancetype)pictureWithDict:(NSDictionary *)dictionary;

+ (NSArray *)picture:(NSArray *)array;
@end
