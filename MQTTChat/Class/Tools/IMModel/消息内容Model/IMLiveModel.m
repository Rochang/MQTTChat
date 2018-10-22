//
//  IMLiveModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMLiveModel.h"

@implementation IMLiveModel

+ (instancetype)liveWithDuration:(NSNumber *)duration roomId:(NSString *)roomId pushAddress:(NSString *)pushAddress playAddress:(NSString *)playAddress rtmpAddress:(NSString *)rtmpAddress hlsAddress:(NSString *)hlsaddress
{
    IMLiveModel *live = [[IMLiveModel alloc] initWithDuration:duration roomId:roomId pushAddress:pushAddress playAddress:playAddress rtmpAddress:rtmpAddress hlsAddress:hlsaddress];
    return live;
}
- (instancetype)initWithDuration:(NSNumber *)duration roomId:(NSString *)roomId pushAddress:(NSString *)pushAddress playAddress:(NSString *)playAddress rtmpAddress:(NSString *)rtmpAddress hlsAddress:(NSString *)hlsAddress
{
    if (self = [super init]) {
        _duration = duration;
        _room_id = roomId;
        _push_address = pushAddress;
        _play_address = playAddress;
        _rtmp_address = rtmpAddress;
        _hls_address = hlsAddress;
    }
    return self;
}

@end
