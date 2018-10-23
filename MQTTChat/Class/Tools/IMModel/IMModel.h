//
//  IMModel.h
//  MQTTChat
//
//  Created by Rochang on 2018/10/21.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMUserModel.h"
#import "IMGroupModel.h"
#import "IMChatModel.h"
#import "IMNotificationModel.h"
#import "IMDirectiveModel.h"

NS_ASSUME_NONNULL_BEGIN
// 请求/响应 基本model
@interface IMModel : NSObject

@property(nonatomic, copy)   NSString               *request_id; // 请求Id
@property(nonatomic, assign) IMCommandType          commandType;// 指令类型
@property(nonatomic, strong) NSNumber               *time;// 时间戳
@property (nonatomic, assign) BOOL                  isRead; // 是否已读

@property(nonatomic, strong) IMUserModel          *from_user;// 发出方
@property(nonatomic, strong) IMUserModel          *to_user;// 接收方
@property(nonatomic, strong) IMGroupModel          *group;// 群组
@property(nonatomic, strong) IMChatModel              *chat;//会话内容
@property(nonatomic, strong) IMNotificationModel   *notification;// 通知
@property(nonatomic, strong) IMDirectiveModel           *directive;//指令内容
//@property(nonatomic, strong) SIMFeedback            *feedback;//BASEMODEL
//@property(nonatomic, strong) SIMBaseModel           *request;//BASEMODEL
//@property(nonatomic, strong) SIMBaseModel           *response;//BASEMODEL
//@property(nonatomic, strong) SIMBroadcastModel           *broadcast;//BASEMODEL

@property (assign, nonatomic, readonly) BOOL is_myself; // 自己发送
@property (assign, nonatomic, readonly) BOOL is_group; // 自己发送
@property (copy, nonatomic, readonly) NSString *disPlayMessage; // 通知显示文字


/** 是否正在聊天 */
- (BOOL)isTalkingWithFirend:(NSString *)friendId;

@end

NS_ASSUME_NONNULL_END
