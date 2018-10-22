//
//  IMImageModel.h
//  MQTTChat
//
//  Created by Rochang on 2018/10/22.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"
#import "IMThumbnailModel.h"

NS_ASSUME_NONNULL_BEGIN
// 图片
@interface IMImageModel : IMChatContentModel

@property(nonatomic, strong)NSNumber *width; // 宽
@property(nonatomic, strong)NSNumber *height; // 高
@property(nonatomic, strong)IMThumbnailModel *thumbnail; //缩略图信息

- (instancetype)initWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url thumbnail:(IMThumbnailModel *)thumbnail;

@end

NS_ASSUME_NONNULL_END
