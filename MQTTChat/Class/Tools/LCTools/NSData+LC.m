//
//  NSData+LC.m
//  MQTTChat
//
//  Created by rochang on 2018/10/31.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "NSData+LC.h"

@implementation NSData (LC)

+ (instancetype)dataWithObjc:(id)obj {
    return [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
}

@end
