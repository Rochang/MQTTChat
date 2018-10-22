//
//  IMVideoModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"
#import "IMThumbnailModel.h"

NS_ASSUME_NONNULL_BEGIN
// 视频
@interface IMVideoModel : IMChatContentModel

@property(nonatomic, strong) NSNumber *width; // 宽
@property(nonatomic, strong) NSNumber *height; // 高
@property(nonatomic, strong) NSNumber *duration; // 时长；单位：毫秒
@property(nonatomic, strong) IMThumbnailModel *thumbnail; // 缩略图信息
@property(nonatomic, strong) NSNumber *backdated_time; // 回溯时长；单位：毫秒
@property(nonatomic, strong) NSNumber *valid_time; // 有效时长；单位：毫秒


+ (instancetype)videoWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath remotePath:(NSString *)remotePath thumbnail:(IMThumbnailModel *)thumbnail;

- (instancetype)initWithBackdatedTime:(NSInteger)backdatedTime validTime:(NSInteger)validTime;

@end

NS_ASSUME_NONNULL_END
