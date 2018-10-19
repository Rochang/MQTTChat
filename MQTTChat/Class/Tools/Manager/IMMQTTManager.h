//
//  IMMQTTManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "IMBaseManager.h"
#import <MQTTClient.h>

@protocol IMMQTTManagerDelegate <NSObject>

/** MQTT 连接 */
- (void)MQTTConnect:(MQTTSession *)session;

@end

#define MQTTShare [IMMQTTManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface IMMQTTManager : IMBaseManager
/** 单利 */
+ (instancetype)shareInstance;

/** 连接 */
- (void)connectWithHost:(NSString *)host port:(UInt16)port userName:(NSString *)userName passWord:(NSString *)passWord clientId:(NSString *)clientId;

/** 断开连接 */
- (void)disConnect;

/** 订阅 */
- (void)subscribeTopic:(NSString *)topic;

/** 取消订阅 */
- (void)unSubscribeTopic:(NSString *)topic;

/** 发布(至少一次) */
- (void)publishDataAtMostOnce:(NSData *)data onTopic:(NSString *)topic;

/** 发布(至多一次) */
- (void)publishDataAtLeastOnce:(NSData *)data onTopic:(NSString *)topic;

@end

NS_ASSUME_NONNULL_END
