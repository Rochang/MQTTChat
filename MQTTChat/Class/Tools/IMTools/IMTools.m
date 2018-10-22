//
//  IMTools.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//  项目用到的Id

#import "IMTools.h"
#import <AVFoundation/AVFoundation.h>

@implementation IMTools

+ (NSString *)userId {
    return [LCMethod UD_getObjectForKey:kUserName];
}

+ (NSString *)clientId {
    return [NSString stringWithFormat:@"[2]_[%@]_[%@]_[%@]", @"com.sly.simsdk", [NSString getUUID], [self userId]];
}

+ (NSString *)userTopic {
    return [NSString stringWithFormat:@"im/user/%@",[self userId]];
}

+ (NSString *)systemNotificationTopic {
    return [NSString stringWithFormat:@"im/notification/#"];
}

+ (NSString *)grouperTopicWithGroupId:(NSString *)groupId {
    return [NSString stringWithFormat:@"im/group/%@", groupId];
}

+ (NSString *)groupeManagerTopic {
    return [NSString stringWithFormat:@"im/group/%@/notification/management", [self userId]];
}

+ (NSString *)broadcastTopic {
    return [NSString stringWithFormat:@"im/user/%@/broadcast", [self userId]];
}

+ (NSString *)showTime:(NSTimeInterval)msglastTime showDetail:(BOOL)showDetail {
    //今天的时间
    NSDate * nowDate = [NSDate date];
    NSDate * msgDate = [NSDate dateWithTimeIntervalSince1970:msglastTime];
    NSString *result = nil;
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *nowDateComponents = [[NSCalendar currentCalendar] components:components fromDate:nowDate];
    NSDateComponents *msgDateComponents = [[NSCalendar currentCalendar] components:components fromDate:msgDate];
    
    NSInteger hour = msgDateComponents.hour;
    double OnedayTimeIntervalValue = 24*60*60;  // 一天的秒数
    
    result = @"";
    if(nowDateComponents.day == msgDateComponents.day) //同一天,显示时间
    {
        result = [[NSString alloc] initWithFormat:@"%zd:%02d",hour,(int)msgDateComponents.minute];
    }
    else if(nowDateComponents.day == (msgDateComponents.day+1))//昨天
    {
        result = showDetail?  [[NSString alloc] initWithFormat:@"昨天 %zd:%02d",hour,(int)msgDateComponents.minute] : @"昨天";
    }
    else if(nowDateComponents.day == (msgDateComponents.day+2)) //前天
    {
        result = showDetail? [[NSString alloc] initWithFormat:@"前天 %zd:%02d",hour,(int)msgDateComponents.minute] : @"前天";
    }
    else if([nowDate timeIntervalSinceDate:msgDate] < 7 * OnedayTimeIntervalValue)//一周内
    {
        NSString *weekDay = [self weekdayStr:msgDateComponents.weekday];
        result = showDetail? [weekDay stringByAppendingFormat:@"%zd:%02d",hour,(int)msgDateComponents.minute] : weekDay;
    }
    else//显示日期
    {
        NSString *day = [NSString stringWithFormat:@"%zd-%zd-%zd", msgDateComponents.year, msgDateComponents.month, msgDateComponents.day];
        result = showDetail? [day stringByAppendingFormat:@"%zd:%02d",hour,(int)msgDateComponents.minute]:day;
    }
    return result;
    
}
#pragma mark - Private

+ (NSString *)getPeriodOfTime:(NSInteger)time withMinute:(NSInteger)minute
{
    NSInteger totalMin = time *60 + minute;
    NSString *showPeriodOfTime = @"";
    if (totalMin > 0 && totalMin <= 5 * 60)
    {
        showPeriodOfTime = @"凌晨";
    }
    else if (totalMin > 5 * 60 && totalMin < 12 * 60)
    {
        showPeriodOfTime = @"上午";
    }
    else if (totalMin >= 12 * 60 && totalMin <= 18 * 60)
    {
        showPeriodOfTime = @"下午";
    }
    else if ((totalMin > 18 * 60 && totalMin <= (23 * 60 + 59)) || totalMin == 0)
    {
        showPeriodOfTime = @"晚上";
    }
    return showPeriodOfTime;
}

+ (NSString*)weekdayStr:(NSInteger)dayOfWeek {
    static NSDictionary *daysOfWeekDict = nil;
    daysOfWeekDict = @{@(1):@"星期日",
                       @(2):@"星期一",
                       @(3):@"星期二",
                       @(4):@"星期三",
                       @(5):@"星期四",
                       @(6):@"星期五",
                       @(7):@"星期六",};
    return [daysOfWeekDict objectForKey:@(dayOfWeek)];
}


+ (long long)fileSizeAtPath:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    return 0;
}

+ (NSUInteger)voiceDuration:(NSString *)filePath {
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds * 1000;//毫秒
}

+ (CGSize)videoSizeWithSourcePath:(NSString *)filePath {
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:filePath]];
    NSArray *array = asset.tracks;
    CGSize videoSize = CGSizeZero;
    for (AVAssetTrack *track in array) {
        if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
            videoSize = track.naturalSize;
        }
    }
    return videoSize;
}
@end
