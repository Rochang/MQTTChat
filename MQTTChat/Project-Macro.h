//
//  Project-Macro.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#ifndef Project_Macro_h
#define Project_Macro_h

//#define kHost @"106.14.93.204"
//#define Kport 1883
#define kHost @"127.0.0.1"
#define Kport 6969

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

/** 会话形式 */
typedef NS_ENUM(NSUInteger, IMChatType) {
    IMChatTypeP2P,   // 私聊
    IMChatTypeGroup  // 群聊
};

#endif /* Project_Macro_h */
