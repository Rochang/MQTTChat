//
//  IMFMDBManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/11.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBBase.h"
#import "IMGroupModel.h"
#import "IMChatModel.h"
#import "IMUserModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface IMFMDBManager : FMDBBase
/** 单利 */
+ (instancetype)shareInstance;

/** 重建数据库 */
- (void)resetAllTable;

/** 数据库初始化检查 */
- (void)createTableIfNotExists;

/** 添加好友 */
- (void)addFirend:(IMUserModel *)firend;
- (void)addFirends:(NSArray <IMUserModel *>*)firends;

/** 查询用户列表 */
- (NSMutableArray *)getFirendList;

/** 根据 userId 查询好友 */
- (IMUserModel *)FirendWithId:(NSString *)firendId;

/** 根据userId 删除好友 */
- (void)removeFirendWithId:(NSString *)firendId;

#pragma mark - 通知
/** 添加通知 */
- (void)addNotification:(IMModel *)model;
- (void)addNotifications:(NSArray <IMModel *>*)models;

/** 标记通知已读 */
- (void)makeNotificationRead:(IMModel *)model;


@end

NS_ASSUME_NONNULL_END
