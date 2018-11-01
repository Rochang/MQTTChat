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

@implementation IMFMDBManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static IMFMDBManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//- (void)createFirendTable {
//    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",kFirendTableName, DBTIME, IMUserModel.db_Id, IMUserModel.db_name, IMUserModel.db_nick, IMUserModel.db_avator, IMUserModel.db_is_online];
//    [self creatTable:kFirendTableName sqlstr:sql];
//}
//
//- (void)createGroupTable {
//    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kGroupTableName, DBTIME, IMGroupModel.db_Id, IMGroupModel.db_name];
//    [self creatTable:kGroupTableName sqlstr:sql];
//}
//
//- (void)createNotificationTable {
//    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT)", kNotificationTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_groupId, IMModel.dbkey_touserId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMModel.dbkey_isDispose, IMNotificationModel.dbkey_type, IMNotificationModel.dbkey_message];
//    [self creatTable:kNotificationTableName sqlstr:sql];
//}
//
//- (void)createSessionTable {
//    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", kSessionTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_touserId, IMModel.dbkey_groupId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMChatModel.dbkey_type, IMChatModel.dbkey_message_id];
//    [self creatTable:kSessionTableName sqlstr:sql];
//}
//
//- (void)createConversationTable {
//    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, DBTIME, IMConversationModel.dbkey_sessionType, IMConversationModel.dbkey_unReadCount, IMConversationModel.dbkey_sessionId, IMConversationModel.dbkey_messageIds, IMConversationModel.dbkey_lastSession];
//    [self creatTable:kConversationTableName sqlstr:sql];
//}

- (void)createTableIfNotExists {
    // 好友表
    if (![self isTableExistWithTableName:kFirendTableName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",kFirendTableName, DBTIME, IMUserModel.db_Id, IMUserModel.db_name, IMUserModel.db_nick, IMUserModel.db_avator, IMUserModel.db_is_online];
        [self creatTable:kFirendTableName sqlstr:sql];
    }
    // 通知表
    if (![self isTableExistWithTableName:kNotificationTableName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT)", kNotificationTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_groupId, IMModel.dbkey_touserId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMModel.dbkey_isDispose, IMNotificationModel.dbkey_type, IMNotificationModel.dbkey_message];
        [self creatTable:kNotificationTableName sqlstr:sql];
    }
    // 聊天信息表
    if (![self isTableExistWithTableName:kSessionTableName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", kSessionTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_touserId, IMModel.dbkey_groupId, IMModel.dbkey_info, IMModel.dbkey_isRead, IMChatModel.dbkey_type, IMChatModel.dbkey_message_id];
        [self creatTable:kSessionTableName sqlstr:sql];
    }
    // 会话表
    if (![self isTableExistWithTableName:kConversationTableName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT)", kConversationTableName, DBTIME, IMConversationModel.dbkey_sessionType, IMConversationModel.dbkey_unReadCount, IMConversationModel.dbkey_sessionId, IMConversationModel.dbkey_messageIds, IMConversationModel.dbkey_lastSession];
        [self creatTable:kConversationTableName sqlstr:sql];
    }
    // 群表
    if (![self isTableExistWithTableName:kGroupTableName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT)", kGroupTableName, DBTIME, IMGroupModel.db_Id, IMGroupModel.db_name];
        [self creatTable:kGroupTableName sqlstr:sql];
    }
}

- (void)insertFirend:(IMUserModel *)firend {
    // 判断数据是否已存在
    [self isDataExistsInTable:kFirendTableName key:IMUserModel.db_Id value:firend.Id completed:^(BOOL flag, FMResultSet * _Nonnull result) {
        if (!flag) {
            NSString *sql = [NSString stringWithFormat:@"insert into %@", kFirendTableName];
            NSString *dbkeys = [@"(" addStr:DBTIME];
            NSString *dbvalues = [NSString stringWithFormat:@" values ('%@'", [NSString timestamp]];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMUserModel.db_Id value:firend.Id];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMUserModel.db_name value:firend.name];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMUserModel.db_nick value:firend.nick];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMUserModel.db_avator value:firend.avator];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMUserModel.db_is_online value:@(firend.is_online)];
            sql = [sql addStrs:@[dbkeys, @")", dbvalues, @")"]];
            [self executeUpdateSqlStr:sql];
        }
    }];
}

