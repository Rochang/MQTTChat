//
//  IMConversationManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMBaseManager.h"
@class IMModel;
NS_ASSUME_NONNULL_BEGIN

@interface IMConversationManager : IMBaseManager

/** 插入会话 */
- (void)insertConversation:(IMModel *)model;
//
///** 删除会话 */
//- (void)deleteConversation:(NSString *)conversation_id;
//
///** 获取最近所有会话 */
//- (NSArray <IMConversationModel *>*)getAllConversations;

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
