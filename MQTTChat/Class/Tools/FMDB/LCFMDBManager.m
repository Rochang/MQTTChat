//
//  LCFMDBManager.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCFMDBManager.h"
#import <FMDB.h>

static NSString *fmdbName = @"chatIM";

@interface LCFMDBManager ()

@property (strong, nonatomic) FMDatabase *fmdb;

@end


@implementation LCFMDBManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static LCFMDBManager *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)creatTable:(NSString *)tableName formatStr:(NSString *)format {
    if ([self isTableExistWithTableName:tableName]) {
        NSLog(@"%@ 表已存在", tableName);
        return;
    }
    // 创建表
    [self.fmdb open];
    BOOL success = [self.fmdb executeUpdate:format];
    if (!success) {
        NSLog(@"%@ 创建失败", tableName);
    }
    [self.fmdb close];
}

- (BOOL)isTableExistWithTableName:(NSString *)name {
    [self.fmdb open];
    FMResultSet *result = [self.fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type='table' and name=?", name];
    int count = 0;
    while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    [self.fmdb close];
    return count == 0 ? NO : YES;
}


#pragma mark - getter
- (FMDatabase *)fmdb {
    if (!_fmdb) {
        NSString *fmdbPath = [[NSString getHomePath] stringByAppendingFormat:@"%@.sqlite", fmdbName];
        _fmdb = [[FMDatabase alloc] initWithPath:fmdbPath];
    
    }
    return _fmdb;
}


@end
