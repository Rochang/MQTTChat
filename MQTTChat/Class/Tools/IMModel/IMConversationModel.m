//
//  IMConversationModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMConversationModel.h"

@implementation IMConversationModel

+ (NSString *)db_conversation_id {
    return @"conversation_id";
}

+ (NSString *)db_conversation_unReadCount {
    return @"conversation_unReadCount";
}

+ (NSString *)db_Conversation_last {
    return @"conversation_last";
}

@end
