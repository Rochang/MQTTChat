//
//  IMGroupModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMUserModel.h"
#import "IMChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMGroupModel : NSObject

@property (copy, nonatomic) NSString *group_id; // 群Id
@property (copy, nonatomic) NSString *group_unReadCount; // 群信息未读数
@property (strong, nonatomic) NSArray <IMUserModel *>*group_users; // 群成员
@property (strong, nonatomic) NSArray <IMChatModel *>*group_chats; // 群消息

@end

NS_ASSUME_NONNULL_END
