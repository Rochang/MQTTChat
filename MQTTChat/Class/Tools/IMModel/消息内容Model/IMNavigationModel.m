//
//  IMNavigationModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMNavigationModel.h"

@implementation IMNavigationModel

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                       coordType:(IMMapType)mapType
                  navigationType:(NSInteger)navigationType
                  navigationTime:(NSInteger)navigationTime
                         address:(NSString *)address {
    if (self = [super init]) {
        if(latitude != 0.0 && longitude != 0.0) {
            _latitude = [NSNumber numberWithDouble:latitude];
            _longitude = [NSNumber numberWithDouble:longitude];
        }
        _mapType = mapType;
        _navigation_type = [NSNumber numberWithInteger:navigationType];
        _navigation_time = [NSNumber numberWithDouble:navigationTime];
        _address = address;
    }
    return self;
}

@end
