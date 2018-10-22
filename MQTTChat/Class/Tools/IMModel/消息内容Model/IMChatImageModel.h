//
//  IMChatImageModel.h
//  MQTTChat
//
//  Created by Rochang on 2018/10/22.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMThumbnail : NSObject

@property(nonatomic, copy)NSString *suffix; // 后缀
@property(nonatomic, copy)NSString *url; // 地址
@property(nonatomic, strong)NSNumber *width; // 宽
@property(nonatomic, strong)NSNumber *height; // 高
@property(nonatomic, strong)NSNumber *size; // 大小；单位：字节
@property(nonatomic, strong)NSString *nativePath;
+ (instancetype)thumbnailWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath;

@end

@interface IMChatImageModel : IMChatContentModel

@property(nonatomic, strong)NSNumber *width; // 宽
@property(nonatomic, strong)NSNumber *height; // 高
@property(nonatomic, strong)IMThumbnail *thumbnail; //缩略图信息

- (instancetype)initWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url thumbnail:(IMThumbnail *)thumbnail;

@end

NS_ASSUME_NONNULL_END
