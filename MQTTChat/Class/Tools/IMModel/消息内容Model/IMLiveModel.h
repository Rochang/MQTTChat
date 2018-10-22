//
//  IMLiveModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IMLiveType) {
    IMLiveStop  = 0, //停止直播
    IMLiveStart = 1  //开启直播
};

@interface IMLiveModel : NSObject

@property(nonatomic,strong) NSNumber *duration; // 时长；单位：毫秒
@property(nonatomic,copy) NSString *room_id; // 聊天室ID;开启公共直播时必含
@property(nonatomic,copy) NSString *push_address; // 推流地址
@property(nonatomic,copy) NSString *play_address; // 播放地址
@property(nonatomic,copy) NSString *rtmp_address; // RTMP流地址
@property(nonatomic,copy) NSString *hls_address; // HLS流地址
@property(nonatomic, strong) NSNumber *is_public; // Boolean:是否开启公共直播(Y)
@property(nonatomic, strong) NSNumber *status; // Int:直播状态;1开启直播，0停止直播(Y)

+ (instancetype)liveWithDuration:(NSNumber *)duration roomId:(NSString *)roomId pushAddress:(NSString *)pushAddress playAddress:(NSString *)playAddress rtmpAddress:(NSString *)rtmpAddress hlsAddress:(NSString *)hlsaddress;

@end

NS_ASSUME_NONNULL_END
