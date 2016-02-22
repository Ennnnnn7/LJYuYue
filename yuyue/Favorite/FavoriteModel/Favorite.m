//
//  Favorite.m
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Favorite.h"
#import "BJText.h"
#import "BJPicture.h"
#import "Fresh.h"
#import "LJModel.h"
#import "MJExtension.h"

@interface Favorite ()
@property (nonatomic , strong )NSMutableArray *muArray;
@end

@implementation Favorite

- (NSMutableArray *)muArray{
    if (!_muArray) {
        _muArray = [NSMutableArray array];
    }
    return _muArray;
}
- (NSMutableArray *)content{
    if (!_content) {
        _content = [NSMutableArray array];
    }
    return _content;
}

- (instancetype)initWithDict:(NSDictionary *)dictionary nameString:(NSString *)name{
    self = [super init];
    if (self) {
        self.content = nil;
        self.name = name;
        NSMutableArray *arr = [NSMutableArray array];

        if ([dictionary allKeys].count) {
            for (NSString *key in [dictionary allKeys]) {
                [arr addObject:[dictionary objectForKey:key] ];
            }
            
            if ([name isEqualToString:@"news"]) {
                [self.content addObjectsFromArray:[LJModel objectArrayWithKeyValuesArray:arr]];
                
            }else if ([name isEqualToString:@"pictures"]){
                
                [self.content addObjectsFromArray: [BJPicture picture:arr]];

            }else if ([name isEqualToString:@"texts"]){
                
                [self.content addObjectsFromArray: [BJText text:arr]];
                
            }else if ([name isEqualToString:@"videos"]){
                
                [self.content addObjectsFromArray:[Fresh freshlistArray:arr]];
            }
            
        }
        
    }
    return self;
}

+ (instancetype)favoriteWithDict:(NSDictionary *)dictionary nameString:(NSString *)name{
    return [[self alloc]initWithDict:dictionary nameString:name];
}

+ (NSArray *)favorite:(NSDictionary *)favoritedic{
    NSMutableArray *array = [NSMutableArray array];
    for ( NSString *str in [favoritedic allKeys]) {
        [array addObject:[self favoriteWithDict:[favoritedic objectForKey:str] nameString:str]];
    }
    return array;
}


@end
