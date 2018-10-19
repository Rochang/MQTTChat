//
//  IMManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMManager.h"

@implementation IMManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static IMManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

@end
