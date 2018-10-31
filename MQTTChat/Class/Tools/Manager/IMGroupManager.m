//
//  IMGroupManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMGroupManager.h"
#import "IMMQTTManager.h"
#import "IMFMDBManager.h"

@implementation IMGroupManager

- (void)publishAllGroups {
    NSData *data = [NSData dataWithObjc:[NSDictionary dictionary]];
    [MQTTShare publishDataAtLeastOnce:data onTopic:KgroupersListTopic];
}

- (NSArray<IMGroupModel *> *)getAllGroups {
    NSMutableArray *groups = [NSMutableArray array];
    
    return groups;
}

@end
