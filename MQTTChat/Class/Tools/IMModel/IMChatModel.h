//
//  IMChatModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//  对话Model

#import <Foundation/Foundation.h>
#import "IMUserModel.h"
#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMChatModel : NSObject

@property(nonatomic, assign) IMChatType type;
@property(nonatomic, copy) NSString *text;// 文本内容
@property(nonatomic, copy) NSString *text_succedaneum; // 优先于text显示
@property(nonatomic, strong) NSString *message_id;// 信息Id
//@property(nonatomic, strong) SIMVoice *voice;// 语音
//@property(nonatomic, strong) SIMImage *image;// 图片
//@property(nonatomic, strong) SIMVideo *video;// 视频
//@property(nonatomic, strong) SIMFile *file;// 文件
//@property(nonatomic, strong) SIMInlineImage *inline_image;// 内嵌图片
//@property(nonatomic, strong) SIMLocation *location;// 位置
//@property(nonatomic, strong) SIMVoiceDialog *video_dialog;// 视频会话
//@property(nonatomic, strong) SIMVoiceDialog *voice_dialog;// 音频会话
//@property(nonatomic, strong) SIMLive *live;// 直播
//@property(nonatomic, strong) SIMEvent *event;// 事件
//@property(nonatomic, strong) SIMDirIntercom *intercom;// 对讲
//@property(nonatomic, strong) SIMDrawingBoard *wb;// 画板
//@property (nonatomic, strong) SIMAlarm *alarm;
//@property(nonatomic, strong) NSNumber *display_now;

//@property (copy, nonatomic) NSString *chat_id; // 对话Id
//@property (copy, nonatomic) NSString *chat_time; // 对话时间
//@property (assign, nonatomic) BOOL isRead; // 对话是否已读
//@property (assign, nonatomic) IMChatType chat_type; // 对话类型
//@property (strong, nonatomic) IMUserModel *chat_from; // 发送者
//@property (strong, nonatomic) IMUserModel *chat_to; // 接收者
//@property (strong, nonatomic) IMChatContentModel *chat_content; // 会话内容

+ (NSString *)db_chat_id;
+ (NSString *)db_chat_time;
+ (NSString *)db_isRead;
+ (NSString *)db_chat_type;
+ (NSString *)db_chat_from;
+ (NSString *)db_chat_to;
+ (NSString *)db_chat_content;


@end

NS_ASSUME_NONNULL_END
