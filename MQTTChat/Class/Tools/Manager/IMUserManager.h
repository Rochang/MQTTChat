//
//  IMUserManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMBaseManager.h"

NS_ASSUME_NONNULL_BEGIN
// 个人操作manager
@interface IMUserManager : IMBaseManager

/** 处理请求响应 */
- (void)userHandldRsponse:(IMModel *)model;

/** 获取好友列表 */
- (void)publishFriendsList;
- (NSArray <IMUserModel *>*)getFriendsList;

#pragma mark - 群组
/** 获取群组列表 */
- (void)publishGroupsList;
- (NSArray <IMGroupModel *>*)getGroupsList;

@end

NS_ASSUME_NONNULL_END
