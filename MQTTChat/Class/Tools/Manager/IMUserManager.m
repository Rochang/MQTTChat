//
//  IMUserManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMUserManager.h"
#import "IMMQTTManager.h"
#import "IMFMDBManager.h"

@implementation IMUserManager

- (void)userHandldRsponse:(IMModel *)model {
    NSString *topic = model.response.topic;
    NSString *failMessage = !model.response.code ? model.response.msg : nil;
    // 获取好友列表
    if ([topic isEqualToString:KfriendsListTopic]) {
        if (!model.response.userList.items.count) return;
        [FMDBShare insertFirends:model.response.userList.items];
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
        [FMDBShare insertGroups:model.response.groupList.items];
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

- (void)publishFriendsList {
    NSData *data = [NSData dataWithObjc:[NSDictionary dictionary]];
    [MQTTShare publishDataAtLeastOnce:data onTopic:KfriendsListTopic];
}

- (NSArray<IMUserModel *> *)getFriendsList {
    return [FMDBShare queryFirendList];
}

- (void)publishGroupsList {
    NSData *data = [NSData dataWithObjc:[NSDictionary dictionary]];
    [MQTTShare publishDataAtLeastOnce:data onTopic:KgroupersListTopic];
}

- (NSArray<IMGroupModel *> *)getGroupsList {
    return [FMDBShare queryGroupList];
}

@end
