//
//  IMLocationModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"
#import "IMThumbnailModel.h"

NS_ASSUME_NONNULL_BEGIN
// 位置
@interface IMLocationModel : IMChatContentModel

@property(nonatomic, strong) NSNumber *latitude; // 纬度
@property(nonatomic, strong) NSNumber *longitude; // 经度
@property(nonatomic, assign) IMMapType maptype; // 坐标类型
@property(nonatomic, copy) NSString *address; // 详细地址
@property(nonatomic, strong) IMThumbnailModel *thumbnail; // 缩略图信息

+ (instancetype)locationWithLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address coordType:(IMMapType)coordType thumbnailImage:(IMThumbnailModel *)thumbnailImage;

@end

NS_ASSUME_NONNULL_END
