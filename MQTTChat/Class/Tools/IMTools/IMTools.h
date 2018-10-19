//
//  IMTools.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMTools : NSObject
/** 获取uerId */
+ (NSString *)userId;

/** 获取clientId */
+ (NSString *)clientId;

/** 获取个人主题 */
+ (NSString *)userTopic;

/** 系统通知主题 */
+ (NSString *)systemNotificationTopic;

/** 群组相关主题 */
+ (NSString *)grouperTopicWithGroupId:(NSString *)groupId;

/** 群组管理员主题 */
+ (NSString *)groupeManagerTopic;

/** 用户广播 */
+ (NSString *)broadcastTopic;


@end

NS_ASSUME_NONNULL_END
