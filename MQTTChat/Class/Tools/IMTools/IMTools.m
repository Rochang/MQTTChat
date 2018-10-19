//
//  IMTools.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//  项目用到的Id

#import "IMTools.h"

@implementation IMTools

+ (NSString *)userId {
    return [LCMethod UD_getObjectForKey:kUserName];
}

+ (NSString *)clientId {
    return [NSString stringWithFormat:@"[2]_[%@]_[%@]_[%@]", @"com.sly.simsdk", [NSString getUUID], [self userId]];
}

+ (NSString *)userTopic {
    return [NSString stringWithFormat:@"im/user/%@",[self userId]];
}

+ (NSString *)systemNotificationTopic {
    return [NSString stringWithFormat:@"im/notification/#"];
}

+ (NSString *)grouperTopicWithGroupId:(NSString *)groupId {
    return [NSString stringWithFormat:@"im/group/%@", groupId];
}

+ (NSString *)groupeManagerTopic {
    return [NSString stringWithFormat:@"im/group/%@/notification/management", [self userId]];
}

+ (NSString *)broadcastTopic {
    return [NSString stringWithFormat:@"im/user/%@/broadcast", [self userId]];
}

@end
