//
//  IMNotificationManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/23.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMNotificationManager.h"

@interface IMNotificationManager ()

@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation IMNotificationManager

- (void)notification:(IMModel *)model {
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    if (state == UIApplicationStateBackground) {
        [self doLocalNotifitionWithMessage:model.disPlayMessage params:nil];
    }
    if(self.isPlaying) return;
    // 去除铃响
    //    AudioServicesPlaySystemSound(1312);
    self.isPlaying = YES;
    [self performSelector:@selector(canPlay) withObject:nil afterDelay:0.5];
}

- (void)canPlay {
    self.isPlaying  = NO;
}

- (void)doLocalNotifitionWithMessage:(NSString *)message params:(NSDictionary *)params{
    //初始化一个 UILocalNotification
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    NSDate * pushDate = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    if (notification!=nil) {
        //设置 推送时间
        notification.fireDate= pushDate;
        //设置 时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        //设置 重复间隔
        notification.repeatInterval = 0;
        //设置 推送 时间
        notification.soundName = UILocalNotificationDefaultSoundName;
        //设置 推送提示语
        notification.alertBody = message;
        //设置 icon 上 红色数字
        //            notification.applicationIconBadgeNumber = 1;
        notification.userInfo = params;
        //添加推送到 Application
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    NSLog(@"开启本地通知");
}

@end
