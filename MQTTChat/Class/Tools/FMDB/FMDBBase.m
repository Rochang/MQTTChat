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

- (BOOL)creatTable:(NSString *)tableName sqlstr:(NSString *)sqlstr {
    if ([self isTableExistWithTableName:tableName]) {
        NSLog(@"%@ 表已存在", tableName);
        return YES;
    }
    // 创建表
    return [self executeUpdateSqlStr:sqlstr];
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
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    return [self executeUpdateSqlStr:sqlstr];
}

- (BOOL)resetTable:(NSString *)tableName {
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    return [self executeUpdateSqlStr:sqlstr];
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

- (BOOL)deleteDatasWithTable:(NSString *)tableName Key:(NSString *)key value:(NSString *)value {
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", tableName, key, value];
    return [self executeUpdateSqlStr:sql];
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

- (BOOL)executeUpdateSqlStr:(NSString *)sqlstr {
    if ([self.fmdb open]) {
        BOOL flag = [self.fmdb executeUpdate:sqlstr];
        [self.fmdb close];
        if (!flag)  NSLog(@"FMDB 执行失败 : %@", sqlstr)
        return flag;
    }
    return NO;
}

- (void)dataIsExistsInTable:(NSString *)tableName key:(NSString *)key value:(NSString *)value completed:(completeBlock)completed {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';", tableName, key, value];
        FMResultSet *set = [self.fmdb executeQuery:sql];
        if (completed) {
            completed([set next]);
        }
        [self.fmdb close];
    }
}

#pragma mark - getter
- (FMDatabase *)fmdb {
    if (!_fmdb) {
        self.path = self.path.length ? self.path : [NSString homePath];
        self.dataBaseName = self.dataBaseName.length ? self.dataBaseName : @"IMChat";
        self.fmdbPath = [self.path stringByAppendingFormat:@"%@.sqlite", self.dataBaseName];
        _fmdb = [[FMDatabase alloc] initWithPath:self.fmdbPath];
    
    }
    return _fmdb;
}


@end
