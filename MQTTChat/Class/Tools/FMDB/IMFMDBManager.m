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
#pragma mark - conversation
- (void)createConversationTable {
     NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_onversation_last];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)insertConversationModel:(IMConversationModel *)model {
    NSString *jsonStr = [model.conversation_last mj_JSONString];
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@) values('%@','%@','%@')", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_onversation_last, model.conversation_id, model.conversation_unReadCount, jsonStr];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (void)deleteConversation:(NSString *)conversationId {
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kConversationTableName, IMConversationModel.db_conversation_id ,conversationId];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (NSMutableArray<IMConversationModel *> *)getAllConversations {
    NSMutableArray *models = [[NSMutableArray alloc] init];
    [FMDBBaseShare queryAllDatasWithTable:kConversationTableName db_result:^(FMResultSet * _Nonnull result) {
        IMConversationModel *model = [[IMConversationModel alloc] init];
        IMChatModel *lastChatModel = [IMChatModel mj_objectWithKeyValues:[result stringForColumn:IMConversationModel.db_onversation_last]];
        model.conversation_id = [result stringForColumn:IMConversationModel.db_conversation_id];
        model.conversation_unReadCount = [result stringForColumn:IMConversationModel.db_conversation_unReadCount];
        model.conversation_last = lastChatModel;
        [models addObject:model];
    }];
    return models;
}

#pragma mark - group
- (void)createGroupTable {
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)", kGroupTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_unReadCount, IMGroupModel.db_group_users, IMGroupModel.db_group_chat_last];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)createGroupChatTable {
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT,)", kGroupChatTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_chats];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)insertGroupModel:(IMGroupModel *)model {
    NSString *jsonStr = [model.group_chat_last mj_JSONString];
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@) values('%@','%@','%@', %@)", kGroupTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_unReadCount, IMGroupModel.db_group_users, IMGroupModel.db_group_chat_last, model.group_id, model.group_unReadCount, model.group_users, jsonStr];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (void)deleteGroup:(NSString *)groupId {
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kGroupTableName, IMGroupModel.db_group_id, groupId];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (void)insertGroupChatModel:(IMChatModel *)model ToGroup:(NSString *)groupId {
    [FMDBBaseShare queryDatasWithTable:kGroupChatTableName db_key:IMGroupModel.db_group_id db_value:groupId db_result:^(FMResultSet * _Nonnull result) {
        // 取出chats, 添加model, 保存
        NSMutableArray <IMChatModel *>*chats = [IMChatModel mj_objectArrayWithKeyValuesArray:[result stringForColumn:IMGroupModel.db_group_chats]];
        [chats addObject:model];
        NSString *jsonStr = [model mj_JSONString];
        NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@) values('%@','%@')", kGroupChatTableName, IMGroupModel.db_group_id,IMGroupModel.db_group_chats, groupId, jsonStr];
        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
    }];
}

- (void)deleteGroupChat:(NSString *)chatId fromGroup:(NSString *)groupId {
    [FMDBBaseShare queryDatasWithTable:kGroupTableName db_key:IMGroupModel.db_group_id db_value:groupId db_result:^(FMResultSet * _Nonnull result) {
        // 取出group_chats, 删除 model, 修改FMDB
        NSString *group_chats_str = [result stringForColumn:IMGroupModel.db_group_chats];
        NSMutableArray <IMChatModel *>*group_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:group_chats_str];
        [group_chats enumerateObjectsUsingBlock:^(IMChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.chat_id isEqualToString:chatId]) {
                [group_chats removeObject:obj];
            }
        }];
        NSString *new_group_chats_str = [group_chats mj_JSONString];
        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kGroupTableName, IMGroupModel.db_group_chats, new_group_chats_str, IMGroupModel.db_group_id, groupId];
        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
    }];
}

- (NSArray<IMGroupModel *> *)getAllGroups {
    NSMutableArray *models = [[NSMutableArray alloc] init];
    [FMDBBaseShare queryAllDatasWithTable:kGroupTableName db_result:^(FMResultSet * _Nonnull result) {
        IMGroupModel *model = [[IMGroupModel alloc] init];
        NSArray <IMUserModel *>* users = [IMUserModel mj_objectArrayWithKeyValuesArray:[result stringForColumn:IMGroupModel.db_group_users]];
        IMChatModel *chatModel = [IMChatModel mj_objectWithKeyValues:[result stringForColumn:IMGroupModel.db_group_chat_last]];
        model.group_id = [result stringForColumn:IMGroupModel.db_group_id];
        model.group_users = users;
        model.group_unReadCount = [result stringForColumn:IMGroupModel.db_group_unReadCount];
        model.group_chat_last = chatModel;
        [models addObject:model];
    }];
    return models;
}


#pragma mark - P2PChat
- (void)createP2PChatTable {
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kP2PChatTableName, IMP2PModel.db_p2p_id, IMP2PModel.db_p2p_unReadCount, IMP2PModel.db_p2p_chats];
    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
}

- (void)insertP2PModel:(IMP2PModel *)model {
    NSString *jsonStr = [model.p2p_chats mj_JSONString];
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@) values('%@','%@','%@')", kP2PChatTableName, IMP2PModel.db_p2p_id, IMP2PModel.db_p2p_unReadCount, IMP2PModel.db_p2p_chats, model.p2p_id, model.p2p_unReadCount, jsonStr];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (void)deleteP2P:(NSString *)P2PId {
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_id, P2PId];
    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
}

- (void)insertP2PChatModel:(IMChatModel *)model ToP2P:(NSString *)P2PId{
    [FMDBBaseShare queryDatasWithTable:kP2PChatTableName db_key:IMP2PModel.db_p2p_id db_value:P2PId db_result:^(FMResultSet * _Nonnull result) {
        // 取出chats, 添加model, 修改FMDB
        NSString *p2p_chats_str = [result stringForColumn:IMP2PModel.db_p2p_chats];
        NSMutableArray <IMChatModel *>*p2p_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:p2p_chats_str];
        [p2p_chats addObject:model];
        NSString *jsonStr = [p2p_chats mj_JSONString];
        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_chats, jsonStr, IMP2PModel.db_p2p_id, P2PId];
        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
    }];
}

- (void)deleteP2PChat:(NSString *)chatId fromP2P:(NSString *)P2PId {
    [FMDBBaseShare queryDatasWithTable:kP2PChatTableName db_key:IMP2PModel.db_p2p_id db_value:P2PId db_result:^(FMResultSet * _Nonnull result) {
        // 取出p2p_chats, 删除 model, 修改FMDB
        NSString *p2p_chats_str = [result stringForColumn:IMP2PModel.db_p2p_chats];
        NSMutableArray <IMChatModel *>*p2p_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:p2p_chats_str];
        [p2p_chats enumerateObjectsUsingBlock:^(IMChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.chat_id isEqualToString:chatId]) {
                [p2p_chats removeObject:obj];
            }
        }];
        NSString *new_p2p_chats_str = [p2p_chats mj_JSONString];
        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_chats, new_p2p_chats_str, IMP2PModel.db_p2p_id, P2PId];
        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
    }];
}

@end
