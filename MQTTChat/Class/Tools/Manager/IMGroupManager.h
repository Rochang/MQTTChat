//
//  IMGroupManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMBaseManager.h"
#import "IMGroupModel.h"
#import "IMChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMGroupManager : IMBaseManager
/** 获取所有群 */
- (NSArray <IMGroupModel *>*)getAllGroups;

/** 开群, 返回群Id */
- (NSString *)creatGroup;

/** 加群 */
- (void)addGroupWithGroupId:(NSString *)group_id;

/** 删群 */
- (void)dismissGroupWithGroupId:(NSString *)group_id;

/** 退群 */
- (void)exitGroupWithGroupId:(NSString *)group_id;

/** 根据userId 踢人 */
- (void)kickUser:(NSString *)userId withGroupId:(NSString *)group_id;

/** 根据群Id保存聊天记录 */
- (void)insertChat:(IMChatModel *)model withGroupId:(NSString *)group_id;

/** 根据群Id 查询所有聊天记录 */
- (NSArray <IMChatModel *>*)getAllChatsWithGroupId:(NSString *)group_id;

/** 根据chatId删除聊天记录 */
- (void)deleteChat:(NSString *)chatId withGroupId:(NSString *)Group_id;

@end

NS_ASSUME_NONNULL_END