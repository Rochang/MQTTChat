//
//  IMSDKManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMFriendManager.h"

#define IMShare [IMSDKManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface IMSDKManager : NSObject

@property (strong, nonatomic) IMFriendManager *friendManager;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END