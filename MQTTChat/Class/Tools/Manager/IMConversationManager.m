//
//  IMConversationManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMConversationManager.h"

@interface IMConversationManager ()


@end

@implementation IMConversationManager

- (void)handleChatConversation:(IMModel *)model {
    if ([model isTalkingWithFirend:self.currentChatId]) {
        model.isRead = YES;
    } else { // 提示
//        [IMShare.notificationManager notification:model];
    }
    [self insertChatConversation:model isRemote:YES];
}

- (void)insertChatConversation:(IMModel *)model isRemote:(BOOL)isRemote {
    // 存入数据库
    [FMDBShare insertChatConversation:model chatComplete:^(BOOL flag, IMModel * _Nonnull model) {
        if (isRemote) { // 更新页面
            [self respondsToTargetSelector:@selector(conversationManagerFinishInsertChatModel:) enumerateObjectsWithOptions:^(id  _Nonnull delegate) {
                [delegate conversationManagerFinishInsertChatModel:model];
            }];
        } else { // 存库成功, 发送成功
            [self messageDidSendFinish:model];
        }
    } conversationComplete:^(BOOL flag, IMModel * _Nonnull model) {
        // 更新会话
        [self respondsToTargetSelector:@selector(conversationManagerFinishUpdateConversationModel:) enumerateObjectsWithOptions:^(id  _Nonnull delegate) {
            [delegate conversationManagerFinishUpdateConversationModel:model];
        }];
    }];
}

- (void)messageDidSendFinish:(IMModel *)model {
    [self respondsToTargetSelector:@selector(conversationManagerFinishSendMessageModel:) enumerateObjectsWithOptions:^(id  _Nonnull delegate) {
        [delegate conversationManagerFinishSendMessageModel:model];
    }];
}

- (NSArray<IMConversationModel *> *)getAllConversations {
    return [FMDBShare queryAllConversation];
}

//- (void)setDelegate:(id<IMConversationManagerDelegate>)delegate currentChatId:(NSString *)chatId {
//    _delegate = delegate;
//    _currentChatId = chatId;
//}
//
//- (void)removeDelegateAndChatId {
//    _delegate = nil;
//    _currentChatId = nil;
//}

- (void)resetUnReadCount:(IMConversationModel *)model complete:(completeBlock)complete {
    if (model.unReadCount == 0) return;
    [FMDBShare resetConversationUnReadCount:model complete:complete];
}


@end
