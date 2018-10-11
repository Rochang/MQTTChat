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

#define kConversationTableName       @"t_conversation"
#define kGroupTableName              @"t_grooup"
#define kChatTableName               @"t_chat"

/** 信息类型 */
typedef NS_ENUM(NSUInteger, IMMessageType) {
    IMMessageTypeText,  // 文字
    IMMessageTypeSound, // 语音
    IMMessageTypeFile,  // 文件
    IMMessageTypePicture // 图片
};

/** 会话形式 */
typedef NS_ENUM(NSUInteger, IMChatType) {
    IMChatTypeP2P,   // 私聊
    IMChatTypeGroup  // 群聊
};

#endif /* Project_Macro_h */
