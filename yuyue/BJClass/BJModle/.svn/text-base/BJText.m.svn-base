//
//  BJText.m
//  yuyue
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJText.h"

@implementation BJText
- (instancetype)initWithDict:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)textWithDict:(NSDictionary *)dictionary{
    return [[self alloc]initWithDict:dictionary];
}

+ (NSArray *)text:(NSArray *)array{
    NSMutableArray *ar = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BJText *bjt = [self textWithDict:dic];
        [ar addObject:bjt];
    }
    return ar;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
    
}
@end
