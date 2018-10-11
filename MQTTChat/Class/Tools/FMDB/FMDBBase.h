//
//  FMDBBase.h
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

#define FMDBBaseShare [FMDBBase shareInstance]

NS_ASSUME_NONNULL_BEGIN
typedef void(^resultBlock)(FMResultSet *result);

@interface FMDBBase : NSObject

@property (nonatomic ,copy) NSString *path; //sqlite所在位置
@property (nonatomic ,copy) NSString *dataBaseName;  //sqlite的名称

+ (instancetype)shareInstance;
- (void)setFMDBPath:(NSString *)path dataBaseName:(NSString *)dataName;

/** 创建表 */
- (void)creatTable:(NSString *)tableName sqlstr:(NSString *)sqlstr;

/** 判断表是否存在 */
- (BOOL)isTableExistWithTableName:(NSString *)name;

/** 删除表 */
- (BOOL)deleteTable:(NSString *)tableName;

/** 清除表 */
- (BOOL)resetTable:(NSString *)tableName;

/** 遍历某张表的数据 */
- (void)queryAllDatasWithTable:(NSString *)tableName db_result:(resultBlock)result;

/** 根据条件查询数据 */
- (void)queryDatasWithTable:(NSString *)tableName db_key:(NSString *)key db_alue:(NSString *)value db_result:(resultBlock)db_result;

/** 增加数据 */
- (void)insertDatasWithTable:(NSString *)tableName sqlStr:(NSString *)sqlstr;

///** 删除数据 */
//- (void)deleteDatasWhthTable:(NSString *)tableName sqlStr:(NSString *)sqlstr;
//
///** 改变数据 */
//- (void)changeDatasWithTable:(NSString *)tableName sqlStr:(NSString *)sqlstr;

@end

NS_ASSUME_NONNULL_END
