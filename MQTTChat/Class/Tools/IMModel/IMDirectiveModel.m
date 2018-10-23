//
//  IMDirectiveModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMDirectiveModel.h"

@implementation IMDirectiveModel

+ (instancetype)directiveModelWithType:(IMDirectiveType)directiveType is_silence:(BOOL)is_silence actionType:(IMDirectiveActionType)actionType camera_id:(NSNumber *)camera_id camera_ids:(NSArray *)camera_ids videoRecord:(IMVideoModel *)videoRecord videoModel:(IMAVModel *)videoModel audioModel:(IMAVModel *)audioModel liveModel:(IMLiveModel *)liveModel navigationModel:(IMNavigationModel *)navigationModel talkbackModel:(IMTalkbackModel *)talkbackModel isFeedback:(BOOL)isFeedback {
    IMDirectiveModel *model = [[IMDirectiveModel alloc] init];
    model.is_silence = is_silence;
    model.actionType = actionType;
    model.camera_id = camera_id;
    model.camera_ids = camera_ids;
    model.videoRecord = videoRecord;
    model.videoModel = videoModel;
    model.audioModel = audioModel;
    model.liveModel = liveModel;
    model.navigationModel = navigationModel;
    model.talkbackModel = talkbackModel;
    model.isFeedback = isFeedback;
    return model;
}

/** 拍照 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId {
    return [self directiveModelWithType:IMDirectiveTypeTakePhoto
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:cameraId
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:nil
                             audioModel:nil
                              liveModel:nil
                        navigationModel:nil
                          talkbackModel:nil
                             isFeedback:NO];
}
/** 录像 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId videoRecord:(IMVideoModel *)videoRecord {
    return [self directiveModelWithType:IMDirectiveTypeVideoRecord
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:cameraId
                             camera_ids:nil
                            videoRecord:videoRecord
                             videoModel:nil
                             audioModel:nil
                              liveModel:nil
                        navigationModel:nil
                          talkbackModel:nil
                             isFeedback:NO];
}
/** 直播 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId live:(IMLiveModel *)live {
    return [self directiveModelWithType:IMDirectiveTypeLive
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:cameraId
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:nil
                             audioModel:nil
                              liveModel:live
                        navigationModel:nil
                          talkbackModel:nil
                             isFeedback:NO];
}
/** 预约导航 */
+ (instancetype)directivenWithNavigation:(IMNavigationModel *)navigation {
    return [self directiveModelWithType:IMDirectiveTypeNavigation
                             is_silence:NO
                             actionType:IMDirectiveActionTypeNone
                              camera_id:nil
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:nil
                             audioModel:nil
                              liveModel:nil
                        navigationModel:navigation
                          talkbackModel:nil
                             isFeedback:NO];
}
/** 上报位置 */
+ (instancetype)directiveWithLocation {
    IMDirectiveModel *model = [[IMDirectiveModel alloc] init];
    model.directiveType = IMDirectiveActionTypeLocation;
    return model;
}

/** 音频会话 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId audioModel:(IMAVModel *)audioModel {
    return [self directiveModelWithType:IMDirectiveTypeAudioSession
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:cameraId
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:nil
                             audioModel:audioModel
                              liveModel:nil
                        navigationModel:nil
                          talkbackModel:nil
                             isFeedback:NO];
}

/** 视频会话 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId videoModel:(IMAVModel *)videoModel {
    return [self directiveModelWithType:IMDirectiveTypeVideoSession
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:cameraId
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:videoModel
                             audioModel:nil
                              liveModel:nil
                        navigationModel:nil
                          talkbackModel:nil
                             isFeedback:NO];
}

/** 语音对讲  */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence talkbackModel:(IMTalkbackModel *)talkbackModel {
    return [self directiveModelWithType:IMDirectiveTypeTakePhoto
                             is_silence:isSilence
                             actionType:IMDirectiveActionTypeNone
                              camera_id:nil
                             camera_ids:nil
                            videoRecord:nil
                             videoModel:nil
                             audioModel:nil
                              liveModel:nil
                        navigationModel:nil
                          talkbackModel:talkbackModel
                             isFeedback:NO];
}

@end
