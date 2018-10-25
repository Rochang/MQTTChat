//
//  IMFMDBManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/11.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMFMDBManager.h"
#import "FMDBBase.h"
#import "IMUserModel.h"
#import "IMNotificationModel.h"
#import "IMChatModel.h"
#import "IMConversationModel.h"

static const NSString *DBTIME = @"dbTime";

@implementation IMFMDBManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static IMFMDBManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)resetAllTable {
    if (self.fmdbPath.length) {
        [[NSFileManager defaultManager] removeItemAtPath:self.fmdbPath error:nil];
        [self createTableIfNotExists];
    }
}

- (void)createTableIfNotExists {
    // 好友表
    if (![self isTableExistWithTableName:kFirendTableName]) {
        NSString *formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",kFirendTableName, DBTIME, IMUserModel.dbKey_Imid, IMUserModel.dbKey_name, IMUserModel.dbKey_nick, IMUserModel.dbKey_avator];
        [self creatTable:kFirendTableName sqlstr:formatStr];
    }
    // 通知表
    if (![self isTableExistWithTableName:kNotificationTableName]) {
        NSString *formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT)", kNotificationTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_groupId, IMModel.dbkey_touserId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMModel.dbkey_isDispose, IMNotificationModel.dbkey_type, IMNotificationModel.dbkey_message];
        [self creatTable:kNotificationTableName sqlstr:formatStr];
    }
    // 信息表
    if (![self isTableExistWithTableName:kSessionTableName]) {
        NSString *formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", kSessionTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_touserId, IMModel.dbkey_groupId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMChatModel.dbkey_type, IMChatModel.dbkey_message_id];
        [self creatTable:kSessionTableName sqlstr:formatStr];
    }
    // 会话表
    if (![self isTableExistWithTableName:kConversationTableName]) {
        NSString *formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, DBTIME, IMConversationModel.dbkey_sessionType, IMConversationModel.dbkey_unReadCount, IMConversationModel.dbkey_sessionId, IMConversationModel.dbkey_messageIds, IMConversationModel.dbkey_lastSession];
        [self creatTable:kConversationTableName sqlstr:formatStr];
    }
}

- (void)addFirend:(IMUserModel *)firend {
    // 判断是否已存在
    [self dataIsExistsInTable:kFirendTableName key:IMUserModel.dbKey_Imid value:firend.Id completed:^(BOOL flag) {
        if (!flag) {
            NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@, %@) values('%@','%@','%@','%@','%@')", kFirendTableName, DBTIME, IMUserModel.dbKey_Imid, IMUserModel.dbKey_name, IMUserModel.dbKey_nick, IMUserModel.dbKey_avator, [NSString timestamp], firend.Id, firend.name, firend.nick, firend.avator];
            [self executeUpdateSqlStr:sqlStr];
        }
    }];
}

- (void)addFirends:(NSArray<IMUserModel *> *)firends {
    for (IMUserModel *model in firends) {
        [self addFirend:model];
    }
}

- (NSMutableArray *)getFirendList {
    __block NSMutableArray *models = [NSMutableArray array];
    [self queryAllDatasWithTable:kFirendTableName db_result:^(FMResultSet * _Nonnull result) {
        IMUserModel *model = [IMUserModel modelWithFMResultSet:result];
        [models addObject:model];
    }];
    return models;
}

- (IMUserModel *)FirendWithId:(NSString *)firendId {
    __block IMUserModel *model = [[IMUserModel alloc] init];
    [self queryDatasWithTable:kFirendTableName db_key:IMUserModel.dbKey_Imid db_value:firendId db_result:^(FMResultSet * _Nonnull result) {
        model = [IMUserModel modelWithFMResultSet:result];
    }];
    return model;
}

- (void)removeFirendWithId:(NSString *)firendId {
    [self deleteDatasWithTable:kFirendTableName Key:IMUserModel.dbKey_Imid value:firendId];
}

- (void)addNotification:(IMModel *)model {
    IMNotificationModel *notiModel = model.notification;
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@, %@, %@, %@, %@, %@) values('%@','%@','%@','%@','%@','%@','%d','%ld','%@')", kNotificationTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_groupId, IMModel.dbkey_touserId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMNotificationModel.dbkey_type, IMNotificationModel.dbkey_message, [NSString timestamp], model.time, model.from_user, model.group, model.to_user, [model modelToJSONString], model.isRead, (long)notiModel.type, notiModel.message];
    [self executeUpdateSqlStr:sqlStr];
}

