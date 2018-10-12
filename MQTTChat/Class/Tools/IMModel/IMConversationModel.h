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
@property (strong, nonatomic) IMChatModel *conversation_last; // 最新的消息

+ (NSString *)db_conversation_id;
+ (NSString *)db_conversation_unReadCount;
+ (NSString *)db_onversation_last;

@end

NS_ASSUME_NONNULL_END
