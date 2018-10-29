//
//  IMConversationModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/24.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMConversationModel.h"

@implementation IMConversationModel

+ (NSString *)dbkey_sessionType {
    return @"sessionType";
}

+ (NSString *)dbkey_unReadCount {
    return @"unReadCount";
}

+ (NSString *)dbkey_sessionId {
    return @"sessionId";
}

+ (NSString *)dbkey_messageIds {
    return @"messageIds";
}

+ (NSString *)dbkey_lastSession {
    return @"lastSession";
}


@end
