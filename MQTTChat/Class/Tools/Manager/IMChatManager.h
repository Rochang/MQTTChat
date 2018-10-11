//
//  IMChatManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//  单聊

#import "IMBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMChatManager : IMBaseManager

/** 获取全部好友 */
- (NSArray *)getALLFriends;

/** 申请添加好友 */
- (void)applyToaddUser:(NSString *)userId message:(NSString *)message;

/** 删除好友 */
- (void)deleteUser:(NSString *)userId;

/** 添加好友 */
- (void)addFriend:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
