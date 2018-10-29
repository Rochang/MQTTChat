//
//  IMConversationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/24.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMBaseManager.h"
#import "IMModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMConversationModel : IMBaseManager

@property (nonatomic, assign) IMConversationType conversationType;
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

@end

NS_ASSUME_NONNULL_END
