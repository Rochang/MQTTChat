//
//  IMConversationManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMConversationManager.h"
#import "IMSDKManager.h"
#import "FMDBBase.h"

@interface IMConversationManager ()

// 当前聊天室的对方ID
@property (nonatomic, copy) NSString *currentFriendId;


@end

@implementation IMConversationManager

- (void)insertConversation:(IMModel *)model {
    if ([model isTalkingWithFirend:self.currentFriendId]) {
        model.isRead = YES;
    } else { // 提示
        [IMShare.notificationManager notification:model];
    }
    // 存入数据库
    [];
}


@end
