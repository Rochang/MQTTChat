//
//  IMThumbnailModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMThumbnailModel.h"

@implementation IMThumbnailModel

+ (instancetype)thumbnailWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath {
    IMThumbnailModel *thumbnail = [[IMThumbnailModel alloc] init];
    thumbnail.suffix = suffix;
    thumbnail.url = url;
    if(nativePath) {
        thumbnail.nativePath = nativePath;
        long long fileSize = [IMTools fileSizeAtPath:nativePath];
        thumbnail.size = [NSNumber numberWithLongLong:fileSize];
        UIImage *image = [UIImage imageWithContentsOfFile:nativePath];
        if (image) {
            thumbnail.width = @(image.size.width * image.scale);
            thumbnail.height = @(image.size.height * image.scale);
        } else {
            thumbnail.width = @(0);
            thumbnail.height = @(0);
            
        }
    }
    return thumbnail;
}

@end
