//
//  IMSDKManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMFriendManager.h"
#import "IMConversationManager.h"
#import "IMNotificationManager.h"

#define IMShare [IMSDKManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface IMSDKManager : NSObject

@property (strong, nonatomic) IMFriendManager *friendManager;
@property (strong, nonatomic) IMNotificationManager *notificationManager;
@property (strong, nonatomic) IMConversationManager *conversationManager;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
