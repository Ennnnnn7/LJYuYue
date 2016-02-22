//
//  FileHandle.m
//  yuyue
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FileHandle.h"

static FileHandle *filehandle = nil;

@interface FileHandle ()
@property (nonatomic , strong ) NSMutableDictionary *plistdictionary;

@property (nonatomic , strong ) NSMutableDictionary *newsdic;
@property (nonatomic , strong ) NSMutableDictionary *textdic;
@property (nonatomic , strong ) NSMutableDictionary *picturedic;
@property (nonatomic , strong ) NSMutableDictionary *videodic;

@end

@implementation FileHandle

+ (instancetype)fileHandle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filehandle = [[FileHandle alloc]init];
    });
    return filehandle;
}

- (NSMutableDictionary *)plistdictionary{
    if (!_plistdictionary) {
        _plistdictionary = [NSMutableDictionary dictionary];
    }
    return _plistdictionary;
}

- (NSMutableDictionary *)newsdic{
    if (!_newsdic) {
        _newsdic = [NSMutableDictionary dictionary];
    }
    return _newsdic;
}

- (NSMutableDictionary *)textdic{
    if (!_textdic) {
        _textdic = [NSMutableDictionary dictionary];
    }
    return _textdic;
}

- (NSMutableDictionary *)picturedic{
    if (!_picturedic) {
        _picturedic = [NSMutableDictionary dictionary];
    }
    return _picturedic;
}

- (NSMutableDictionary *)videodic{
    if (!_videodic) {
        _videodic = [NSMutableDictionary dictionary];
    }
    return _videodic;
}

#pragma mark - 创建 plist
- (void)foundUserName:(NSString *)userName {
    NSString *username = [NSString stringWithFormat:@"%@.plist",userName];
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *preferences = [libPath stringByAppendingPathComponent:@"/Preferences"];
    self.userPlist = [preferences stringByAppendingPathComponent:username];
    NSLog(@"%@",self.userPlist);
    NSLog(@"%d",[[NSFileManager defaultManager] fileExistsAtPath:self.userPlist]);
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.userPlist]) {
        [self.plistdictionary setObject:self.newsdic forKey:@"news"];
        [self.plistdictionary setObject:self.textdic forKey:@"texts"];
        [self.plistdictionary setObject:self.picturedic forKey:@"pictures"];
        [self.plistdictionary setObject:self.videodic forKey:@"videos"];
        [self.plistdictionary writeToFile:self.userPlist atomically:YES];
    }else{
        self.plistdictionary = [NSMutableDictionary dictionaryWithContentsOfFile:self.userPlist];
        self.newsdic = [self.plistdictionary objectForKey:@"news"];
        self.textdic = [self.plistdictionary objectForKey:@"texts"];
        self.picturedic = [self.plistdictionary objectForKey:@"pictures"];
        self.videodic = [self.plistdictionary objectForKey:@"videos"];
        
        [self.plistdictionary setObject:self.newsdic forKey:@"news"];
        [self.plistdictionary setObject:self.textdic forKey:@"texts"];
        [self.plistdictionary setObject:self.picturedic forKey:@"pictures"];
        [self.plistdictionary setObject:self.videodic forKey:@"videos"];
        [self.plistdictionary writeToFile:self.userPlist atomically:YES];
    }
    
}

#pragma mark - 添加数据
- (void)addNewsInFileDic:(NSDictionary *)dic ID:(NSString *)ID{
    [self.newsdic setObject:dic forKey:ID];
    [self.plistdictionary setObject:self.newsdic forKey:@"news"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}
- (void)addTextInFileDic:(NSDictionary *)dic ID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.textdic setObject:dic forKey:str];
    [self.plistdictionary setObject:self.textdic forKey:@"texts"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];;
}
- (void)addPictureInFileDic:(NSDictionary *)dic ID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.picturedic setObject:dic forKey:str];
    [self.plistdictionary setObject:self.picturedic forKey:@"pictures"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}
- (void)addVideoInFileDic:(NSDictionary *)dic ID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.videodic setObject:dic forKey:str];
    [self.plistdictionary setObject:self.videodic forKey:@"videos"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}

#pragma mark -  移除数据
- (void)removeNewsForID:(NSString *)ID{
    [self.newsdic removeObjectForKey:ID];
    [self.plistdictionary setObject:self.newsdic forKey:@"news"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}

- (void)removeTextForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.textdic removeObjectForKey:str];
    [self.plistdictionary setObject:self.textdic forKey:@"texts"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}

- (void)removePictureForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.picturedic removeObjectForKey:str];
    [self.plistdictionary setObject:self.picturedic forKey:@"pictures"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}

- (void)removeVideoForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    [self.videodic removeObjectForKey:str];
    [self.plistdictionary setObject:self.videodic forKey:@"videos"];
    [self.plistdictionary writeToFile:self.userPlist atomically:YES];
}

#pragma mark - 查找
- (NSDictionary *)foundNewsForID:(NSString *)ID{
    NSArray *keyArray = [self.newsdic allKeys];
    for (NSString *strin in keyArray) {
        if ([strin isEqualToString:ID]) {
            return [self.newsdic objectForKey:ID];
        }
    }
    return nil;
}

- (NSDictionary *)foundTextForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    NSArray *keyArray = [self.textdic allKeys];
    for (NSString *strin in keyArray) {
        if ([strin isEqualToString:str]) {
            return [self.textdic objectForKey:str];
        }
    }
    return nil;
}

- (NSDictionary *)foundPicturesForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    NSArray *keyArray = [self.picturedic allKeys];
    for (NSString *strin in keyArray) {
        if ([strin isEqualToString:str]) {
            return [self.picturedic objectForKey:str];
        }
    }
    return nil;
}

- (NSDictionary *)foundVideoForID:(NSInteger)ID{
    NSString *str = [NSString stringWithFormat:@"%ld",ID];
    NSArray *keyArray = [self.videodic allKeys];
    for (NSString *strin in keyArray) {
        if ([strin isEqualToString:str]) {
            return [self.videodic objectForKey:str];
        }
    }
    return nil;
}
@end
