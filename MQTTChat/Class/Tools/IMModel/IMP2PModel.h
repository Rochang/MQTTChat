//
//  IMP2PModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/12.
//  Copyright © 2018年 Rochang. All rights reserved.
//  单聊

#import <Foundation/Foundation.h>
#import "IMChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMP2PModel : NSObject

@property (copy, nonatomic) NSString *p2p_id; // 会话Id
@property (copy, nonatomic) NSString *p2p_unReadCount; // 会话未读数
@property (strong, nonatomic) NSArray <IMChatModel *>*p2p_chats; // 会话所有消息

+ (NSString *)db_p2p_id;
+ (NSString *)db_p2p_unReadCount;
+ (NSString *)db_p2p_chats;

@end

NS_ASSUME_NONNULL_END
