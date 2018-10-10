//
//  IMChatContentModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//  会话内容Mdoel

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMChatContentModel : NSObject

@property (copy, nonatomic) NSString *text; // 文本
@property (copy, nonatomic) NSString *sound; // 语音路径
@property (copy, nonatomic) NSString *file; // 文件路径
@property (copy, nonatomic) NSString *picture; // 图片路径

@end

NS_ASSUME_NONNULL_END