- (NSMutableArray *)queryFirendList {
    __block NSMutableArray *models = [NSMutableArray array];
    [self queryAllDatasWithTable:kFirendTableName db_result:^(FMResultSet * _Nonnull result) {
        IMUserModel *model = [IMUserModel modelWithFMResultSet:result];
        [models addObject:model];
    }];
    return models;
}

- (IMUserModel *)FirendWithId:(NSString *)firendId {
    __block IMUserModel *model = [[IMUserModel alloc] init];
    [self queryDatasWithTable:kFirendTableName db_key:IMUserModel.db_Id db_value:firendId db_result:^(FMResultSet * _Nonnull result) {
        model = [IMUserModel modelWithFMResultSet:result];
    }];
    return model;
}

- (void)removeFirendWithId:(NSString *)firendId {
    [self deleteDatasWithTable:kFirendTableName Key:IMUserModel.db_Id value:firendId];
}

- (void)insertFirends:(NSArray<IMUserModel *> *)firends {
    for (IMUserModel *model in firends) {
        [self insertFirend:model];
    }
}

- (void)insertGroup:(IMGroupModel *)group {
    // 判断数据是否已存在
    [self isDataExistsInTable:kGroupTableName key:IMGroupModel.db_Id value:group.Id completed:^(BOOL flag, FMResultSet * _Nonnull result) {
        if (!flag) {
            NSString *sql = [NSString stringWithFormat:@"insert into %@", kGroupTableName];
            NSString *dbkeys = [@"(" addStr:DBTIME];
            NSString *dbvalues = [NSString stringWithFormat:@" values ('%@'", [NSString timestamp]];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMGroupModel.db_Id value:group.Id];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMGroupModel.db_name value:group.name];
            sql = [sql addStrs:@[dbkeys, @")", dbvalues, @")"]];
            [self executeUpdateSqlStr:sql];
        }
    }];
}

- (void)insertGroups:(NSArray<IMGroupModel *> *)groups {
    for (IMGroupModel *group in groups) {
        [self insertGroup:group];
    }
}

- (NSArray<IMGroupModel *> *)queryGroupList {
    NSMutableArray *groups = [NSMutableArray array];
    [self queryAllDatasWithTable:kGroupTableName db_result:^(FMResultSet * _Nonnull result) {
        IMGroupModel *group = [IMGroupModel modelWithFMResultSet:result];
        [groups addObject:group];
    }];
    return groups;
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

- (NSMutableArray *)getNotificationList {
    __block NSMutableArray *notis = [NSMutableArray array];
    [self queryAllDatasWithTable:kNotificationTableName db_result:^(FMResultSet * _Nonnull result) {
        IMModel *model = [IMModel modelWithJSON:[result stringForColumn:IMModel.dbkey_info]];
        model.isRead = [result intForColumn:IMModel.dbkey_isRead];
        model.isDispose = [result intForColumn:IMModel.dbkey_isDispose];
        [notis addObject:model];
    }];
    return notis;
}

#pragma mark - 会话
- (void)insertChatConversation:(IMModel *)model chatComplete:(completeModelBlock)chatComplete conversationComplete:(completeModelBlock)comComplete {
    // 判断数据是否已存在
    [self isDataExistsInTable:kSessionTableName key:IMChatModel.dbkey_message_id value:model.chat.message_id completed:^(BOOL flag, FMResultSet * _Nonnull result) {
        if (!flag) {
            NSString *sql = [NSString stringWithFormat:@"insert into %@", kSessionTableName];
            NSString *dbkeys = [@"(" addStr:DBTIME];
            NSString *dbvalues = [NSString stringWithFormat:@" values ('%@'", [NSString timestamp]];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMModel.dbkey_time value:model.time];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMModel.dbkey_fromUserId value:model.from_user.Id];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMModel.dbkey_touserId value:model.to_user.Id];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMModel.dbkey_groupId value:model.group.Id];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMModel.dbkey_info value:model.modelToJSONString];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMChatModel.dbkey_type value:@(model.chat.type)];
            [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMChatModel.dbkey_message_id value:model.chat.message_id];
            sql = [sql addStrs:@[dbkeys, @")", dbvalues, @")"]];
            BOOL success = [self executeUpdateSqlStr:sql];
            if (success) {
                // 更新会话
                if (chatComplete) chatComplete(success, model);
                [self updateConversation:model complete:comComplete];
            }
        }
    }];
}

