//
//  ChatDBTool.m
//  SIMIMSDK_Example
//
//  Created by 罗函 on 2017/10/13.
//  Copyright © 2017年 LuohanCC. All rights reserved.
//

#import "ChatDBTool.h"
#include <stdio.h>
#include <string.h>

static const NSString *tag    = @"ChatDBTool";
static const NSString *DBTIME = @"dbTime";

@interface ChatDBTool()
@property (nonatomic, strong) NSString *userTableName;
@property (nonatomic, strong) NSString *notiTableName;
@property (nonatomic, strong) NSString *sessionTableName;
@property (nonatomic, strong) NSString *conversationTableName;
@end

@implementation ChatDBTool

+ (instancetype)shared
{
    static ChatDBTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ChatDBTool alloc] init];
        instance.userTableName         = @"t_Users";
        instance.notiTableName         = @"t_Notification";
        instance.sessionTableName      = @"t_Session";
        instance.conversationTableName = @"t_Conversation";
    });
    return instance;
}

- (void)resetAllTable {
    NSString *boxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    boxPath = [boxPath stringByAppendingPathComponent:@"imData"];
    [[NSFileManager defaultManager] removeItemAtPath:boxPath error:nil];
    [super reset];
    if(SIMIMSDK_SHARE.currentUserId) {
        [self createTableIfNotExists];
    }
}

// 数据库初始化检查
- (void)createTableIfNotExists {
    BOOL res = NO;
    NSString *formatStr = nil;
    NSString *tbName = nil;
    // 用户表
    tbName = _userTableName;
    res = [super isTableOK:tbName];
    if(! res) {
         formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, \
                      %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",tbName,
                      DBTIME, SIMUsersModel.dbKey_Imid, SIMUsersModel.dbKey_name, SIMUsersModel.dbKey_nick, SIMUsersModel.dbKey_avator];
        [super createTable:tbName formatStr:formatStr];
    }
    // 通知表
    tbName = _notiTableName;
    res = [super isTableOK:tbName];
    if(! res) {
        formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, \
                     %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT)", tbName,
                     DBTIME, SIMModel.dbkey_time, SIMModel.dbkey_fromUserId,  SIMModel.dbkey_groupId, SIMModel.dbkey_touserId, SIMModel.dbkey_info, SIMModel.dbkey_isRead, SIMModel.dbkey_isDispose,
                     SIMNotificationModel.dbkey_type, SIMNotificationModel.dbkey_message
                     ];
        [super createTable:tbName formatStr:formatStr];
    }
    // 信息表
    tbName = _sessionTableName;
    res = [super isTableOK:tbName];
    if(! res) {
        formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, \
                     %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", tbName,
                     DBTIME, SIMModel.dbkey_time, SIMModel.dbkey_fromUserId, SIMModel.dbkey_touserId, SIMModel.dbkey_groupId, SIMModel.dbkey_info, SIMModel.dbkey_isRead, SIMChat.dbkey_type, SIMChat.dbkey_message_id];
        [super createTable:tbName formatStr:formatStr];
    }
    // 会话表
    tbName = _conversationTableName;
    res = [super isTableOK:tbName];
    if(! res) {
        formatStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, \
                     %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT)", tbName,
                     DBTIME, SIMConversation.dbkey_sessionType, SIMConversation.dbkey_unReadCount, SIMConversation.dbkey_sessionId, SIMConversation.dbkey_messageIds, SIMConversation.dbkey_lastSession];
        [super createTable:tbName formatStr:formatStr];
    }
}


#pragma mark - 用户表操作
/**
 插入一组用户数据

 @param users 用户数组
 @param block 操作完成的回调
 */
- (void)insetUsers:(NSArray <SIMUsersModel *>*)users db_block:(DBBlock)block {
    if(! users || users.count == 0) return;
    __block NSUInteger insetCount = 0;
    for (SIMUsersModel *user in users) {
        [self insetUser:user db_block:^(BOOL isCompleted) {
            if(isCompleted) insetCount++;
        }];
    }
    if(block) block(YES);
    NSString *log = [NSString stringWithFormat:@"inset %ld in %@", insetCount, _userTableName];
    ChatLog(tag, log);
}



/**
 插入一个用户

 @param user 用户
 */
