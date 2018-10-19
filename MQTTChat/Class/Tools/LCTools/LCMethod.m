//
//  LCMethod.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCMethod.h"

@implementation LCMethod

+ (void)UD_setWithDict:(NSDictionary *)dict {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [defaults setObject:obj forKey:key];
    }];
}

+ (void)UD_setObject:(id)obj forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (obj == nil) {
        NSLog(@"保存到偏好设置的obj为nil,把key对应的信息删除");
        [defaults removeObjectForKey:key];
        return;
    }
    [defaults setObject:obj forKey:key];
}

+ (id)UD_getObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)UD_setModel:(id)model forkey:(NSString *)key {
    if ([model respondsToSelector:@selector(encodeWithCoder:)] == NO) {
        NSLog(@"Error save object to NSUserDefaults. Object must respond to encodeWithCoder: message");
        return;
    }
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
}

+ (id)UD_getModelForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    id model = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return model;
}

+ (void)UD_setInteger:(NSInteger)integer forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:integer forKey:key];
}

+ (NSInteger)UD_getIntegerForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:key];
}

@end
