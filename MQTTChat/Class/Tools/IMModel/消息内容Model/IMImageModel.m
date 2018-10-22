//
//  IMImageModel.m
//  MQTTChat
//
//  Created by Rochang on 2018/10/22.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMImageModel.h"

@implementation IMImageModel

- (instancetype)initWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url thumbnail:(IMThumbnailModel *)thumbnail {
    if (self = [super init]) {
        self.suffix = suffix;
        self.url = url;
        _thumbnail = thumbnail;
        if(nativePath && nativePath.length > 0) {
            self.nativePath = nativePath;
            long long fileSize = [IMTools fileSizeAtPath:nativePath];
            self.size = [NSNumber numberWithLongLong:fileSize];
            UIImage *image = [UIImage imageWithContentsOfFile:nativePath];
            if(image) {
                _width = @(image.size.width);
                _height = @(image.size.height);
            }
        }
    }
    return self;
}

@end
