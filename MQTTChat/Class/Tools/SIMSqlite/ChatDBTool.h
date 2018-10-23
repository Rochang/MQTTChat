//
//  ChatDBTool.h
//  SIMIMSDK_Example
//
//  Created by 罗函 on 2017/10/13.
//  Copyright © 2017年 LuohanCC. All rights reserved.
//

#import "ChatFMDBBase.h"

#define SIMDB_SHARE [ChatDBTool shared]

@class SIMUsersModel, SIMModel, SIMConversation;

@interface ChatDBTool : ChatFMDBBase
+ (instancetype)shared;

// 重建数据库
- (void)resetAllTable;

// 数据库初始化检查
- (void)createTableIfNotExists;


#pragma mark - 用户表操作
/**
 插入一组用户数据
 
 @param users 用户数组
 @param block 操作完成的回调
 */
- (void)insetUsers:(NSArray <SIMUsersModel *>*)users db_block:(DBBlock)block;


/**
 插入一个用户
 
 @param user 用户
 */
- (void)insetUser:(SIMUsersModel *)user db_block:(DBBlock)block;

/**
 查询用户列表
 
 @param result 返回结果
 */
- (void)quertUsersList:(void(^)(NSArray *))result;

/**
 根据属性查找用户
 
 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param result SIMUsersModel
 */
- (void)userIsExists:(NSString *)tableName primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_result:(DBResult)result;

/**
 根据用户Id删除一个用户
 
 @param userId 用户Id
 @param db_block 操作结果
 */
- (void)removeUser:(NSString *)userId db_block:(DBFinish)db_block;


#pragma mark - 通知表操作
/**
 插入一条通知
 
 @param simData 通知
 @param conversation 聊天消息所属会话(传空则不会更新会话，仅仅更新该条消息)
 */
- (void)insetNotification:(SIMModel *)simData db_block:(DBBlock)block;

/**
 标记一条通知为已读
 
 @param notificationInfo 通知内容
 @param block 操作结果
 */
- (void)markNotificationReadState:(SIMModel *)notificationInfo db_block:(DBBlock)block;

/**
 查询所有通知信息
 
 @param result 通知数组
 */
- (void)quertNotificationList:(void(^)(NSArray *))result;


#pragma mark - 聊天表、会话表操作

/**
 存储一条新消息，同时更新该消息所属的会话
 
 @param simData 聊天消息
 @param block 聊天消息入库结果
 @param conversation 聊天消息所属会话
 */
- (void)insetSession:(SIMModel *)simData db_block:(DBBlock)block db_conversation:(DBUpdateConversation)conversation;

/**
 更新一条消息
 
 @param simData 聊天消息
 @param block 操作结果
 */
- (void)updateSession:(SIMModel *)simData db_block:(DBBlock)block;

/**
 某条消息是否存在
 
 @param messageId 消息ID
 @param block 是否存在
 */
- (void)sessionIfExist:(NSString *)messageId db_block:(DBBlock)block;

/**
 查询视频、语音通话的消息
 
 @param result 操作结果
 */
- (void)queryDialogSession:(DBArray)result;

/**
 查询所有聊天消息
 
 @param result 会话数组
 */
- (void)quertSessionList:(void(^)(NSArray *))result;

/**
 根据聊天信息更新会话表
 
 @param simModel 聊天信息
 @param block 会话入库结果
 @param conversationResult 该聊天所属会话, 是否是产生新的会话
 */
- (void)updateConversation:(SIMModel *)simModel db_block:(DBBlock)block db_conversationResult:(DBUpdateConversation)conversationResult;

/**
 获取所有会话
 
 @param result 操作结果
 */
- (void)allConversation:(void(^)(NSArray *))result;

/**
 获取会话下所有消息
 
 @param conversation 会话
 @param pageIndex 页Index
 @param pageSize 每页多少条数据
 @param result (数据数组，总共多少页)
 */
- (void)chatInfosInConversation:(SIMConversation *)conversation :(NSInteger)pageIndex pageSize:(NSInteger)pageSize db_result:(void(^)(NSArray *, NSInteger))result;

/**
 标记某个会话的未读数为0
 
 @param conversation 会话
 @param isComplete 操作结果
 */
- (void)markUnReadState:(SIMConversation *)conversation isComplete:(DBBlock)isComplete;

/**
 根据sessionId获取会话（用于从通讯录跳转至聊天界面时获取历史聊天消息）
 
 @param sessionId 对方的Id
 @param db_result 操作结果
 */
- (void)queryConversationBySessionId:(NSString *)sessionId db_result:(DBResult)db_result;

/**
 删除一个会话及会话下的所有消息
 
 @param conversation 将要被删除的会话
 @param db_block 操作结果
 */
- (void)deleteAllmessagesFromConversation:(SIMConversation *)conversation db_block:(DBBlock)db_block;

@end
