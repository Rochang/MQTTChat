//
//  IMUserModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMUserModel.h"
#import <FMDB/FMDB.h>

@implementation IMUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSString *)db_Id {
    return @"user_Id";
}

+ (NSString *)db_name {
    return @"user_name";
}

+ (NSString *)db_nick {
    return @"user_nick";
}

+ (NSString *)db_avator {
    return @"user_avator";
}

+ (NSString *)db_is_online {
    return @"user_is_online";
}

+ (instancetype)modelWithFMResultSet:(FMResultSet *)result {
    IMUserModel *user = [[IMUserModel alloc] init];
    user.Id     = [result stringForColumn:IMUserModel.db_Id];
    user.name   = [result stringForColumn:IMUserModel.db_name];
    user.nick   = [result stringForColumn:IMUserModel.db_nick];
    user.avator = [result stringForColumn:IMUserModel.db_avator];
    user.is_online = [result boolForColumn:IMUserModel.db_is_online];
    return user;
}

@end
