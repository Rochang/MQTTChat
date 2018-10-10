//
//  IMConversationManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMConversationManager.h"

@implementation IMConversationManager

- (void)insertConverstaion:(IMConversationModel *)model {
    
}

- (void)insertChat:(IMChatModel *)model withConversationId:(NSString *)conversation_id {
    
}

- (NSArray<IMConversationModel *> *)getAllConversations {
    
    return nil;
}

- (NSArray<IMChatModel *> *)getAllChatsWithConversation:(NSString *)conversation_id {
    
    return nil;
}

- (void)readConversation:(NSString *)conversation_id {
    
}

- (void)deleteConversation:(NSString *)conversation_id {
    
}

- (void)deleteChat:(NSString *)chatId withConversationId:(NSString *)conversation_id {
    
    
}
@end
