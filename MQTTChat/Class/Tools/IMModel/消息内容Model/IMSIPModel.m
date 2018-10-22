//
//  IMSIPModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMSIPModel.h"

@implementation IMSIPModel

- (instancetype)initWithChannel:(NSString *)channel {
    if (self = [super init]) {
        _channel = channel;
    }
    return self;
}

@end
