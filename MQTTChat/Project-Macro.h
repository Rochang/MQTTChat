//
//  Project-Macro.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#ifndef Project_Macro_h
#define Project_Macro_h

#define kHost @"106.14.93.204"
#define Kport 1883
//#define kHost @"127.0.0.1"
//#define Kport 6969

#define kUserName @"accountName"
#define kUserPassWard @"passWard"


#define kConversationTableName       @"t_conversation"  // 会话表
#define kFirendTableName             @"t_firend"        // 好友表
#define kNotificationTableName       @"t_notification"  // 通知表
#define kSessionTableName            @"t_session"       // 信息表

//#define kGroupTableName              @"t_grooup"        // 群表
//#define kGroupChatTableName          @"t_grooup_chat"   // 群聊天记录表
//#define kP2PTableName                @"t_P2P"           // 单聊表
//#define kP2PChatTableName            @"t_P2P_chat"      // 单聊聊天记录表

// 地图类型
typedef NS_ENUM(NSInteger, IMMapType) {
    IMMapBaidu = 1, // 百度
    IMMapGaode = 2  // 高德
};

// 地图类型
typedef NS_ENUM(NSInteger, IMConversationType) {
    IMConversationTypeP2P = 1,  // 私聊
    IMConversationTypeGroup = 2   // 群聊
};

// 消息类型
typedef NS_ENUM(NSInteger, IMCommandType) {
    IMCommandTypeNone         = 0,   //None
    IMCommandTypeChat         = 1,   //1:聊天
    IMCommandTypeNotification = 2,   //2:通知
    IMCommandTypeOrder        = 3,   //3:指令
    IMCommandTypeFeedback     = 4,   //4:反馈
    IMCommandResponse         = 6,   //6:响应
    IMCommandBroadcast        = 7    //7:广播
};

// 对话类型
typedef NS_ENUM(NSUInteger, IMChatType) {
    IMChatTypeNone                        = 0,  // None
    IMChatTypeText                        = 1,  // 文本聊天
    IMChatTypeVoice                       = 2,  // 语音
    IMChatTypePictore                     = 3,  // 图片
    IMChatTypeVideo                       = 4,  // 视频
    IMChatTypeFile                        = 5,  // 文件
    IMChatTypeInlinePicture               = 6,  // 内嵌图片
    IMChatTypeLoction                     = 7,  // 位置
    IMChatTypeVideoSession                = 8,  // 视频会话
    IMChatTypeAudioSession                = 9,  // 音频会话
    IMChatTypeLive                        = 10, // 直播
    IMChatTypeEvent                       = 11, // 事件
    IMChatTypeIntercom                    = 12, // 对讲
    IMChatTypeDrawingBoard                = 13, // 画板
    IMChatTypeAlarm                       = 14  // 报警
};

/** 信息类型 */
typedef NS_ENUM(NSUInteger, IMMessageType) {
    IMMessageTypeText,  // 文字
    IMMessageTypeSound, // 语音
    IMMessageTypeLocation, // 地址
    IMMessageTypeFile,  // 文件
    IMMessageTypePicture, // 图片
    IMMessageTypeVideo, // 短视频
    IMMessageTypeVideoSession, // 视频会话
    IMMessageTypeAudioSession // 语音会话
};

/** 通知类型  */
typedef NS_ENUM(NSInteger, IMNotificationType){
    // None
    IMNotificationTypeNone                = 0,
    // 其它设备登录通知
    IMNotificationTypeStateOtherLogin     = 1,
    // 状态响应
    IMNotificationTypeStateRespond        = 2,
    // 上线通知
    IMNotificationTypeOnline              = 3,
    // 离线通知
    IMNotificationTypeOffline             = 4,
    // 被接受好友申请
    IMNotificationTypeAcceptFriend        = 21,
    // 被拒绝好友申请
    IMNotificationTypeRejectFriend        = 22,
    // 收到好友申请
    IMNotificationTypeApplyFriend         = 23,
    // 被好友删除
    IMNotificationTypeRemoveFriend        = 24,
    // 被接受加群申请
    IMNotificationTypeAcceptGroup         = 41,
    // 被拒绝加群申请
    IMNotificationTypeRejectGroup         = 42,
    // 被邀请入群
    IMNotificationTypeInviteGroup         = 43,
    // 被移除出群
    IMNotificationTypeSelfKickOutGroup    = 44,
    // 入群通知(注：本通知针对群组内所有成员，因此将会发给群组对应的主题。)
    IMNotificationTypeJoinGroup           = 45,
    // 群解散通知（注：本通知针对群组内所有成员，因此将会发给群组对应的主题。）
    IMNotificationTypeDissolution         = 48,
    // 群主收到加群申请(注：后期若有管理员，则管理员也将收到本通知。)
    IMNotificationTypeManagerBegJoinGroup = 49,
    // 群主收到离群通知（注：后期若有管理员，则管理员也将收到本通知。）
    IMNotificationTypeLeaveGroup          = 50,
    // 群主收到被接受的加群请求结果（注：后期若有管理员，则管理员也将收到本通知。）
    IMNotificationTypeManagerAcceptGroup  = 51,
    // 群主收到被拒绝的加群请求结果（注：后期若有管理员，则管理员也将收到本通知。）
    IMNotificationTypeManagerRejectGroup  = 52,
    // 群主收到被移除出群通知(注：后期若有管理员，则管理员也将收到本通知。)
    IMNotificationTypeManagerKickOutGroup = 54
};

