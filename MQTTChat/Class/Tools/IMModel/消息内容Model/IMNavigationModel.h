//
//  IMNavigationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 导航
@interface IMNavigationModel : NSObject
// 纬度
@property (nonatomic, strong) NSNumber *latitude;
// 经度度
@property (nonatomic, strong) NSNumber *longitude;
// 坐标类型
@property (nonatomic, assign) IMMapType mapType;
// 导航类型；1立即导航，2延时导航
@property (nonatomic, strong)NSNumber *navigation_type;
// 延时时间；单位：毫秒；导航类型为2时必传(
@property (nonatomic, strong) NSNumber *navigation_time;
// 详细地址
@property (nonatomic, copy) NSString *address;

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                       coordType:(IMMapType)mapType
                  navigationType:(NSInteger)navigationType
                  navigationTime:(NSInteger)navigationTime
                         address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
