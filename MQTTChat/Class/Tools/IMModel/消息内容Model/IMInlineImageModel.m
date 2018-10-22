//
//  IMInlineImageModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMInlineImageModel.h"

@implementation IMInlineImageModel

- (instancetype)initWithBaseStr:(NSString *)base64 width:(NSInteger)width height:(NSInteger)height {
    if (self = [super init]) {
        _base64 = base64;
        _width = [NSNumber numberWithInteger:width];
        _height = [NSNumber numberWithInteger:height];
    }
    return self;
}

@end
