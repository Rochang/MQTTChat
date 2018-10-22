//
//  IMChatVoiceModel.m
//  MQTTChat
//
//  Created by Rochang on 2018/10/21.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMChatVoiceModel.h"

@implementation IMChatVoiceModel

+ (instancetype)voiceWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath remotePath:(NSString *)remotePath {
    IMChatVoiceModel *voice = [[IMChatVoiceModel alloc] init];
    voice.suffix = suffix;
    voice.nativePath = voice.nativePath;
    if(nativePath && nativePath.length > 0) {
        voice.nativePath = nativePath;
        long long voiceSize = [IMTools fileSizeAtPath:nativePath];
        voice.size = [NSNumber numberWithLongLong:voiceSize];
        NSUInteger voiceDuretion = [IMTools voiceDuration:nativePath];
        voice.duration = [NSNumber numberWithUnsignedInteger:voiceDuretion];
    }
    return voice;
}

@end
