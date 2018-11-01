//
//  IMConversationManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMBaseManager.h"
#import "IMConversationModel.h"
#import "IMFMDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMConversationManagerDelegate <NSObject>
/** 更新会话 */
- (void)conversationManagerFinishUpdateConversationModel:(IMModel *)model;

/** 插入聊天信息 */
- (void)conversationManagerFinishInsertChatModel:(IMModel *)model;

/** 消息发送成功 */
- (void)conversationManagerFinishSendMessageModel:(IMModel *)model;

@end

@interface IMConversationManager : IMBaseManager

/** 聊天窗口 Id */
@property (nonatomic, copy) NSString *currentChatId;

/** 处理会话 */
- (void)handleChatConversation:(IMModel *)model;

/** 获取所有会话 */
- (NSArray <IMConversationModel *>*)getAllConversations;

//- (void)setDelegate:(id <IMConversationManagerDelegate>)delegate currentChatId:(NSString *)chatId;
//- (void)removeDelegateAndChatId;

/** 未读数清零 */
- (void)resetUnReadCount:(IMConversationModel *)model complete:(completeBlock)complete;

///** 插入聊天信息, 更新会话 */
//- (void)insertChatConversation:(IMModel *)model;
//
///** 删除会话 */
//- (void)deleteConversation:(NSString *)conversation_id;
//

///** 根据会话Id保存聊天记录 */
//- (void)insertChat:(IMChatModel *)model withConversationId:(NSString *)conversation_id;

///** 根据会话Id 查询所有聊天记录 */
//- (NSArray <IMChatModel *>*)getAllChatsWithConversation:(NSString *)conversation_id;

///** 已读 */
//- (void)readConversation:(NSString *)conversation_id;

///** 根据会话Id删除聊天记录 */
//- (void)deleteChat:(NSString *)chatId withConversationId:(NSString *)conversation_id;
@end

NS_ASSUME_NONNULL_END