- (void)updateConversation:(IMModel *)model complete:(completeModelBlock)complete {
    IMConversationModel *comModel = [IMConversationModel modelWithIMModel:model];
    [self isDataExistsInTable:kConversationTableName key:IMConversationModel.dbkey_sessionId value:model.sessionId completed:^(BOOL flag, FMResultSet * _Nonnull result) {
        if (flag) { // 更新会话
            IMConversationModel *sqlmodel = [IMConversationModel modelWithResultSet:result];
            sqlmodel.unReadCount = sqlmodel.unReadCount + comModel.unReadCount;
            [sqlmodel db_updateModel:model unReadCount:sqlmodel.unReadCount];
            
            // 更新
            NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = %@", kConversationTableName, DBTIME, [NSString timestamp]];
            [self jointSql:&sql key:IMConversationModel.dbkey_sessionType value:@(sqlmodel.type)];
            [self jointSql:&sql key:IMConversationModel.dbkey_messageIds value:sqlmodel.messageIds];
            [self jointSql:&sql key:IMConversationModel.dbkey_unReadCount value:@(sqlmodel.unReadCount)];
            [self jointSql:&sql key:IMConversationModel.dbkey_lastSession value:sqlmodel.lastSession.modelToJSONString];
            [sql addStr:[NSString stringWithFormat:@" where %@ = '%@'", IMConversationModel.dbkey_sessionId, model.sessionId]];
            [self executeUpdateSqlStr:sql];
        } else { // 插入会话
            [self isDataExistsInTable:kConversationTableName key:IMConversationModel.dbkey_sessionId value:model.chat.message_id completed:^(BOOL flag, FMResultSet * _Nonnull result) {
                if (!flag) {
                    NSString *sql = [NSString stringWithFormat:@"insert into %@", kConversationTableName];
                    NSString *dbkeys = [@"(" addStr:DBTIME];
                    NSString *dbvalues = [NSString stringWithFormat:@" values ('%@'", [NSString timestamp]];
                    [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMConversationModel.dbkey_sessionType value:@(comModel.type)];
                    [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMConversationModel.dbkey_unReadCount value:@(comModel.unReadCount)];
                    [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMConversationModel.dbkey_sessionId value:comModel.sessionId];
                    [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMConversationModel.dbkey_messageIds value:comModel.messageIds];
                    [self jointParamsdbKeys:&dbkeys dbValues:&dbvalues key:IMConversationModel.dbkey_lastSession value:comModel.lastSession.modelToJSONString];
                    sql = [sql addStrs:@[dbkeys, @")", dbvalues, @")"]];
                    BOOL success = [self executeUpdateSqlStr:sql];
                    if (success && complete) {
                        complete(success, model);
                    }
                }
            }];
        }
    }];
}

- (NSArray<IMConversationModel *> *)queryAllConversation {
    NSMutableArray *models = [NSMutableArray array];
    [self queryAllDatasWithTable:kConversationTableName db_result:^(FMResultSet * _Nonnull result) {
        IMConversationModel *model = [IMConversationModel modelWithResultSet:result];
        [models addObject:model];
    }];
    return models;
}

- (void)resetConversationUnReadCount:(IMConversationModel *)model complete:(completeBlock)complete {
    NSString *sql1 = [NSString stringWithFormat:@"update %@ set %@ = 1 where %@ = %d;", kSessionTableName,
                     IMModel.dbkey_isRead, IMModel.dbkey_isRead, 0];
    NSString *sql2 = [NSString stringWithFormat:@"update %@ set %@ = 0 where %@ = %@;", kConversationTableName,
                     IMConversationModel.dbkey_unReadCount, IMConversationModel.dbkey_sessionId, model.sessionId];
    BOOL success = [self executeUpdateSqlStr:sql1] && [self executeUpdateSqlStr:sql2];
    if (complete) complete(success);
}

- (void)jointParamsdbKeys:(NSString **)dbKeys dbValues:(NSString **)dbValues key:(NSString *)key value:(id)value {
    *dbKeys = [*dbKeys stringByAppendingString:[NSString stringWithFormat:@",%@", key]];
    *dbValues = [*dbValues stringByAppendingString:[NSString stringWithFormat:@",'%@'", value]];
}

- (void)jointSql:(NSString **)sql key:(NSString *)key value:(id)value {
    *sql = [*sql stringByAppendingString:[NSString stringWithFormat:@",%@='%@'", key, value]];
}


@end
