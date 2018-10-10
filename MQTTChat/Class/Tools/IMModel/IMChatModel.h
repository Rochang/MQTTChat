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

@property (copy, nonatomic) NSString *chat_id; // 对话Id
@property (copy, nonatomic) NSString *chat_time; // 对话时间
@property (assign, nonatomic) BOOL isRead; // 对话是否已读
@property (assign, nonatomic) IMChatType chat_type; // 对话类型
@property (strong, nonatomic) IMUserModel *chat_from; // 发送者
@property (strong, nonatomic) IMUserModel *chat_to; // 接收者
@property (strong, nonatomic) IMChatContentModel *chat_content; // 会话内容

@end

NS_ASSUME_NONNULL_END
