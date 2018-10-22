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


NS_ASSUME_NONNULL_BEGIN

@interface IMDirectiveModel : NSObject

// 指令类型
@property (nonatomic, assign) IMDirectiveType directiveType;
// 是否静默操作
@property (nonatomic, assign) BOOL is_silence;
// 设备ID数组(N) -> type=4时为(Y)
@property (nonatomic, strong) NSArray *device_ids;
// Int:操作;0所有信息，1在线状态，2位置
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
// 视频信息
@property (nonatomic, strong) IMVideoModel *video;
// 直播信息
@property (nonatomic, strong) IMLiveModel *live;
// 导航信息
@property (nonatomic, strong) IMNavigationModel *navigation;
// 是否需要文字反馈
@property (nonatomic,assign) BOOL is_need_text_feedback;


/**
 * 指令内容类构造方法
 *  拍照
 *  @param isSilence Yes 静默 No 非静默
 @param cameraId 摄像头ID
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId;
/**
 * 指令内容类构造方法
 *  录像
 *  @param isSilence Yes 静默 No 非静默
 @param cameraId 摄像头ID
 @param video 录像内容
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId video:(IMVideoModel *)video;
/**
 * 指令内容类构造方法
 *  直播
 @param isSilence Yes 静默 No 非静默
 @param cameraId 摄像头ID
 @param live 直播内容
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId live:(IMLiveModel *)live;
/**
 * 指令内容类构造方法
 *  状态
 @param cameraIds 摄像头ID数组
 */
+ (instancetype)directiveWithCameraIds:(NSArray<NSNumber *> *)cameraIds action:(IMDirectiveActionType)action;
/**
 * 指令内容类构造方法
 *  预约导航
 @param navigation 导航内容
 */
+ (instancetype)directiveWithNavigation:(IMNavigationModel *)navigation;
/**
 * 指令内容类构造方法
 *  上报日志
 @param log 日志内容
 */
+ (instancetype)directiveWithLog:(SIMDirectiveLog *)log;
/**
 * 指令内容类构造方法
 *  上报位置
 */
+ (instancetype)directiveWithLocation;
/**
 * 指令内容类构造方法
 *  视频会话
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId videoDialog:(SIMVoiceDialog *)videoDialog;
/**
 * 指令内容类构造方法
 *  音频会话
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId voiceDialog:(SIMVoiceDialog *)voiceDialog;
/**
 * 指令内容类构造方法
 *  语音对讲
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence intercom:(SIMDirIntercom *)intercom;
/**
 * 指令内容类构造方法
 *  会话控制
 */
+ (instancetype)directiveWithIsSilence:(BOOL)isSilence cameraId:(NSInteger)cameraId dialogControl:(SIMDialogControl *)dialogControl;
//控制设备方向指令
+ (instancetype)directiveWithDirection:(NSInteger)diretion;

//获取文件列表指令
+ (instancetype)directiveFileListWithType:(NSInteger)type splitInterval:(float)splitInterval startTime:(NSDate *)startTime endTime:(NSDate *)endTime;

//获取文件指令
+ (instancetype)directiveGetFileWithPath:(NSString *)path ftpDir:(NSString *)ftpDir ftpName:(NSString *)ftpName ftpPass:(NSString *)ftpPass;
//发送sip指令
+ (instancetype)directiveSipInfoWithExit:(NSNumber *)exit imid:(NSString *)imid sipid:(NSString *)sipid ssrc:(NSNumber *)ssrc;

@end

NS_ASSUME_NONNULL_END
