//
//  IMFileModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMFileModel : IMChatContentModel

@property(nonatomic,copy)NSString *fileName; // 文件名

+ (instancetype)fileWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url fileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
