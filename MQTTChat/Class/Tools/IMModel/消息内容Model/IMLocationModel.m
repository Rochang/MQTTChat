//
//  IMLocationModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMLocationModel.h"

@implementation IMLocationModel

+ (instancetype)locationWithLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address coordType:(IMMapType)coordType thumbnailImage:(IMThumbnailModel *)thumbnailImage {
    if(latitude == 0 || longitude == 0) return nil;
    IMLocationModel *location = [[IMLocationModel alloc] init];
    location.latitude = @(latitude);
    location.longitude = @(longitude);
    location.address = address;
    location.maptype = coordType;
    location.thumbnail = thumbnailImage;
    return location;
}

@end
