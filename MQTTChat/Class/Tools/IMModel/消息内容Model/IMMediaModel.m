//
//  IMMediaModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMediaModel.h"

@implementation IMMediaModel

+ (instancetype)mediaWithSDKType:(IMMediaSDKType)SDKType actionType:(IMMediaActionType)actionType callStatus:(IMCallStatus)callStatus duration:(NSNumber *)duration {
    IMMediaModel *model = [[IMMediaModel alloc] init];
    model.SDKType = SDKType;
    model.actionType = actionType;
    model.callStatus = callStatus;
    model.duration = duration;
    return model;
}

@end