- (void)insetUser:(SIMUsersModel *)user db_block:(DBBlock)block {
    if(!self.fmdb.open) return;
    __block NSString *log = nil;
    NSString *tableName = self.userTableName;
    NSInteger dbTime = [ChatFMDBBase nowTimeStamp];
    [self dataIsExistsInTable:tableName primaryKey:SIMUsersModel.dbKey_Imid primaryValue:user.id db_option:^(BOOL isExists) {
        if(isExists) {
//            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@='%@', %@='%@', %@='%@', %@='%@' WHERE %@='%@'",tableName,
//                              dbkey_time, dbTimeStr,
//                             SIMUsersModel.dbKey_name, user.name,
//                             SIMUsersModel.dbKey_nick, user.nick,
//                             SIMUsersModel.dbKey_avator, user.avator,
//                             SIMUsersModel.dbKey_Imid, user.id ];
//            BOOL res = [self.fmdb executeUpdate:sql];
//            log = [NSString stringWithFormat:@"%@ update result:%@", tableName ,@(res)];
//            if(block) block(res);
        }else{
            NSString *sql    = [NSString stringWithFormat:@"insert into %@ ", tableName];
            NSString *dbKeys = [NSString stringWithFormat:@"(%@", DBTIME];
            NSString *dbValues = [NSString stringWithFormat:@" values  (%ld", (long)dbTime];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMUsersModel.dbKey_Imid value:user.id];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMUsersModel.dbKey_name value:user.name];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMUsersModel.dbKey_nick value:user.nick];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMUsersModel.dbKey_avator value:user.avator];
            dbKeys = [dbKeys stringByAppendingString:@")"];
            dbValues = [dbValues stringByAppendingString:@")"];
            
            NSString *header = [NSString stringWithFormat:@"%@%@%@;", sql, dbKeys, dbValues];
            BOOL res = [self.fmdb executeUpdate:header];
            /*
            NSString *sql    = [NSString stringWithFormat:@"insert into %@ ", tableName];
            NSString *dbkeys = [NSString stringWithFormat:@"(%@, %@, %@, %@, %@)",
                                dbkey_time, SIMUsersModel.dbKey_Imid, SIMUsersModel.dbKey_name, SIMUsersModel.dbKey_nick, SIMUsersModel.dbKey_avator];
            NSString *header = [sql stringByAppendingString:dbkeys];
            header = [header stringByAppendingString:@" values (%@,%@,%@,%@,%@);"];
            BOOL res = [self.fmdb executeUpdateWithFormat:header,
                        dbTimeStr, user.id, user.name, user.nick, user.avator];
             */
            log = [NSString stringWithFormat:@"%@ inset result:%@", tableName ,@(res)];
            if(block) block(res);
        }
    }];
    ChatLog(tag, log);
    [self.fmdb close];
}

/**
 查询用户列表

 @param result 返回结果
 */
- (void)quertUsersList:(void(^)(NSArray *))result {
    __block NSMutableArray *users = [NSMutableArray new];
    [super queryDataByTableName:_userTableName db_result:^(FMResultSet *obj) {
        SIMUsersModel *user = [SIMUsersModel createUserModelWithFMResultSet:obj];
        [users addObject:user];
    } db_complete:^{
        if(result) result(users);
    }];
}



/**
 根据属性查找用户

 @param tableName 表名
 @param primaryKey primaryKey
 @param primaryValue primaryValue
 @param result SIMUsersModel
 */
- (void)userIsExists:(NSString *)tableName primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue db_result:(DBResult)result {
    if(!self.fmdb.open) return;
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';",tableName,primaryKey,primaryValue];
    FMResultSet *set = [self.fmdb executeQuery:sql];
    SIMUsersModel *user = nil;
    if (result) {
        if ([set next]) {
            user = [SIMUsersModel createUserModelWithFMResultSet:set];
        }
    }
    [set close];
    result(user);
    [self.fmdb close];
}


/**
 根据用户Id删除一个用户

 @param userId 用户Id
 @param db_block 操作结果
 */
- (void)removeUser:(NSString *)userId db_block:(DBFinish)db_block {
    if(!userId || userId.length == 0) return;
    if(!self.fmdb.open) return;
    NSString *deleteData = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", _userTableName, SIMUsersModel.dbKey_Imid, userId];
    BOOL success = [self.fmdb executeUpdate:deleteData];
    if (db_block) db_block(success);
    [self.fmdb close];
}

