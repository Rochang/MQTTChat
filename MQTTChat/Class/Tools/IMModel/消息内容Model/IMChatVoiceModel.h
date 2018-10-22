//
//  IMChatVoiceModel.h
//  MQTTChat
//
//  Created by Rochang on 2018/10/21.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMChatVoiceModel : IMChatContentModel

@property(nonatomic,strong) NSNumber *duration; // 时长；单位：毫秒

+ (instancetype)voiceWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath remotePath:(NSString *)remotePath;

@end

NS_ASSUME_NONNULL_END
