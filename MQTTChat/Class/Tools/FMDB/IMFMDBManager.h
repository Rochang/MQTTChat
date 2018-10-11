//
//  IMFMDBManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/11.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMConversationModel.h"
#import "IMGroupModel.h"
#import "IMChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMFMDBManager : NSObject
#pragma mark - conversation
/** 创建conversation 表 */
- (void)createConversationTable;
- (void)insertConversationModel:(IMConversationModel *)model;

#pragma mark - group
/** 创建group 表 */
- (void)createGroupTable;

#pragma mark - chat
/** 创建 对话 表 */
- (void)createChatTable;
@end

NS_ASSUME_NONNULL_END
