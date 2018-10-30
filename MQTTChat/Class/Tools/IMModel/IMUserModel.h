//
//  IMUserModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//  用户Model

#import <Foundation/Foundation.h>
@class FMResultSet;

NS_ASSUME_NONNULL_BEGIN

@interface IMUserModel : NSObject

@property (nonatomic, copy) NSString *Id;       //用户ID
@property (nonatomic, copy) NSString *name;     //用户名
@property (nonatomic, copy) NSString *nick;     //备注名称
@property (nonatomic, copy) NSString *avator;   //头像URL
@property (nonatomic, assign) BOOL is_online;   //在线状态

+ (NSString *)db_Id;
+ (NSString *)db_name;
+ (NSString *)db_nick;
+ (NSString *)db_avator;
+ (NSString *)db_is_online;


+ (instancetype)modelWithFMResultSet:(FMResultSet *)result;

@end

NS_ASSUME_NONNULL_END
