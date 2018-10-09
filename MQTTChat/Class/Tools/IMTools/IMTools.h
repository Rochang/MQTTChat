//
//  IMTools.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMTools : NSObject

/** 获取clientId */
+ (NSString *)clientId:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
