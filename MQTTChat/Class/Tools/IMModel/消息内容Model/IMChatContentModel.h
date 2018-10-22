//
//  IMChatContentModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//  会话内容Mdoel

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IMChatFIileStatus) {
    IMChatFileDownloadNone     = 0,  // 文件未下载
    IMChatFIleDownloading      = 1,  // 下载中
    IMChatFIleDownloadrSuccess  = 2,  // 下载成功
    IMChatFIleDownloadFail      = 3  // 下载失败
};

@interface IMChatContentModel : NSObject

@property (nonatomic, copy) NSString *url; // 远程地址
@property (nonatomic, copy) NSString *nativePath; // 本地地址
@property (nonatomic, copy) NSString *suffix; // 后缀
@property (nonatomic, strong) NSNumber *size; // 大小；单位：字节
@property (nonatomic, assign) IMChatFIileStatus fileStatus; // 状态
@property (nonatomic, assign) CGFloat loadProgress; // 进度

- (void)setCustomStringIsEmpty;

@end


NS_ASSUME_NONNULL_END
