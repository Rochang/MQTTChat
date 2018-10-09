//
//  LCAccountModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCAccountModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *phone;

@end

NS_ASSUME_NONNULL_END
