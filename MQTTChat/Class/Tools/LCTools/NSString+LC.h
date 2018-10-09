//
//  NSString+LC.h
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LC)
#pragma mark - 路径
/** 获取 home 路径 */
+ (NSString *)getHomePath;

#pragma mark - APP相关
/** 获取bundleId*/
+ (NSString *)getBundleId;

/** 获取versionnumber */
+ (NSString *)getVersionNumber;

/** 获取build number */
+ (NSString *)getBuildNumber;

/** 获取手机系统 */
+ (NSString *)getIOSVersion;

/** 获取UUID */
+ (NSString *)getUUID;

#pragma mark - MD5 加密
/** MD5加密 : 32位小写 */
+ (NSString *)getMD5ForLower32Bate:(NSString *)str;

/** MD5加密 : 32位大写 */
+ (NSString *)getMD5ForUpper32Bate:(NSString *)str;

/** MD5加密 : 16为大写 */
+ (NSString *)getMD5ForUpper16Bate:(NSString *)str;

/** MD5加密 : 16位小写 */
+ (NSString *)getMD5ForLower16Bate:(NSString *)str;

#pragma mark - 数据转换
/** 字典,数组转 json */
+(NSString *)getJsonStrFromData:(id)data;

@end

NS_ASSUME_NONNULL_END
