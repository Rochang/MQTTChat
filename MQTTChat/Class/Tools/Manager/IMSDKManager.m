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
- (IMFriendManager *)friendManager {
    if (!_friendManager) {
        _friendManager = [[IMFriendManager alloc] init];
    }
    return _friendManager;
}
@end