- (void)catParams:(NSString **)dbKeys dbValues:(NSString **)dbValues key:(NSString *)key value:(id)value {
    if(value) {
        if([value isKindOfClass:[NSString class]]) {
            *dbKeys = [*dbKeys stringByAppendingString:[NSString stringWithFormat:@",%@", key]];
            *dbValues = [*dbValues stringByAppendingString:[NSString stringWithFormat:@",'%@'", value]];
        }else if([value isKindOfClass:[NSNumber class]]){
            *dbKeys = [*dbKeys stringByAppendingString:[NSString stringWithFormat:@",%@", key]];
            *dbValues = [*dbValues stringByAppendingString:[NSString stringWithFormat:@",%d", ((NSNumber *)value).intValue]];
        }
    }
}

- (void)carParams2:(NSString **)aql key:(NSString *)key value:(id)value {
    if(value) {
        if([value isKindOfClass:[NSString class]]) {
            *aql = [*aql stringByAppendingString:[NSString stringWithFormat:@",%@='%@'", key, value]];
        }else if([value isKindOfClass:[NSNumber class]]) {
            *aql = [*aql stringByAppendingString:[NSString stringWithFormat:@",%@=%d", key, ((NSNumber *)value).intValue]];
        }
    }
}

#pragma mark - 通知表操作
/**
 插入一条通知

 @param simData 通知
 @param block 操作完成的回调
 */
- (void)insetNotification:(SIMModel *)simData db_block:(DBBlock)block {
    if(!self.fmdb.open) return;
    __block NSString *log = nil;
    SIMNotificationModel *noti = simData.notification;
    NSString *tableName = _notiTableName;
    NSInteger dbTime = [ChatFMDBBase nowTimeStamp];
    NSString *sql       = [NSString stringWithFormat:@"insert into %@ ", tableName];
    NSString *dbKeys    = [NSString stringWithFormat:@"(%@", DBTIME];
    NSString *dbValues  = [NSString stringWithFormat:@" values  (%ld", dbTime];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_time value:simData.time];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMNotificationModel.dbkey_type value:noti.type];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMNotificationModel.dbkey_message value:noti.message];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_fromUserId value:simData.from_user.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_touserId value:simData.to_user.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_groupId value:simData.group.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_info value:simData.JSONStr];
    dbKeys = [dbKeys stringByAppendingString:@")"];
    dbValues = [dbValues stringByAppendingString:@")"];
    NSString *header = [NSString stringWithFormat:@"%@%@%@;", sql, dbKeys, dbValues];
    BOOL res = [self.fmdb executeUpdate:header];
    log = [NSString stringWithFormat:@"%@ inset result:%@", tableName ,@(res)];
    if(block) block(res);
    ChatLog(tag, log);
    [self.fmdb close];
}

/**
 标记一条通知为已读

 @param notificationInfo 通知内容
 @param block 操作结果
 */
- (void)markNotificationReadState:(SIMModel *)notificationInfo db_block:(DBBlock)block {
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = 1 where %@ = %@;", _notiTableName,
                     SIMModel.dbkey_isRead, SIMModel.dbkey_time , notificationInfo.time];
    if( ![self.fmdb open]) return;
    BOOL res = [self.fmdb executeUpdate:sql];
    if(block) block(res);
}

/**
 查询所有通知信息

 @param result 通知数组
 */
- (void)quertNotificationList:(void(^)(NSArray *))result {
    __block NSMutableArray *notiArr = [NSMutableArray new];
    [super queryDataByTableName:_notiTableName db_result:^(FMResultSet *obj) {
        NSString *simInfo = [obj stringForColumn:SIMModel.dbkey_info];
//        NSData *data = [simInfo dataUsingEncoding:NSUTF8StringEncoding];
//        simInfo = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        SIMModel *simNoti = [SIMModel modelWithJSON:simInfo];
        simNoti.isRead = [obj intForColumn:SIMModel.dbkey_isRead];
        simNoti.isDispose = [obj intForColumn:SIMModel.dbkey_isDispose];
        [notiArr addObject:simNoti];
    } db_complete:^{
        if(result) result(notiArr);
    }];
}


#pragma mark - 聊天表、会话表操作

/**
 存储一条新消息，同时更新该消息所属的会话

 @param simData 聊天消息
 @param block 聊天消息入库结果
 @param conversation 聊天消息所属会话(传空则不会更新会话，仅仅更新该条消息)
 */
