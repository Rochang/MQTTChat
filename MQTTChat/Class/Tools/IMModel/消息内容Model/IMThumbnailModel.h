//
//  IMThumbnailModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN
// 缩略图
@interface IMThumbnailModel : IMChatContentModel

@property(nonatomic, strong) NSNumber *width; // 宽
@property(nonatomic, strong) NSNumber *height; // 高

+ (instancetype)thumbnailWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath;

@end

NS_ASSUME_NONNULL_END
