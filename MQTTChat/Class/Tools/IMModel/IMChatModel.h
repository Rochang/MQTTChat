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
#import "IMVoiceModel.h"
#import "IMImageModel.h"
#import "IMVideoModel.h"
#import "IMFileModel.h"
#import "IMInlineImageModel.h"
#import "IMLocationModel.h"
#import "IMLiveModel.h"
#import "IMMediaModel.h"
#import "IMTalkbackModel.h"
#import "IMDrawBoardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMChatModel : NSObject

@property (nonatomic, assign) IMChatType type;
@property (nonatomic, copy) NSString *text;// 文本内容
@property (nonatomic, copy) NSString *text_succedaneum; // 优先于text显示
@property (nonatomic, strong) NSString *message_id;// 信息Id
@property (nonatomic, strong) IMVoiceModel *voice;// 语音
@property (nonatomic, strong) IMImageModel *image;// 图片
@property (nonatomic, strong) IMVideoModel *video;// 视频
@property (nonatomic, strong) IMFileModel *file;// 文件
@property (nonatomic, strong) IMInlineImageModel *inline_image;// 内嵌图片
@property (nonatomic, strong) IMLocationModel *location;// 位置
@property (nonatomic, strong) IMLiveModel *live;// 直播
@property (nonatomic, strong) IMMediaModel *video_dialog;// 视频会话
@property (nonatomic, strong) IMMediaModel *voice_dialog;// 音频会话
@property (nonatomic, strong) IMTalkbackModel *intercom;// 对讲
@property (nonatomic, assign) BOOL display_now; // 立即显示
@property (nonatomic, strong) IMDrawBoardModel *wb;// 画板


//+ (NSString *)db_chat_id;
//+ (NSString *)db_chat_time;
//+ (NSString *)db_isRead;
//+ (NSString *)db_chat_type;
//+ (NSString *)db_chat_from;
//+ (NSString *)db_chat_to;
//+ (NSString *)db_chat_content;


@end

NS_ASSUME_NONNULL_END
