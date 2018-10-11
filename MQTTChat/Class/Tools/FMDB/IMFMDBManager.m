//
//  IMFMDBManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/11.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMFMDBManager.h"
#import "FMDBBase.h"
#import "MJExtension.h"

@implementation IMFMDBManager

- (void)createConversationTable {
     NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_lastConversation];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)insertConversationModel:(IMConversationModel *)model {
    NSDictionary *jsonStr = [model.lastConversation ]
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@) values('%@','%@','%f')", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_lastConversation];
}



- (void)createGroupTable {
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)", kGroupTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_unReadCount, IMGroupModel.db_group_users, IMGroupModel.db_group_chats];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)createChatTable {
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, , %@ TEXT, , %@ TEXT, , %@ TEXT, , %@ TEXT)", kChatTableName, IMChatModel.db_chat_id, IMChatModel.db_chat_time, IMChatModel.db_isRead, IMChatModel.db_chat_type, IMChatModel.db_chat_from, IMChatModel.db_chat_to, IMChatModel.db_chat_content];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

@end
