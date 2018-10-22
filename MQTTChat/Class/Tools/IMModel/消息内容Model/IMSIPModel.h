//
//  IMSIPModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSIPModel : NSObject

@property (nonatomic,copy) NSString *channel; // 私聊为发起者IM唯一标识，群组为群组IM唯一标识
- (instancetype)initWithChannel:(NSString *)channel;

@end

NS_ASSUME_NONNULL_END
