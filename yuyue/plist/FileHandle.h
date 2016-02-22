//
//  FileHandle.h
//  yuyue
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandle : NSObject
@property (nonatomic , strong ) NSString *userPlist;
+ (instancetype)fileHandle;
- (void)foundUserName:(NSString *)userName;
// 添加数据
- (void)addNewsInFileDic:(NSDictionary *)dic ID:(NSString *)ID;
- (void)addTextInFileDic:(NSDictionary *)dic ID:(NSInteger)ID;
- (void)addPictureInFileDic:(NSDictionary *)dic ID:(NSInteger)ID;
- (void)addVideoInFileDic:(NSDictionary *)dic ID:(NSInteger)ID;
// 删除数据
- (void)removeNewsForID:(NSString *)ID;
- (void)removeTextForID:(NSInteger)ID;
- (void)removePictureForID:(NSInteger)ID;
- (void)removeVideoForID:(NSInteger)ID;
// 查找数据
- (NSDictionary *)foundNewsForID:(NSString *)ID;
- (NSDictionary *)foundTextForID:(NSInteger)ID;
- (NSDictionary *)foundPicturesForID:(NSInteger)ID;
- (NSDictionary *)foundVideoForID:(NSInteger)ID;
@end