- (void)insetSession:(SIMModel *)simData db_block:(DBBlock)block db_conversation:(DBUpdateConversation)conversation {
    if(!self.fmdb.open) return;
    __block NSString *log = nil;
    SIMChat *chatInfo = simData.chat;
    NSString *tableName = _sessionTableName;
    NSInteger dbTime = [ChatFMDBBase nowTimeStamp];
    NSString *sql       = [NSString stringWithFormat:@"insert into %@ ", tableName];
    NSString *dbKeys    = [NSString stringWithFormat:@"(%@", DBTIME];
    NSString *dbValues  = [NSString stringWithFormat:@" values  (%ld", (long)dbTime];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_time      value:simData.time.stringValue];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_fromUserId  value:simData.from_user.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_touserId    value:simData.to_user.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_groupId    value:simData.group.id];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMModel.dbkey_info      value:simData.JSONStr];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMChat.dbkey_type       value:chatInfo.type];
    [self catParams:&dbKeys dbValues:&dbValues key:SIMChat.dbkey_message_id value:chatInfo.message_id];
    dbKeys = [dbKeys stringByAppendingString:@")"];
    dbValues = [dbValues stringByAppendingString:@")"];
    NSString *header = [NSString stringWithFormat:@"%@%@%@;", sql, dbKeys, dbValues];
    BOOL res = [self.fmdb executeUpdate:header];
    log = [NSString stringWithFormat:@"新消息入库:(%@)" ,@(res)];
    if(block) block(res);
    ChatLog(tag, log);
    if(res && conversation) {
        [self updateConversation:(SIMModel *)simData db_block:^(BOOL isCompleted) {
            NSString *conversationUpdateStateDisplay = [NSString stringWithFormat:@"会话更新:%@", @(isCompleted)];
            ChatLog(tag, conversationUpdateStateDisplay);
        } db_conversationResult:^(SIMConversation *cModel, BOOL isNew) {
            if(conversation) conversation(cModel ,isNew);
        }];
    }
    [self.fmdb close];
}

/**
 更新一条消息

 @param simData 聊天消息
 @param block 操作结果
 */
- (void)updateSession:(SIMModel *)simData db_block:(DBBlock)block {
    NSString *messageId = simData.chat.message_id;
    if(!messageId) return;
    if( ![self.fmdb open]) return;
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", _sessionTableName, SIMChat.dbkey_message_id, messageId];
    BOOL res = [self.fmdb executeUpdate:sql];
    if(res) {
        [self insetSession:simData db_block:^(BOOL isCompleted) {
            if(block) block(isCompleted);
        } db_conversation:nil];//不更新Conversation
    }
    [self.fmdb close];
}

/**
 某条消息是否存在

 @param messageId 消息ID
 @param block 是否存在
 */
- (void)sessionIfExist:(NSString *)messageId db_block:(DBBlock)block {
    [super dataIsExistsInTable:_sessionTableName primaryKey:SIMChat.dbkey_message_id primaryValue:messageId db_option:^(BOOL isExist) {
        if(block) block(isExist);
    }];
}

/**
 查询视频、语音通话的消息

 @param result 操作结果
 */
