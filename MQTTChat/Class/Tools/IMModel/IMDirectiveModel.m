//
//  IMDirectiveModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMDirectiveModel.h"

@implementation IMDirectiveModel

+ (instancetype)directiveModelWithType:(IMDirectiveType)directiveType is_silence:(BOOL)is_silence actionType:(IMDirectiveActionType)actionType camera_id:(NSNumber *)camera_id camera_ids:(NSArray *)camera_ids videoModel:(IMVideoModel *)videoModel liveModel:(IMLiveModel *)liveModel navigationModel:(IMNavigationModel *)navigationModel isFeedback:(BOOL)isFeedback {
    IMDirectiveModel *model = [[IMDirectiveModel alloc] init];
    model.is_silence = is_silence;
    model.actionType = actionType;
    model.camera_id = camera_id;
    model.camera_ids = camera_ids;
    model.videoModel = videoModel;
    model.liveModel = liveModel;
    model.navigationModel = navigationModel;
    model.isFeedback = isFeedback;
    return model;
}

/** 拍照 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId {
    return [self directiveModelWithType:IMDirectiveTypeTakePhoto is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:nil liveModel:nil navigationModel:nil isFeedback:NO];
}
/** 录像 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId video:(IMVideoModel *)video {
    return [self directiveModelWithType:IMDirectiveTypeVideo is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:video liveModel:nil navigationModel:nil isFeedback:NO];
}
/** 直播 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId live:(IMLiveModel *)live {
    return [self directiveModelWithType:IMDirectiveTypeLive is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:nil liveModel:live navigationModel:nil isFeedback:NO];
}
/** 预约导航 */
+ (instancetype)directiveWithNavigation:(IMNavigationModel *)navigation {
    return [self directiveModelWithType:IMDirectiveTypeNavigation is_silence:NO actionType:IMDirectiveActionTypeNone camera_id:nil camera_ids:nil videoModel:nil liveModel:nil navigationModel:navigation isFeedback:NO];
}
/** 上报位置 */
+ (instancetype)directiveWithLocation {
    
}

/** 视频会话 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSNumber *)cameraId videoModel:(IMAVModel *)videoModel {
    return [self directiveModelWithType:IMDirectiveTypeVideoSession is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:videoModel liveModel:nil navigationModel:nil isFeedback:NO];
}
/** 语音对讲  */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence talkbackModel:(IMTalkbackModel *)talkbackModel {
    return [self directiveModelWithType:IMDirectiveTypeVideoSession is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:videoModel liveModel:nil navigationModel:nil isFeedback:NO];
}
/** 控制设备方向指令 */
+ (instancetype)directiveWithDirection:(NSInteger)diretion {
    
}
/** 获取文件列表指令 */
+ (instancetype)directiveFileListWithType:(NSInteger)type splitInterval:(float)splitInterval startTime:(NSDate *)startTime endTime:(NSDate *)endTime {
    return [self directiveModelWithType:IMDirectiveTypeVideoSession is_silence:isSilence actionType:IMDirectiveActionTypeNone camera_id:cameraId camera_ids:nil videoModel:videoModel liveModel:nil navigationModel:nil isFeedback:NO];
}
/** // 获取文件指令 */
+ (instancetype)directiveGetFileWithPath:(NSString *)path ftpDir:(NSString *)ftpDir ftpName:(NSString *)ftpName ftpPass:(NSString *)ftpPass {
    
}
/** 发送sip指令 */
+ (instancetype)directiveSipInfoWithExit:(NSNumber *)exit imid:(NSString *)imid sipid:(NSString *)sipid ssrc:(NSNumber *)ssrc {
    
}

@end
