//
//  IMModel.h
//  MQTTChat
//
//  Created by Rochang on 2018/10/21.
//  Copyright © 2018 Rochang. All rights reserved.
//  请求/响应 基本model

#import <Foundation/Foundation.h>
#import "IMUserModel.h"
#import "IMGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMModel : NSObject

@property(nonatomic, copy) NSString                 *request_id; // 请求Id
@property(nonatomic, assign) IMCommandType          commandType;// 指令类型
@property(nonatomic, strong) NSNumber               *time;// 时间戳
@property(nonatomic, strong) IMUserModel          *from_user;// 发出方
@property(nonatomic, strong) IMUserModel          *to_user;// 接收方
@property(nonatomic, strong) IMGroupModel          *group;// 群组
//@property(nonatomic, strong) SIMChat                *chat;//会话内容
//@property(nonatomic, strong) SIMNotificationModel   *notification;//BASEMODEL
//@property(nonatomic, strong) SIMDirective           *directive;//指令内容
//@property(nonatomic, strong) SIMFeedback            *feedback;//BASEMODEL
//@property(nonatomic, strong) SIMBaseModel           *request;//BASEMODEL
//@property(nonatomic, strong) SIMBaseModel           *response;//BASEMODEL
//@property(nonatomic, strong) SIMBroadcastModel           *broadcast;//BASEMODEL

@end

NS_ASSUME_NONNULL_END
