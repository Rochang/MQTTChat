//
//  IMUserManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMUserManager.h"
#import "IMMQTTManager.h"

@implementation IMUserManager

- (void)publishFriendsList {
    [MQTTShare publishDataAtMostOnce:[NSData new] onTopic:KfriendsListTopic];
}

- (NSArray<IMUserModel *> *)getFriendsList {
    return [FMDBShare getFirendList];
}

- (void)handldRsponse:(IMModel *)model {
    NSString *topic = model.response.topic;
    NSString *failMessage = !model.response.code ? model.response.msg : nil;
    // 获取好友列表
    if ([topic isEqualToString:KfriendsListTopic]) {
        if (!model.response.data.items.count) return;
        [IMShare.fmdbManager addFirends:model.response.data.items];
            
    }
    // 模糊查询
    else if ([topic isEqualToString:KuserAccountSearchTopic]) {
        
    }
    // 添加好友请求回调
    else if ([topic isEqualToString:KaddFriendTopic]) {
        
    }
    // 删除好友请求回调
    else if ([topic isEqualToString:KremoveFriendTopic]) {
        
    }
    // 接受或拒绝好友请求回调
    else if ([topic isEqualToString:KacceptOrRejectFriendTopic]) {
        
    }
    // 创建群组
    else if ([topic isEqualToString:KcreateGroupTopic]) {
        
    }
    // 获取群组列表
    else if ([topic isEqualToString:KgroupersListTopic]) {
        
    }
    // 获取群组成员列表
    else if ([topic isEqualToString:KgroupMemberListTopic]) {
        
    }
    // 加群
    else if ([topic isEqualToString:KaddGroupTopic]) {
        
    }
    // 接受或拒绝加群申请
    else if ([topic isEqualToString:KacceptOrRejectGroupApplyTopic]) {
        
    }
    // 退出群
    else if ([topic isEqualToString:KquitGroupTopic]) {
        
    }
    // 解散群
    else if ([topic isEqualToString:KdeleteGroupTopic]) {
        
    }
    // 添加群成员
    else if ([topic isEqualToString:KaddGroupMemberTopic]) {
        
    }
    // 删除群成员
    else if ([topic isEqualToString:KdeleteGroupMemberTopic]) {
        
    }
}

@end
