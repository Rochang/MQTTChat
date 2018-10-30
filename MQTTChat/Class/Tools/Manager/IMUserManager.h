//
//  IMUserManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMBaseManager.h"
#import "IMUserModel.h"

NS_ASSUME_NONNULL_BEGIN
// 个人操作manager
@interface IMUserManager : IMBaseManager

/** 获取好友列表 */
- (void)publishFriendsList;
- (NSArray <IMUserModel *>*)getFriendsList;

/** 处理请求响应 */
- (void)handldRsponse:(IMModel *)model;

@end

NS_ASSUME_NONNULL_END
