//
//  LCFMDBManager.h
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCFMDBManager : NSObject

+ (instancetype)shareInstance;

// 创建表
- (void)creatTable:(NSString *)tableName formatStr:(NSString *)format;

// 删除表



@end

NS_ASSUME_NONNULL_END
