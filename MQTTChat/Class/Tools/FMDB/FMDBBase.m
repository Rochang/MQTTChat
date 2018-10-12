//
//  FMDBBase.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "FMDBBase.h"
#import <FMDB.h>

static NSString *fmdbName = @"chatIM";

@interface FMDBBase ()

@property (strong, nonatomic) FMDatabase *fmdb;

@end


@implementation FMDBBase

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static FMDBBase *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)setFMDBPath:(NSString *)path dataBaseName:(NSString *)dataName {
    _path = path;
    _dataBaseName = dataName;
}

- (void)creatTable:(NSString *)tableName sqlstr:(NSString *)sqlstr {
    if ([self isTableExistWithTableName:tableName]) {
        NSLog(@"%@ 表已存在", tableName);
        return;
    }
    // 创建表
    [self.fmdb open];
    BOOL success = [self.fmdb executeUpdate:sqlstr];
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

- (BOOL)deleteTable:(NSString *)tableName {
    BOOL flag = YES;
    if ([self.fmdb open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
        if (![self.fmdb executeUpdate:sqlstr]) {
            NSLog(@"删表失败: %@", tableName);
            flag = NO;
        }
        [self.fmdb close];
    }
    return flag;
}

- (BOOL)resetTable:(NSString *)tableName {
    BOOL flag = YES;
    if([self.fmdb open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        if (![self.fmdb executeUpdate:sqlstr])  {
            NSLog(@"清除表失败: %@", tableName);
            flag = NO;
        }
        [self.fmdb close];
    }
    return flag;
}

- (void)queryAllDatasWithTable:(NSString *)tableName db_result:(resultBlock)result {
    if([self.fmdb open]) {
        FMResultSet *resultSet = [self.fmdb executeQuery:[NSString stringWithFormat:@"select* from %@", tableName]];
        while ([resultSet next]) {
            if(result) result(resultSet);
        }
        [self.fmdb close];
    }
}

- (void)queryDatasWithTable:(NSString *)tableName db_key:(NSString *)key db_value:(NSString *)value db_result:(resultBlock)db_result {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';", tableName, key, value];
        FMResultSet *result = [self.fmdb executeQuery:sql];
        while ([result next]) {
            if (result) db_result(result);
        }
        [self.fmdb close];
    }
}

- (void)FMDBBaseExecuteUpdateSqlStr:(NSString *)sqlstr {
    if ([self.fmdb open]) {
        if (![self.fmdb executeUpdate:sqlstr]) {
            NSLog(@"FMDB 执行更新失败");
        }
        [self.fmdb close];
    }
}

#pragma mark - getter
- (FMDatabase *)fmdb {
    if (!_fmdb) {
        NSString *path = self.path.length ? self.path : [NSString getHomePath];
        NSString *dataBaseName = self.dataBaseName.length ? self.dataBaseName : @"IMChat";
        NSString *fmdbPath = [path stringByAppendingFormat:@"%@.sqlite", dataBaseName];
        _fmdb = [[FMDatabase alloc] initWithPath:fmdbPath];
    
    }
    return _fmdb;
}


@end
