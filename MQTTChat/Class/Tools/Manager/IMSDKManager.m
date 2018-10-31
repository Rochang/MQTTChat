//
//  IMSDKManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMSDKManager.h"

@implementation IMSDKManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static IMSDKManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - getter
- (IMUserManager *)userManager {
    if (!_userManager) {
        _userManager = [[IMUserManager alloc] init];
    }
    return _userManager;
}

- (IMConversationManager *)conversationManager {
    if (!_conversationManager) {
        _conversationManager = [[IMConversationManager alloc] init];
    }
    return _conversationManager;
}

- (IMNotificationManager *)notificationManager {
    if (!_notificationManager) {
        _notificationManager = [[IMNotificationManager alloc] init];
    }
    return _notificationManager;
}

- (IMGroupManager *)groupManager {
    if (!_groupManager) {
        _groupManager = [[IMGroupManager alloc] init];
    }
    return _groupManager;
}
    
@end
