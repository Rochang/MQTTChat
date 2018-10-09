//
//  IMTools.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//  项目用到的Id

#import "IMTools.h"

@implementation IMTools

+ (NSString *)clientId:(NSString *)userName {
    return [NSString stringWithFormat:@"[2]_[%@]_[%@]_[%@]", @"com.sly.simsdk", [NSString getUUID], userName];
}

@end
