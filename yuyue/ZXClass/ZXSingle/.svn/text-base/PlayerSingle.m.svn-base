//
//  PlayerSingle.m
//  yuyue
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "PlayerSingle.h"


static PlayerSingle *mediaPlaySingle = nil;


@implementation PlayerSingle

+ (PlayerSingle *)defaultInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediaPlaySingle = [[PlayerSingle alloc] init];
        
    });
    
    return mediaPlaySingle;
}


@end
