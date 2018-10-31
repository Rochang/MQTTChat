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

@class FMResultSet;

NS_ASSUME_NONNULL_BEGIN

@interface IMGroupModel : NSObject

@property (copy, nonatomic) NSString *Id; // 群Id
@property (copy, nonatomic) NSString *name; // 群名称

//@property (copy, nonatomic) NSString *group_unReadCount; // 群信息未读数
//@property (strong, nonatomic) NSArray <IMUserModel *>*group_users; // 群成员
//@property (strong, nonatomic) IMChatModel *group_chat_last; // 最后一条群消息
//@property (strong, nonatomic) NSArray <IMChatModel *>*group_chats; // 聊天记录

+ (NSString *)db_Id;
+ (NSString *)db_name;

+ (instancetype)modelWithFMResultSet:(FMResultSet *)result;

@end

NS_ASSUME_NONNULL_END