- (void)queryDialogSession:(DBArray)result {
    if(!self.fmdb.open || !result) return;
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = %d OR %@ = %d;", _sessionTableName, SIMChat.dbkey_type, 8, SIMChat.dbkey_type, 9];
    FMResultSet *set = [self.fmdb executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    while ([set next]) {
        SIMModel *chatInfo = [SIMModel createSIMModelWithFMResultSet:set];
        [array addObject:chatInfo];
    }
    result(array);
    [set close];
    [self.fmdb close];
}

/**
 查询所有聊天消息
 
 @param result 会话数组
 */
- (void)quertSessionList:(NSInteger)pageIndex pageSize:(NSInteger)pageSize db_result:(void(^)(NSArray *, NSInteger *))result {
//    __block NSMutableArray *sessionArr = [NSMutableArray new];
//    [super queryDataByTableName:_sessionTableName db_result:^(FMResultSet *obj) {
//        NSString *simInfo    = [obj stringForColumn:SIMModel.dbkey_info];
//        SIMModel *simSession = [SIMModel modelWithJSON:simInfo];
//        [sessionArr addObject:simSession];
//    } db_complete:^{
//        if(result) result(sessionArr);
//    }];
    
}

/**
 根据聊天信息更新会话表

 @param simModel 聊天信息
 @param block 会话入库结果
 @param conversationResult 该聊天所属会话, 是否是产生新的会话
 */
- (void)updateConversation:(SIMModel *)simModel db_block:(DBBlock)block db_conversationResult:(DBUpdateConversation)conversationResult {
    __block NSString *log = nil;
    __block NSString *tableName = _conversationTableName;
    __block NSString *oppositeId =  simModel.isGroup ? simModel.group.id : simModel.getOppositeId;
    __block NSString *primaryKey = SIMConversation.dbkey_sessionId;
    [super dataIsExistsInTable:_conversationTableName primaryKey:primaryKey primaryValue:oppositeId db_option:^(BOOL isExists) {
        BOOL res = NO;
        SIMConversation *cModel = [[SIMConversation alloc] initWithSIMModel:simModel];
        if(!self.fmdb.open) return;
        if(isExists) {
            NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';",tableName,primaryKey,oppositeId];
            FMResultSet *set = [self.fmdb executeQuery:sql];
            if ([set next]) {
                // 读取
                NSInteger totalUnReadCount = cModel.unReadCount;
                SIMConversation *sqCModel = [SIMConversation createConversationModelWithFMResultSet:set];
                totalUnReadCount += sqCModel.unReadCount;
                [sqCModel db_updateModel:simModel unReadCount:totalUnReadCount];
                // 更新
                NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@=%ld", tableName, DBTIME, (long)[ChatDBTool nowTimeStamp]];
                [self carParams2:&sql key:SIMConversation.dbkey_sessionType  value:sqCModel.sessionType];
                [self carParams2:&sql key:SIMConversation.dbkey_messageIds   value:sqCModel.messageIds];
                [self carParams2:&sql key:SIMConversation.dbkey_unReadCount  value:@(sqCModel.unReadCount)];
                [self carParams2:&sql key:SIMConversation.dbkey_lastSession  value:sqCModel.lastSessionJSONStr];
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@" WHERE %@='%@'", primaryKey, oppositeId]];
                res = [self.fmdb executeUpdate:sql];
                log = [NSString stringWithFormat:@"%@ update result:%@", tableName ,@(res)];
                if(res) {
                    if(conversationResult) conversationResult(sqCModel, NO);
                }
            }
            [set close];
        }else{
            NSInteger dbTime = [ChatFMDBBase nowTimeStamp];
            NSString *sql       = [NSString stringWithFormat:@"insert into %@ ", tableName];
            NSString *dbKeys    = [NSString stringWithFormat:@"(%@", DBTIME];
            NSString *dbValues  = [NSString stringWithFormat:@" values  (%ld", (long)dbTime];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMConversation.dbkey_sessionType   value:cModel.sessionType];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMConversation.dbkey_unReadCount   value:@(cModel.unReadCount)];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMConversation.dbkey_sessionId     value:cModel.lastSession.getSessionId];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMConversation.dbkey_messageIds    value:cModel.messageIds];
            [self catParams:&dbKeys dbValues:&dbValues key:SIMConversation.dbkey_lastSession   value:cModel.lastSessionJSONStr];
            dbKeys = [dbKeys stringByAppendingString:@")"];
            dbValues = [dbValues stringByAppendingString:@")"];
            NSString *header = [NSString stringWithFormat:@"%@%@%@;", sql, dbKeys, dbValues];
            res = [self.fmdb executeUpdate:header];
            log = [NSString stringWithFormat:@"%@ inset result:%@", tableName ,@(res)];
            if(res) {
                if(conversationResult) conversationResult(cModel, YES);
            }
        }
        ChatLog(tag, log);
        if(block) block(res);
        [self.fmdb close];
    }];
}

/**
 获取所有会话

 @param result 操作结果
 */
- (void)allConversation:(void(^)(NSArray *))result  {
    if(! result) return;
    __block NSMutableArray *sqArray = [NSMutableArray new];
    [super queryDataByTableName:_conversationTableName db_result:^(FMResultSet *obj) {
        SIMConversation *sqCModel = [SIMConversation createConversationModelWithFMResultSet:obj];
        [sqArray addObject:sqCModel];
    } db_complete:^{
        result(sqArray);
    }];
}

/**
 获取会话下所有消息

 @param conversation 会话
 @param pageIndex 页Index
 @param pageSize 每页多少条数据
 @param result (数据数组，总共多少页)
 */
