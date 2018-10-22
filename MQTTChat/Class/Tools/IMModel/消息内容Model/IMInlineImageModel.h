//
//  IMInlineImageModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMInlineImageModel : IMChatContentModel

@property(nonatomic, copy) NSString *base64; // base64编码
@property(nonatomic, strong) NSNumber *width; // 宽
@property(nonatomic, strong) NSNumber *height; // 高

- (instancetype)initWithBaseStr:(NSString *)base64 width:(NSInteger)width height:(NSInteger)height;

@end

NS_ASSUME_NONNULL_END
