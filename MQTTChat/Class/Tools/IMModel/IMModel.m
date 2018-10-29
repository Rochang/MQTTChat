//
//  IMModel.m
//  MQTTChat
//
//  Created by Rochang on 2018/10/21.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMModel.h"

@implementation IMModel

- (BOOL)myself {
    return [self.from_user.Id isEqualToString:[IMTools userId]] ? YES : NO;
}

- (BOOL)is_group {
    return self.group.Id.length;
}

+ (NSString *)dbkey_time {
    return @"time";
}
+ (NSString *)dbkey_fromUserId {
    return @"fromUserId";
}
+ (NSString *)dbkey_touserId {
    return @"toUserId";
}
+ (NSString *)dbkey_groupId {
    return @"groupId";
}
+ (NSString *)dbkey_info {
    return @"info";
}
+ (NSString *)dbkey_isRead {
    return @"isRead";
}
+ (NSString *)dbkey_isDispose {
    return @"isDispose";
}

/**
 IMChatTypeNone                        = 0,  // None
 IMChatTypeText                        = 1,  // 文本聊天
 IMChatTypeVoice                       = 2,  // 语音
 IMChatTypePictore                     = 3,  // 图片
 IMChatTypeVideo                       = 4,  // 视频
 IMChatTypeFile                        = 5,  // 文件
 IMChatTypeInlinePicture               = 6,  // 内嵌图片
 IMChatTypeLoction                     = 7,  // 位置
 IMChatTypeVideoSession                = 8,  // 视频会话
 IMChatTypeVoiceSession                = 9,  // 音频会话
 IMChatTypeLive                        = 10, // 直播
 IMChatTypeEvent                       = 11, // 事件
 IMChatTypeIntercom                    = 12, // 对讲
 IMChatTypeDrawingBoard                = 13, // 画板
 IMChatTypeAlarm                       = 14  // 报警
 */
- (NSString *)disPlayMessage {
    NSString *text = nil;
    switch (self.chat.type) {
        case IMChatTypeText:
            text = self.chat.text;
            break;
        case IMChatTypeVoice:
            text = @"[语音]";
            break;
        case IMChatTypePictore:
            text = @"[图片]";
            break;
        case IMChatTypeVideo:
            text = @"[视频]";
            break;
        case IMChatTypeFile:
            text = @"[文档]";
            break;
        case IMChatTypeInlinePicture:
            text = @"[文件]";
            break;
        case IMChatTypeLoction:
            text = @"[位置]";
            break;
        case IMChatTypeVideoSession:
            if(self.is_group) {
                NSString *userName = self.is_myself ? @"我" : self.from_user.name;
                text = [NSString stringWithFormat:@"%@发起了群视频", userName];
            }else{
                text = @"[视频聊天]";
            }
            break;
        case IMChatTypeAudioSession:
            if(self.is_group) {
                NSString *userName = self.is_myself ? @"我" : self.from_user.name;
                text = [NSString stringWithFormat:@"%@发起了群语音", userName];
            }else{
                text = @"[语音聊天]";
            }
            break;
        default:
            break;
    }
    return text;
}

- (BOOL)isTalkingWithFirend:(NSString *)friendId {
    if (self.group.Id.length) { // 群聊
        return [self.group.Id isEqualToString:friendId] ? YES : NO;
    } else { // 单聊
        return [self.from_user.Id isEqualToString:friendId] ? YES : NO;
    }
}

- (NSString *)getOppositeId {
    return [_from_user.Id isEqual:[IMTools userId]] ? _to_user.Id : _from_user.Id;
}

@end
