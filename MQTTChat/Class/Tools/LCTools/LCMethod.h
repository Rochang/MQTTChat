//
//  LCMethod.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCMethod : NSObject

#pragma mark - NSUserDefaults
/** 遍历字典保存到偏好设置 */
+ (void)UD_setWithDict:(NSDictionary *)dict;

/** 保存到偏好设置(单项) */
+ (void)UD_setObject:(id)obj forKey:(NSString *)key;

/** 偏好设置根据key取值 */
+ (id)UD_getObjectForKey:(NSString *)key;

/** 保存model到偏好设置 */
+ (void)UD_setModel:(id)model forkey:(NSString *)key;

/** 取出偏好设置保存的model */
+ (id)UD_getModelForKey:(NSString *)key;

/** 保存NSInteger */
+ (void)UD_setInteger:(NSInteger)integer forKey:(NSString *)key;

/** 获取NSUInteger */
+ (NSInteger)UD_getIntegerForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