// 会话指令类型
typedef NS_ENUM(NSInteger, IMDirectiveType) {
    IMDirectiveTypeNone           = 0,     //None
    IMDirectiveTypeTakePhoto      = 1,     //1:拍照
    IMDirectiveTypeVideoRecord    = 2,     //2:录像
    IMDirectiveTypeLive           = 3,     //3:直播
    IMDirectiveTypeDeviceState    = 4,     //4:状态(设备状态)
    IMDirectiveTypeNavigation     = 5,     //5:预约导航
    IMDirectiveTypeUploadLog      = 6,     //6:上报日志
    IMDirectiveTypeUploadLoction  = 7,     //7:上报位置
    IMDirectiveTypeVideoSession   = 8,     //8:视频会话
    IMDirectiveTypeAudioSession   = 9,     //9:音频会话
    IMDirectiveTypeNetvoice       = 10,    //10:语音对讲
    IMDirectiveTypeSessionControl = 11,     //11:会话控制
    IMDirectiveTypeFileList       = 12,     //12:查询文件列表
    IMDirectiveTypeGetFile        = 13,     //13.获取文件，设备上传到ftp服务器
    IMDirectiveTypeDeviceCameraControl  = 14,    //14:摄像头控制
    IMDirectiveTypeSip            = 15,     //15.sip指令
};

// 指令操作类型
typedef NS_ENUM(NSInteger, IMDirectiveActionType) {
    IMDirectiveActionTypeNone         = 0,
    IMDirectiveActionTypeMessage      = 1,     // 所有信息
    SIMDirectiveActionTypeOnLine      = 2,     // 在线状态
    IMDirectiveActionTypeLocation     = 3      // 位置
};

// 媒体接收操作
typedef NS_ENUM(NSInteger, IMCallStatus) {
    IMCallNone   = 0,
    IMCallCancel = 1, //已取消
    IMCallReject = 2, //已拒绝
    IMCallAnswer = 3  //已接听
};

// 媒体会话类型
typedef NS_ENUM(NSInteger, IMMediaType) {
    IMMediaTypeVideo         = 1, //视频
    IMMediaTypeVideoIM       = 2, //视频+IM+视频
    IMMediaTypeDrawingBoard  = 3, //视频+IM+画板
    IMMediaTypeProfessional  = 4  //视频+全景+画板
};

// 接入SDK类型
typedef NS_ENUM(NSInteger, IMMediaSDKType) {
    IMMediaSDKTypeSIP         = 0, //视频
    IMMediaSDKTypeAgora       = 1, //视频
};

// 操作类型
typedef NS_ENUM(NSUInteger, IMMediaActionType){
    IMMediaActionTypeNone = 0, // None
    IMMediaActionTypekeep = 1,  // 保持会话
    IMMediaActionTypeEnd  = 2   // 终止会话
};

// 对讲类型
typedef NS_ENUM(NSUInteger, IMTalkbackType){
    IMTalkbackTypeNOUI = 1,  // 没有UI
    IMTalkbackTypeUI  = 2   // 有UI
};

// 画笔类型
typedef NS_ENUM(NSInteger, IMDrawBoardActionType) {
    IMDrawBoardActionTypeBrushes = 1, // 画笔
    IMDrawBoardActionTypeEraser  = 2  // 橡皮擦
};

// 画笔操作
typedef NS_ENUM(NSInteger, IMDrawBoardOrderType) {
    IMDrawBoardOrderTypeBrushes  = 1, // 画笔
    IMDrawBoardOrderTypeRepeal   = 2, // 撤销
    IMDrawBoardOrderTyperRecover  = 3, // 恢复
    IMDrawBoardOrderTypeClear    = 4  // 清屏
};

static NSString * const KuserMessageListTopic =             @"im/api/v1/message/user/list";
static NSString * const KuserAccountSearchTopic =           @"im/api/v1/search";
static NSString * const KgroupMessageListTopic =            @"im/api/v1/message/group/list";
static NSString * const KfriendsListTopic =                 @"im/api/v1/user/friend/list";
static NSString * const KremoveFriendTopic =                @"im/api/v1/user/friend/delete";
static NSString * const KaddFriendTopic =                   @"im/api/v1/user/friend/request";
static NSString * const KacceptOrRejectFriendTopic =        @"im/api/v1/user/friend/response";
static NSString * const KgroupersListTopic =                @"im/api/v1/user/group/list";
static NSString * const KquitGroupTopic =                   @"im/api/v1/user/group/delete";
static NSString * const KaddGroupTopic =                    @"im/api/v1/user/group/request";
static NSString * const KacceptOrRejectGroupApplyTopic =    @"im/api/v1/user/group/response";
static NSString * const KcreateGroupTopic =                 @"im/api/v1/group/create";
static NSString * const KdeleteGroupTopic =                 @"im/api/v1/group/delete";
static NSString * const KaddGroupMemberTopic =              @"im/api/v1/group/member/create";
static NSString * const KdeleteGroupMemberTopic =           @"im/api/v1/group/member/delete";
static NSString * const KgroupMemberListTopic =             @"im/api/v1/group/member/list";

#endif /* Project_Macro_h */
