//
//  IMMediaModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSIPModel.h"
#import "IMAgoraModel.h"

NS_ASSUME_NONNULL_BEGIN

// 音视频Model
@interface IMMediaModel : NSObject

@property (nonatomic, assign) IMMediaSDKType SDKType; //  服务类型;1为SIP,2为声网
@property (nonatomic, assign) IMMediaActionType actionType; // 指令类型；1.发起请求，0取消
@property (nonatomic, assign) IMCallStatus callStatus; // 会话状态；1已取消，2已拒绝，3已接听
@property (nonatomic, strong) NSNumber *duration; // 时长；单位：毫秒
@property (nonatomic, assign) IMMediaType mediaType; // 类型;1为仅视频,2为带聊天界面的视频;当前只支持仅视频类型,3画板功能,4带全景和白板的视频通话
@property (nonatomic, assign) BOOL is_auto_answer; // 是否自动接听   true的话 直接接听 false弹出是否接听的对话框
@property (nonatomic, strong) IMAgoraModel *agora; // 声网相关参数
@property (nonatomic, strong) IMSIPModel *sip;

@end

NS_ASSUME_NONNULL_END
