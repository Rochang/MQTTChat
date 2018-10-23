//
//  ChatFMDBBase.m
//  Eccs
//
//  Created by 罗函 on 2017/9/22.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "ChatFMDBBase.h"

static const NSString *tag = @"ChatDBBase";

@implementation ChatFMDBBase

- (void)reset {
    _path = nil;
    _fmdb = nil;
}

- (NSString *)dataBaseName {
    if(!_dataBaseName) _dataBaseName = @"IMChatDB";
    return _dataBaseName;
}

- (NSString *)path {
    if(!_path) {
        _path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _path = [_path stringByAppendingPathComponent:@"imData"];
        NSString *imid = SIMIMSDK_SHARE.currentUserId;
        if(imid) {
            _path = [_path stringByAppendingPathComponent:imid];
        }
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        if (![fileManager fileExistsAtPath:_path]) {
            [fileManager createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _path;
}

- (FMDatabase *)fmdb {
    if(!_fmdb) {
        _fmdb = [self dataBase];
    }
    return _fmdb;
}

// FMDatabase
- (FMDatabase *)dataBase {
    NSString *fileName = [self.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", self.dataBaseName]];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    return db;
}

// 打开数据库并创建表
- (BOOL)createTable:(NSString *)tableName formatStr:(NSString *)formatStr {
    BOOL isRes = NO;
    if ([self.fmdb open]) {
        if ([self.fmdb executeUpdate:formatStr]) {
            NSString *displayText = [NSString stringWithFormat:@"创建表成功:%@/%@", self.path, tableName];
            ChatLog(tag, displayText);
            isRes = YES;
        }
        [self.fmdb close];
    }
    return isRes;
}

// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName {
    BOOL isRes = NO;
    if([self.fmdb open]) {
        isRes = YES;
        FMResultSet *rs = [self.fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
        while ([rs next]) {
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count) {
                isRes = NO;
            }
        }
        [self.fmdb close];
    }
    return isRes;
}

// 获得表的数据条数
- (NSInteger) getTableItemCount:(NSString *)tableName {
    NSString *sqlstr = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@", tableName];
    FMResultSet *rs = [self.fmdb executeQuery:sqlstr];
    while ([rs next])  {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        return count;
    }
    return 0;
}

// 删除表
- (BOOL)deleteTable:(NSString *)tableName {
    BOOL isRes = YES;
    if([self.fmdb open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
        if (![self.fmdb executeUpdate:sqlstr]) {
            ChatLog(tag, @"Delete table error!");
            isRes = NO;
        }
        [self.fmdb close];
    }
    return isRes;
}

// 清除表
- (BOOL)eraseTable:(NSString *)tableName {
    BOOL isRes = YES;
    if([self.fmdb open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        if (![self.fmdb executeUpdate:sqlstr])  {
            ChatLog(tag, @"Erase table error!");
            isRes = NO;
        }
        [self.fmdb close];
    }
    return isRes;
}

// 遍历该数据库下的某张表
- (void)queryDataByTableName:(NSString *)tableName db_result:(void(^)(FMResultSet *obj))result db_complete:(DBFinish)complete {
    if(!result || !tableName) return;
    if([self.fmdb open]) {
        FMResultSet* resultSet=[self.fmdb executeQuery:[NSString stringWithFormat:@"select* from %@", tableName]];
        while ([resultSet next]) {
            if(result) result(resultSet);
        }
        if(complete) complete();
        [self.fmdb close];
    }
}

/**
 判断某张表内是否存在某条数据
 
 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param option 返回结果
 */
- (void)dataIsExistsInTable:(NSString *)tableName  primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_option:(DBBlock)option {
    if(!self.fmdb.open) return;
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';",tableName,primaryKey,primaryValue];
    FMResultSet *set = [self.fmdb executeQuery:sql];
    if (option) {
        if ([set next]) {
            option(YES);
        } else {
            option(NO);
        }
        [set close];
    }
    [self.fmdb close];
}

/**
 根据属性获取表中数据
 
 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param result 返回句柄
 */
- (void)queryDataByPrimaryKey:(NSString *)tableName primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_result:(DBResultSet)result {
    if(!self.fmdb.open) return;
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';",tableName,primaryKey,primaryValue];
    FMResultSet *set = [self.fmdb executeQuery:sql];
    if (result) {
        if ([set next]) {
            result(set);
        } else {
            result(nil);
        }
        [set close];
    }
    [self.fmdb close];
}


+ (NSInteger)nowTimeStamp {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

@end
