//
//  IMNotificationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 通知详情 */
@interface IMDetailModel : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *group_id;
@property (nonatomic,copy) NSString *client_id;

@end

@interface IMNotificationModel : NSObject

@property (nonatomic, assign) IMNotificationType type;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) IMDetailModel *detail;

@end

NS_ASSUME_NONNULL_END
