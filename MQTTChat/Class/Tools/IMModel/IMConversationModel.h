//
//  IMConversationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMConversationModel : NSObject

@property (copy, nonatomic) NSString *conversation_id; // 会话Id
@property (copy, nonatomic) NSString *conversation_unReadCount; // 对话未读数
@property (strong, nonatomic) IMChatModel *lastConversation; // 会话的对话

+ (NSString *)db_conversation_id;
+ (NSString *)db_conversation_unReadCount;
+ (NSString *)db_lastConversation;

@end

NS_ASSUME_NONNULL_END
