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
    // 聊天信息表
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
- (void)addChatConversation:(IMModel *)model {
    // 聊天信息存库
    IMChatModel *chatModel = model.chat;
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@, %@, %@, %@, %@) values('%@','%@','%@','%@','%@','%@','%ld','%@')", kSessionTableName, DBTIME, IMModel.dbkey_time, IMModel.dbkey_fromUserId, IMModel.dbkey_touserId, IMModel.dbkey_groupId, IMModel.dbkey_info, IMChatModel.dbkey_type, IMChatModel.dbkey_message_id, [NSString timestamp], model.time, model.from_user.Id, model.to_user.Id, model.group.Id, model.modelToJSONString, chatModel.type, chatModel.message_id];
    [self executeUpdateSqlStr:sqlStr];
    // 更新会话
    
}

- (void)updateConversation:(IMModel *)model {
    [self dataIsExistsInTable:kConversationTableName key:IMConversationModel.dbkey_sessionId value:<#(nonnull NSString *)#> completed:<#^(BOOL flag)completed#>]
}


@end
