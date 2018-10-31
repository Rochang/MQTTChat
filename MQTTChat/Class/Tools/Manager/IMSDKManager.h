//
//  IMSDKManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMUserManager.h"
#import "IMConversationManager.h"
#import "IMNotificationManager.h"
#import "IMGroupManager.h"

#define IMShare [IMSDKManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface IMSDKManager : NSObject

@property (strong, nonatomic) IMUserManager *userManager; // 好友
@property (strong, nonatomic) IMNotificationManager *notificationManager; // 通知
@property (strong, nonatomic) IMConversationManager *conversationManager; // 会话
@property (strong, nonatomic) IMGroupManager *groupManager; // 群


+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
