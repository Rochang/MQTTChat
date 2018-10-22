//
//  Project-Macro.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#ifndef Project_Macro_h
#define Project_Macro_h

#define kHost @"106.14.93.204"
#define Kport 1883
//#define kHost @"127.0.0.1"
//#define Kport 6969

#define kUserName @"accountName"
#define kUserPassWard @"passWard"

// 最近会话表
#define kConversationTableName       @"t_conversation"
// 群表
#define kGroupTableName              @"t_grooup"
// 群聊天记录表
#define kGroupChatTableName          @"t_grooup_chat"
// 单聊表
#define kP2PTableName                @"t_P2P"
// 单聊聊天记录表
#define kP2PChatTableName            @"t_P2P_chat"

// 消息类型
typedef NS_ENUM(NSInteger, IMCommandType) {
    IMCommandTypeNone         = 0,   //None
    IMCommandTypeChat         = 1,   //1:聊天
    IMCommandTypeNotification = 2,   //2:通知
    IMCommandTypeOrder        = 3,   //3:指令
    IMCommandTypeFeedback     = 4,   //4:反馈
    IMCommandResponse         = 6,   //6:响应
    IMCommandBroadcast        = 7    //7:广播
};

// 对话类型
typedef NS_ENUM(NSUInteger, IMChatType) {
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
};

/** 信息类型 */
typedef NS_ENUM(NSUInteger, IMMessageType) {
    IMMessageTypeText,  // 文字
    IMMessageTypeSound, // 语音
    IMMessageTypeLocation, // 地址
    IMMessageTypeFile,  // 文件
    IMMessageTypePicture, // 图片
    IMMessageTypeVideo, // 短视频
    IMMessageTypeVideoSession, // 视频会话
    IMMessageTypeAudioSession // 语音会话
};

static NSString * const KuserMessageListTopic =             @"im/api/v1/message/user/list";
static NSString * const KuserAccountSearchTopic =           @"im/api/v1/search";
static NSString * const KgroupMessageListTopic =            @"im/api/v1/message/group/list";
static NSString * const KfriendsListTopic =                 @"im/api/v1/user/friend/list";
static NSString * const KremoveFriendTopic =                @"im/api/v1/user/friend/delete";
static NSString * const KaddFriendTopic =                   @"im/api/v1/user/friend/request";
static NSString * const KacceptOrRejectFriendTopic =        @"im/api/v1/user/friend/response";
static NSString * const KgroupersListTopic =                @"im/api/v1/user/group/list";
static NSString * const KquitGroupTopic =                   @"im/api/v1/user/group/delete";
static NSString * const KaddGroupTopic =                    @"im/api/v1/user/group/request";
static NSString * const KacceptOrRejectGroupApplyTopic =    @"im/api/v1/user/group/response";
static NSString * const KcreateGroupTopic =                 @"im/api/v1/group/create";
static NSString * const KdeleteGroupTopic =                 @"im/api/v1/group/delete";
static NSString * const KaddGroupMemberTopic =              @"im/api/v1/group/member/create";
static NSString * const KdeleteGroupMemberTopic =           @"im/api/v1/group/member/delete";
static NSString * const KgroupMemberListTopic =             @"im/api/v1/group/member/list";

#endif /* Project_Macro_h */
