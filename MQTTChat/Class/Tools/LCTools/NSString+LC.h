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
+ (NSString *)homePath;

#pragma mark - APP相关
/** 获取bundleId*/
+ (NSString *)BundleId;

/** 获取versionnumber */
+ (NSString *)VersionNumber;

/** 获取build number */
+ (NSString *)BuildNumber;

/** 获取手机系统 */
+ (NSString *)IOSVersion;

/** 获取UUID */
+ (NSString *)UUID;

#pragma mark - MD5 加密
/** MD5加密 : 32位小写 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;

/** MD5加密 : 32位大写 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

/** MD5加密 : 16为大写 */
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;

/** MD5加密 : 16位小写 */
+ (NSString *)MD5ForLower16Bate:(NSString *)str;

#pragma mark - 数据转换
/** 字典,数组转 json */
+ (NSString *)jsonStrFromData:(id)data;

/** 获取当前时间戳 */
+ (NSString *)timestamp;

/** 字符串叠加 */
- (NSString *)addStrs:(NSArray <NSString *>*)strings;
- (NSString *)addStr:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
