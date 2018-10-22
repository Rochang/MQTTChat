//
//  IMFileModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMFileModel.h"

@implementation IMFileModel

+ (instancetype)fileWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url fileName:(NSString *)fileName {
    if(!nativePath) return nil;
    IMFileModel *file = [IMFileModel new];
    file.suffix = suffix;
    file.url = url;
    file.fileName = fileName;
    if(nativePath) {
        file.nativePath = nativePath;
        long long fileSize = [IMTools fileSizeAtPath:nativePath];
        file.size = @(fileSize);
    }
    return file;
}

@end
