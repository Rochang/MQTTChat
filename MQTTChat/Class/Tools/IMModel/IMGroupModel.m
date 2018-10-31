//
//  IMGroupModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMGroupModel.h"
#import <FMDB/FMDB.h>

@implementation IMGroupModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSString *)db_Id {
    return @"group_id";
}

+ (NSString *)db_name {
    return @"group_name";
}

+ (instancetype)modelWithFMResultSet:(FMResultSet *)result {
    IMGroupModel *group = [[IMGroupModel alloc] init];
    group.Id = [result stringForColumn:IMGroupModel.db_Id];
    group.name = [result stringForColumn:IMGroupModel.db_name];
    return group;
}

@end
