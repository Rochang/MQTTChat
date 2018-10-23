//
//  IMDirectiveModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMVideoModel.h"
#import "IMLiveModel.h"
#import "IMNavigationModel.h"
#import "IMAVModel.h"
#import "IMTalkbackModel.h"

@interface IMDirectiveModel : NSObject

// 指令类型
@property (nonatomic, assign) IMDirectiveType directiveType;
// 是否静默操作
@property (nonatomic, assign) BOOL is_silence;
// 操作;1所有信息，2在线状态，3位置
@property (nonatomic, assign) IMDirectiveActionType actionType;
/**
 Int:摄像头ID(摄像头索引命名规则为“方位代号+序数”;
 对于有方位的摄 像头，前后左右对应的方位代号分别为1到4;
 对于没有方位的摄像头，方位代号为5;
 序数为从1开始增长的 整数。如 @(1000001))
 */
@property (nonatomic, strong) NSNumber *camera_id;
/**
 摄像头ID数组(N)
 摄像头索引命名规则为“方位代号+序数”
 对于有方位的摄 像头，前后左右对应的方位代号分别为1到4;
 序数为从1开始增长的 整数。如 @(1000001))
 */
@property (nonatomic, strong) NSArray *camera_ids;
// 视频
@property (nonatomic, strong) IMAVModel *videoModel;
// 录像
@property (nonatomic, strong) IMVideoModel *videoRecord;
// 音频
@property (nonatomic, strong) IMAVModel *audioModel;
// 直播
@property (nonatomic, strong) IMLiveModel *liveModel;
// 对讲
@property (nonatomic, strong) IMTalkbackModel *talkbackModel;
// 导航
@property (nonatomic, strong) IMNavigationModel *navigationModel;
// 是否需要文字反馈
@property (nonatomic,assign) BOOL isFeedback;

/** 构造方法 */
+ (instancetype)directiveModelWithType:(IMDirectiveType)directiveType is_silence:(BOOL)is_silence actionType:(IMDirectiveActionType)actionType camera_id:(NSNumber *)camera_id camera_ids:(NSArray *)camera_ids videoRecord:(IMVideoModel *)videoRecord videoModel:(IMAVModel *)videoModel audioModel:(IMAVModel *)audioModel liveModel:(IMLiveModel *)liveModel navigationModel:(IMNavigationModel *)navigationModel talkbackModel:(IMTalkbackModel *)talkbackModel isFeedback:(BOOL)isFeedback;

/** 拍照 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId;
/** 录像 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId videoRecord:(IMVideoModel *)videoRecord;
/** 直播 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId live:(IMLiveModel *)live;
/** 预约导航 */
+ (instancetype)directivenWithNavigation:(IMNavigationModel *)navigation;
/** 上报位置 */
+ (instancetype)directiveWithLocation;
/** 视频会话 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId videoModel:(IMAVModel *)videoModel;
/** 音频会话 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId audioModel:(IMAVModel *)audioModel;
/** 语音对讲  */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence talkbackModel:(IMTalkbackModel *)talkbackModel;

@end
