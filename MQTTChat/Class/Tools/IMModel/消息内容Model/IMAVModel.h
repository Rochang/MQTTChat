//
//  IMAVModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

// 全景视频数据暂放
@interface SIMRtmpModel : NSObject

@property(nonatomic, strong) NSString *rtmp_addres;//（RTMP播放地址）
@property(nonatomic, strong) NSString *video_name;//会议名称
@property(nonatomic, strong) NSNumber *video_type;//（视频类型；1为普通视频，2为全景视频）

@end


@interface IMAVModel : IMMediaModel

@property (nonatomic, strong) SIMRtmpModel *video;

+ (instancetype)mediaWithSDKType:(IMMediaSDKType)SDKType actionType:(IMMediaActionType)actionType callStatus:(IMCallStatus)callStatus duration:(NSNumber *)duration;
@end

NS_ASSUME_NONNULL_END
