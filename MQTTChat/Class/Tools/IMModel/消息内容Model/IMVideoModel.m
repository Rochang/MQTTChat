//
//  IMVideoModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMVideoModel.h"

@implementation IMVideoModel

+ (instancetype)videoWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath remotePath:(NSString *)remotePath thumbnail:(IMThumbnailModel *)thumbnail {
    IMVideoModel *video = [[IMVideoModel alloc] init];
    video.suffix = suffix;
    video.url = url;
    if(nativePath) {
        video.nativePath = nativePath;
        long long duration = [IMTools voiceDuration:nativePath];
        video.duration = @(duration);
        CGSize videoFrame = [IMTools videoSizeWithSourcePath:nativePath];
        video.width = @(videoFrame.width);
        video.height = @(videoFrame.height);
        NSUInteger videoSize = [IMTools fileSizeAtPath:nativePath];
        video.size = @(videoSize);
    }
    video.thumbnail = thumbnail;
    return video;
}

- (instancetype)initWithBackdatedTime:(NSInteger)backdatedTime validTime:(NSInteger)validTime {
    if (self = [super init]) {
        _backdated_time = [NSNumber numberWithInteger:backdatedTime];
        _valid_time = [NSNumber numberWithInteger:validTime];
    }
    return self;
}

@end