- (void)addNotifications:(NSArray<IMModel *> *)models {
    for (IMModel *model in models) {
        [self addNotification:model];
    }
}

- (void)makeNotificationRead:(IMModel *)model {
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = 1 where %@ = %@;", kNotificationTableName, IMModel.dbkey_isRead, IMModel.dbkey_time, model.time];
    [self executeUpdateSqlStr:sql];
}

//#pragma mark - conversation
//- (void)createConversationTable {
//     NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_onversation_last];
//    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
//}
//
//- (void)insertConversationModel:(IMConversationModel *)model {
//    NSString *jsonStr = [model.conversation_last mj_JSONString];
//    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@) values('%@','%@','%@')", kConversationTableName, IMConversationModel.db_conversation_id, IMConversationModel.db_conversation_unReadCount, IMConversationModel.db_onversation_last, model.conversation_id, model.conversation_unReadCount, jsonStr];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (void)deleteConversation:(NSString *)conversationId {
//    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kConversationTableName, IMConversationModel.db_conversation_id ,conversationId];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (NSMutableArray<IMConversationModel *> *)getAllConversations {
//    NSMutableArray *models = [[NSMutableArray alloc] init];
//    [FMDBBaseShare queryAllDatasWithTable:kConversationTableName db_result:^(FMResultSet * _Nonnull result) {
//        IMConversationModel *model = [[IMConversationModel alloc] init];
//        IMChatModel *lastChatModel = [IMChatModel mj_objectWithKeyValues:[result stringForColumn:IMConversationModel.db_onversation_last]];
//        model.conversation_id = [result stringForColumn:IMConversationModel.db_conversation_id];
//        model.conversation_unReadCount = [result stringForColumn:IMConversationModel.db_conversation_unReadCount];
//        model.conversation_last = lastChatModel;
//        [models addObject:model];
//    }];
//    return models;
//}
//
//#pragma mark - group
//- (void)createGroupTable {
//    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)", kGroupTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_unReadCount, IMGroupModel.db_group_users, IMGroupModel.db_group_chat_last];
//    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
//}
//
//- (void)createGroupChatTable {
//    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT,)", kGroupChatTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_chats];
//    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
//}
//
//- (void)insertGroupModel:(IMGroupModel *)model {
//    NSString *jsonStr = [model.group_chat_last mj_JSONString];
//    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@) values('%@','%@','%@', %@)", kGroupTableName, IMGroupModel.db_group_id, IMGroupModel.db_group_unReadCount, IMGroupModel.db_group_users, IMGroupModel.db_group_chat_last, model.group_id, model.group_unReadCount, model.group_users, jsonStr];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (void)deleteGroup:(NSString *)groupId {
//    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kGroupTableName, IMGroupModel.db_group_id, groupId];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (void)insertGroupChatModel:(IMChatModel *)model ToGroup:(NSString *)groupId {
//    [FMDBBaseShare queryDatasWithTable:kGroupChatTableName db_key:IMGroupModel.db_group_id db_value:groupId db_result:^(FMResultSet * _Nonnull result) {
//        // 取出chats, 添加model, 保存
//        NSMutableArray <IMChatModel *>*chats = [IMChatModel mj_objectArrayWithKeyValuesArray:[result stringForColumn:IMGroupModel.db_group_chats]];
//        [chats addObject:model];
//        NSString *jsonStr = [model mj_JSONString];
//        NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@) values('%@','%@')", kGroupChatTableName, IMGroupModel.db_group_id,IMGroupModel.db_group_chats, groupId, jsonStr];
//        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//    }];
//}
//
//- (void)deleteGroupChat:(NSString *)chatId fromGroup:(NSString *)groupId {
//    [FMDBBaseShare queryDatasWithTable:kGroupTableName db_key:IMGroupModel.db_group_id db_value:groupId db_result:^(FMResultSet * _Nonnull result) {
//        // 取出group_chats, 删除 model, 修改FMDB
//        NSString *group_chats_str = [result stringForColumn:IMGroupModel.db_group_chats];
//        NSMutableArray <IMChatModel *>*group_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:group_chats_str];
//        [group_chats enumerateObjectsUsingBlock:^(IMChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj.chat_id isEqualToString:chatId]) {
//                [group_chats removeObject:obj];
//            }
//        }];
//        NSString *new_group_chats_str = [group_chats mj_JSONString];
//        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kGroupTableName, IMGroupModel.db_group_chats, new_group_chats_str, IMGroupModel.db_group_id, groupId];
//        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//    }];
//}
//
//- (NSArray<IMGroupModel *> *)getAllGroups {
//    NSMutableArray *models = [[NSMutableArray alloc] init];
//    [FMDBBaseShare queryAllDatasWithTable:kGroupTableName db_result:^(FMResultSet * _Nonnull result) {
//        IMGroupModel *model = [[IMGroupModel alloc] init];
//        NSArray <IMUserModel *>* users = [IMUserModel mj_objectArrayWithKeyValuesArray:[result stringForColumn:IMGroupModel.db_group_users]];
//        IMChatModel *chatModel = [IMChatModel mj_objectWithKeyValues:[result stringForColumn:IMGroupModel.db_group_chat_last]];
//        model.group_id = [result stringForColumn:IMGroupModel.db_group_id];
//        model.group_users = users;
//        model.group_unReadCount = [result stringForColumn:IMGroupModel.db_group_unReadCount];
//        model.group_chat_last = chatModel;
//        [models addObject:model];
//    }];
//    return models;
//}
//
//
//#pragma mark - P2PChat
//- (void)createP2PChatTable {
//    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kP2PChatTableName, IMP2PModel.db_p2p_id, IMP2PModel.db_p2p_unReadCount, IMP2PModel.db_p2p_chats];
//    [FMDBBaseShare creatTable:kConversationTableName sqlstr:sqlStr];
//}
//
//- (void)insertP2PModel:(IMP2PModel *)model {
//    NSString *jsonStr = [model.p2p_chats mj_JSONString];
//    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@) values('%@','%@','%@')", kP2PChatTableName, IMP2PModel.db_p2p_id, IMP2PModel.db_p2p_unReadCount, IMP2PModel.db_p2p_chats, model.p2p_id, model.p2p_unReadCount, jsonStr];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (void)deleteP2P:(NSString *)P2PId {
//    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_id, P2PId];
//    [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//}
//
//- (void)insertP2PChatModel:(IMChatModel *)model ToP2P:(NSString *)P2PId{
//    [FMDBBaseShare queryDatasWithTable:kP2PChatTableName db_key:IMP2PModel.db_p2p_id db_value:P2PId db_result:^(FMResultSet * _Nonnull result) {
//        // 取出chats, 添加model, 修改FMDB
//        NSString *p2p_chats_str = [result stringForColumn:IMP2PModel.db_p2p_chats];
//        NSMutableArray <IMChatModel *>*p2p_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:p2p_chats_str];
//        [p2p_chats addObject:model];
//        NSString *jsonStr = [p2p_chats mj_JSONString];
//        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_chats, jsonStr, IMP2PModel.db_p2p_id, P2PId];
//        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//    }];
//}
//
//- (void)deleteP2PChat:(NSString *)chatId fromP2P:(NSString *)P2PId {
//    [FMDBBaseShare queryDatasWithTable:kP2PChatTableName db_key:IMP2PModel.db_p2p_id db_value:P2PId db_result:^(FMResultSet * _Nonnull result) {
//        // 取出p2p_chats, 删除 model, 修改FMDB
//        NSString *p2p_chats_str = [result stringForColumn:IMP2PModel.db_p2p_chats];
//        NSMutableArray <IMChatModel *>*p2p_chats = [IMChatModel mj_objectArrayWithKeyValuesArray:p2p_chats_str];
//        [p2p_chats enumerateObjectsUsingBlock:^(IMChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj.chat_id isEqualToString:chatId]) {
//                [p2p_chats removeObject:obj];
//            }
//        }];
//        NSString *new_p2p_chats_str = [p2p_chats mj_JSONString];
//        NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", kP2PChatTableName, IMP2PModel.db_p2p_chats, new_p2p_chats_str, IMP2PModel.db_p2p_id, P2PId];
//        [FMDBBaseShare FMDBBaseExecuteUpdateSqlStr:sqlStr];
//    }];
//}

@end
