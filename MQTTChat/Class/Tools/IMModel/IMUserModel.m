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

+ (NSString *)dbKey_Imid {
    return @"Imid";
}

+ (NSString *)dbKey_name {
    return @"name";
}

+ (NSString *)dbKey_nick {
    return @"nick";
}

+ (NSString *)dbKey_avator {
    return @"avator";
}

+ (instancetype)modelWithFMResultSet:(FMResultSet *)result {
    IMUserModel *user = [[IMUserModel alloc] init];
    user.Id     = [result stringForColumn:IMUserModel.dbKey_Imid];
    user.name   = [result stringForColumn:IMUserModel.dbKey_name];
    user.nick   = [result stringForColumn:IMUserModel.dbKey_nick];
    user.avator = [result stringForColumn:IMUserModel.dbKey_avator];
    return user;
}

@end
