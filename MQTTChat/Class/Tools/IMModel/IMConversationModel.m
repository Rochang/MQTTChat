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

- (void)db_updateModel:(IMModel *)model unReadCount:(NSInteger)unReadCount {
    _conversationType = model.group.Id.length ? IMConversationTypeGroup : IMConversationTypeP2P;
    _lastSession = model;
    if(!_messageIds) {
        _messageIds = model.chat.message_id;
    }else if(_messageIds && model.chat.message_id && ![_messageIds containsString:model.chat.message_id]) {
        _messageIds = [_messageIds stringByAppendingString:[NSString stringWithFormat:@",%@", model.chat.message_id]];
    }
    _unReadCount = unReadCount == -1 ? 0 : unReadCount;
}

+ (IMConversationModel *)modelWithIMModel:(IMModel *)imModel {
    IMConversationModel *comModel = [[IMConversationModel alloc] init];
    comModel.unReadCount = [imModel.from_user.Id isEqualToString:IMTools.userId] || imModel.isRead ? 0 : 1;
    comModel.conversationType = imModel.conversationType;
    comModel.sessionId   = imModel.sessionId;
    comModel.messageIds  = imModel.chat.message_id;
    comModel.lastSession = imModel.copy;
    return comModel;
}

+ (IMConversationModel *)modelWithResultSet:(FMResultSet *)set {
    IMConversationModel *model = [[IMConversationModel alloc] init];
    return model;
}
@end