- (void)chatInfosInConversation:(SIMConversation *)conversation :(NSInteger)pageIndex pageSize:(NSInteger)pageSize db_result:(void(^)(NSArray *, NSInteger))result {
    if(pageSize == 0) {
        if(result) result(nil, 0);
        return;
    }
    NSMutableArray *conversationArray = [NSMutableArray new];
    NSArray *messageIds = [conversation db_GetMessageIds];
    messageIds = [[messageIds reverseObjectEnumerator] allObjects];
    if(!messageIds) {
        if(result) result(nil, 0);
        return;
    }
    NSInteger pageTotal = messageIds.count / pageSize; //页数
    NSInteger residue = messageIds.count % pageSize; //余数
    NSInteger startIndex = pageIndex * pageSize;
//    if(startIndex != 0) startIndex -= 1;
    NSMutableArray *newArray = [NSMutableArray new];
    for (NSInteger index = 0; index < pageSize; index ++) {
        if(startIndex + index < messageIds.count) {
            [newArray addObject:messageIds[startIndex + index]];
        }else{
            break;
        }
    }
    if(newArray.count > 0) {
        for (NSString *msgId in newArray) {
            [super queryDataByPrimaryKey:_sessionTableName primaryKey:SIMChat.dbkey_message_id primaryValue:msgId db_result:^(FMResultSet *set) {
                NSString *dataString = [set stringForColumn:SIMModel.dbkey_info];
                if(!dataString || [dataString isEqualToString:@""]) return;
                SIMModel *simModel = [SIMModel modelWithJSON:dataString];
                [conversationArray insertObject:simModel atIndex:0];
            }];
        }
    }
    if(residue > 0) pageTotal++;
    if(result) result(conversationArray, pageTotal);
}

/**
 标记某个会话的未读数为0

 @param conversation 会话
 @param isComplete 操作结果
 */
- (void)markUnReadState:(SIMConversation *)conversation isComplete:(DBBlock)isComplete {
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = 1 where %@ = %d;", _sessionTableName,
                     SIMModel.dbkey_isRead, SIMModel.dbkey_isRead, 0];
    NSString *sq2 = [NSString stringWithFormat:@"update %@ set %@ = 0 where %@ = %@;", _conversationTableName,
                     SIMConversation.dbkey_unReadCount, SIMConversation.dbkey_sessionId, conversation.sessionId];
    if( ![self.fmdb open]) return;
    BOOL res = [self.fmdb executeUpdate:sql];
    res = [self.fmdb executeUpdate:sq2];
    if(isComplete) isComplete(res);
    [self.fmdb close];
}

/**
 根据sessionId获取会话（用于从通讯录跳转至聊天界面时获取历史聊天消息）
 
 @param sessionId 对方的Id
 @param db_result 操作结果
 */
- (void)queryConversationBySessionId:(NSString *)sessionId db_result:(DBResult)db_result {
    NSCAssert(db_result, @"必须实现回调:DBResult");
    if(!self.fmdb.open) return;
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = '%@';",_conversationTableName, SIMConversation.dbkey_sessionId, sessionId];
    FMResultSet *set = [self.fmdb executeQuery:sql];
    if ([set next]) {
        SIMConversation *conversation = [SIMConversation createConversationModelWithFMResultSet:set];
        db_result(conversation);
    } else {
        db_result(nil);
    }
    [set close];
    [self.fmdb close];
}

/**
 删除一个会话及会话下的所有消息

 @param conversation 将要被删除的会话
 @param db_block 操作结果
 */
- (void)deleteAllmessagesFromConversation:(SIMConversation *)conversation db_block:(DBBlock)db_block {
    NSCAssert(db_block, @"必须实现回调:DBFinish");
    if(!self.fmdb.open) return;
    BOOL success = NO;
    NSArray *messageIds = [conversation db_GetMessageIds];
    for (NSString *mId in messageIds) {
        if(mId.length > 1) {
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", _sessionTableName, SIMChat.dbkey_message_id, mId];
            success = [self.fmdb executeUpdate:sql];
//            if(!success && db_block) {
//                db_block(success);
//                [self.fmdb close];
//                return;
//            }
        }
    }
    NSString *sql2 = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", _conversationTableName, SIMConversation.dbkey_sessionId, conversation.sessionId];
    success = [self.fmdb executeUpdate:sql2];
    if (db_block) db_block(success);
    [self.fmdb close];
    
}

@end
