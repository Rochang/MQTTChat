//
//  IMBaseManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 实现多播代理
@interface IMBaseManager : NSObject

- (void)addDelegate:(id<NSObject>)delegate;
- (void)removeDelegate:(id<NSObject>)delegate;
/** 遍历delegates */
- (void)respondsToTargetSelector:(SEL)sel enumerateObjectsWithOptions:(void (^)(id delegate))options;

@end

NS_ASSUME_NONNULL_END
