//
//  IMTalkbackModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMediaModel.h"

NS_ASSUME_NONNULL_BEGIN
// 对讲
@interface IMTalkbackModel : IMMediaModel

// 类型;1为仅对讲,2为带聊天界面的对讲;带聊天界面对讲需要自定义UI
@property (nonatomic, assign) IMTalkbackType talkBackType;

@end

NS_ASSUME_NONNULL_END
