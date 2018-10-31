//
//  IMFMDBManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/11.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBBase.h"

#define FMDBShare [IMFMDBManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface IMFMDBManager : FMDBBase
/** 单利 */
+ (instancetype)shareInstance;

#pragma mark - 好友

/** 插入好友 */
- (void)insertFirend:(IMUserModel *)firend;
- (void)insertFirends:(NSArray <IMUserModel *>*)firends;

/** 查询好友列表 */
- (NSArray <IMUserModel *>*)queryFirendList;

/** 根据 userId 查询好友 */
- (IMUserModel *)FirendWithId:(NSString *)firendId;

/** 根据userId 删除好友 */
- (void)removeFirendWithId:(NSString *)firendId;

#pragma mark - 群组
/** 插入群组 */
- (void)insertGroup:(IMGroupModel *)group;
- (void)insertGroups:(NSArray <IMGroupModel *>*)groups;

/** 查询群列表 */
- (NSArray <IMGroupModel *>*)queryGroupList;

#pragma mark - 通知
/** 添加通知 */
- (void)addNotification:(IMModel *)model;
- (void)addNotifications:(NSArray <IMModel *>*)models;

/** 标记通知已读 */
- (void)makeNotificationRead:(IMModel *)model;

/** 查询所有的通知 */
- (NSMutableArray *)getNotificationList;

#pragma mark - 会话
/** 添加聊天信息 */
- (void)addChatConversation:(IMModel *)model;



@end

NS_ASSUME_NONNULL_END
