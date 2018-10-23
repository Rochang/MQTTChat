//
//  ChatFMDBBase.h
//  Eccs
//
//  Created by 罗函 on 2017/9/22.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


#define ChatLog(tag, str)                          NSLog(@"%@  ○-○-○-○-○-○-○  %@", tag, str)
#define ChatLogFromat(tag, str)                    NSLog([NSString stringWithFormat:@"%@  ○-○-○-○-○-○-○  %@", tag, str])



@class SIMConversation;
typedef void (^DBFinish)();
typedef void (^DBBlock)(BOOL isCompleted);
typedef void (^DBResult)(NSObject *obj);
typedef void (^DBArray)(NSArray *arr);
typedef void (^DBResultSet)(FMResultSet *set);
typedef void (^DBUpdateConversation)(SIMConversation *, BOOL);


@interface ChatFMDBBase : NSObject
@property (nonatomic ,strong) FMDatabase *fmdb; //fmdb
@property (nonatomic ,strong) NSString *path;   //sqlite所在位置
@property (nonatomic ,strong) NSString *dataBaseName;  //sqlite的名称

- (void)reset;
// FMDatabase
- (FMDatabase *)dataBase;
// 打开数据库并创建表
- (BOOL)createTable:(NSString *)tableName formatStr:(NSString *)formatStr;
// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName;
// 获得表的数据条数
- (NSInteger)getTableItemCount:(NSString *)tableName;
// 删除表
- (BOOL)deleteTable:(NSString *)tableName;
// 清除表
- (BOOL)eraseTable:(NSString *)tableName;
// 遍历该数据库下的某张表
- (void)queryDataByTableName:(NSString *)tableName db_result:(void(^)(FMResultSet *obj))result db_complete:(DBFinish)complete;

/**
 判断某张表内是否存在某条数据
 
 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param option 返回结果
 */
- (void)dataIsExistsInTable:(NSString *)tableName  primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_option:(DBBlock)option;

/**
 根据属性获取表中数据
 
 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param result 返回句柄
 */
- (void)queryDataByPrimaryKey:(NSString *)tableName primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_result:(DBResultSet)result;

+ (NSInteger)nowTimeStamp;
@end
