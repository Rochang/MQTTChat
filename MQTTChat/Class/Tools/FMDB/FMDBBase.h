//
//  FMDBBase.h
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^resultBlock)(FMResultSet *result);
typedef void (^completeModelBlock)(BOOL flag, IMModel *model);
typedef void (^upConversationBlock)(BOOL flag, IMConversationModel *model);
typedef void (^completeSetBlock)(BOOL flag, FMResultSet *result);
typedef void (^completeBlock)(BOOL flag);

@interface FMDBBase : NSObject

@property (nonatomic ,copy) NSString *path; //sqlite所在位置
@property (nonatomic ,copy) NSString *dataBaseName;  //sqlite的名称
@property (nonatomic ,copy) NSString *fmdbPath;  // 数据库全路径

+ (instancetype)shareInstance;
- (void)setFMDBPath:(NSString *)path dataBaseName:(NSString *)dataName;

/** 创建表 */
- (BOOL)creatTable:(NSString *)tableName sqlstr:(NSString *)sqlstr;

/** 判断表是否存在 */
- (BOOL)isTableExistWithTableName:(NSString *)name;

/** 删除表 */
- (BOOL)deleteTable:(NSString *)tableName;

/** 清除表 */
- (BOOL)resetTable:(NSString *)tableName;

/** 删除数据库 */
- (void)deleteDatabase;

/** 遍历某张表的数据 */
- (void)queryAllDatasWithTable:(NSString *)tableName db_result:(resultBlock)result;

/** 根据条件查询数据 */
- (void)queryDatasWithTable:(NSString *)tableName db_key:(NSString *)key db_value:(NSString *)value db_result:(resultBlock)db_result;

/** 根据条件删除数据 */
- (BOOL)deleteDatasWithTable:(NSString *)tableName Key:(NSString *)key value:(NSString *)value;

/** FMDB 执行操作语句 */
- (BOOL)executeUpdateSqlStr:(NSString *)sqlstr;

/** 判断数据是否存在 */
- (void)isDataExistsInTable:(NSString *)tableName key:(NSString *)key value:(NSString *)value completed:(completeSetBlock)completed;

//
///** 改变数据 */
//- (void)changeDatasWithTable:(NSString *)tableName sqlStr:(NSString *)sqlstr;

@end

NS_ASSUME_NONNULL_END
