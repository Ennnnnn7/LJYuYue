//
//  Favorite.h
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FavoriteContent;
@interface Favorite : NSObject
@property (nonatomic , assign ) BOOL isShow;

@property (nonatomic , strong ) NSMutableArray *content;
@property (nonatomic , strong ) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dictionary nameString:(NSString *)name;

+ (instancetype)favoriteWithDict:(NSDictionary *)dictionary nameString:(NSString *)name;

+ (NSArray *)favorite:(NSDictionary *)favoritedic;

@end
