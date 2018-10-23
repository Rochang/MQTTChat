//
//  ChatFileConfig.h
//  SIMIMSDK
//
//  Created by 罗函 on 2017/11/30.
//
#import "SIMIMSDK.h"

#ifndef ChatFileConfig_h
#define ChatFileConfig_h

// 沙盒路径
#define SandBoxPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Im路径
#define ImDataPath [SandBoxPath stringByAppendingPathComponent:@"imData"]
// Im文件路径
#define IMResourcePath [ImDataPath stringByAppendingPathComponent:SIMIMSDK_SHARE.currentUserId]
// 语音所在路径
#define IM_RecordChat_Dir [ImDataPath stringByAppendingPathComponent:@"record"]
// 文件所在路径
#define IM_Office_Dir [ImDataPath stringByAppendingPathComponent:@"office"]
#endif /* ChatFileConfig_h */
