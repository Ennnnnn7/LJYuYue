//
//  Fresh.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Fresh.h"

@implementation Fresh

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value intValue];
    }
}

//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
+ (instancetype)freshWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
//▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁//
+ (NSArray *)freshlistArray:(NSMutableArray *)array {
    NSMutableArray *listArray = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        [listArray addObject:[self freshWithDict:dic]];
    }
    return listArray;
}


@end
