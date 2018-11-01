//
//  IMConversationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/24.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMBaseManager.h"

@class FMResultSet;

NS_ASSUME_NONNULL_BEGIN

@interface IMConversationModel : IMBaseManager

@property (nonatomic, assign) IMConversationType type;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *messageIds;
@property (nonatomic, strong) IMModel *lastSession;
@property (nonatomic, assign) NSInteger unReadCount;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger dbTime;

+ (NSString *)dbkey_sessionType;
+ (NSString *)dbkey_sessionId;
+ (NSString *)dbkey_messageIds;
+ (NSString *)dbkey_unReadCount;
+ (NSString *)dbkey_lastSession;

+ (IMConversationModel *)modelWithIMModel:(IMModel *)imModel;
+ (IMConversationModel *)modelWithResultSet:(FMResultSet *)set;
- (void)db_updateModel:(IMModel *)model unReadCount:(NSInteger)unReadCount;

@end

NS_ASSUME_NONNULL_END
