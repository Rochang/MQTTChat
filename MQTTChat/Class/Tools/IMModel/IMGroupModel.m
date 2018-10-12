//
//  IMGroupModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMGroupModel.h"

@implementation IMGroupModel

+ (NSString *)db_group_id {
    return @"group_id";
}

+ (NSString *)db_group_unReadCount {
    return @"group_unReadCount";
}

+ (NSString *)db_group_users {
    return @"group_users";
}

+ (NSString *)db_group_chats {
    return @"group_chats";
}

+ (NSString *)db_group_chat_last {
    return @"group_chat_last";
}

@end
