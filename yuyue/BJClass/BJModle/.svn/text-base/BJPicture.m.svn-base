//
//  BJPicture.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJPicture.h"

@implementation BJPicture

- (instancetype)initWithDict:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)pictureWithDict:(NSDictionary *)dictionary{
    return [[self alloc]initWithDict:dictionary];
}

+ (NSArray *)picture:(NSArray *)array{
    NSMutableArray *ar = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BJPicture *bjp = [self pictureWithDict:dic];
        [ar addObject:bjp];
    }
    return ar;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
