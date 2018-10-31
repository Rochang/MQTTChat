//
//  IMNotificationManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/23.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMNotificationManager.h"
#import <EBBannerView.h>

@interface IMNotificationManager ()

@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation IMNotificationManager

- (void)handleNotification:(IMModel *)model {
    switch (model.notification.type) {
            // 其他设备登录
        case IMNotificationTypeOtherLogin:{
            [EBBannerView showWithContent:@"你的账号在其他设备上登录"];
        }
            // 同意接受好友申请
        case IMNotificationTypeAcceptFriend:{
            
        }
            // 拒绝接受好友申请
        case IMNotificationTypeRejectFriend:{
            
        }
            // 收到好友申请
        case IMNotificationTypeApplyFriend:{
            
        }
            // 被好友删除
        case IMNotificationTypeRemoveFriend:{
            
        }
            // 同意加群申请
        case IMNotificationTypeAcceptGroup:{
            
        }
            // 拒绝加群申请
        case IMNotificationTypeRejectGroup:{
            
        }
            // 被邀请入群
        case IMNotificationTypeInviteGroup:{
            
        }
            // 被移除出群
        case IMNotificationTypeSelfKickOutGroup:{
            
        }
            
        default:
            break;
    }
}

@end
