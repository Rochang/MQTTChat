//
//  IMChatImageModel.m
//  MQTTChat
//
//  Created by Rochang on 2018/10/22.
//  Copyright © 2018 Rochang. All rights reserved.
//

#import "IMChatImageModel.h"

@implementation IMThumbnail

+ (instancetype)thumbnailWithSuffix:(NSString *)suffix url:(NSString *)url nativePath:(NSString *)nativePath {
    IMThumbnail *thumbnail = [[IMThumbnail alloc] init];
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

- (NSString *)nativePath {
    if(!_nativePath) return nil;
    NSString *path = _nativePath.copy;
#ifdef DEBUG
    NSString *fileDirPath = nil;
    NSString *separateString = nil;
    NSArray *pathArray = nil;
    if([path containsString:@"Documents/"]) {
        separateString = @"Documents/";
        fileDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }else if([path containsString:@"Library/"]) {
        separateString = @"Library/";
        fileDirPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }else if([path containsString:@"tmp/"]) {
        separateString = @"tmp/";
        fileDirPath = NSTemporaryDirectory();
    }
    if(separateString) {
        pathArray = [path componentsSeparatedByString:separateString];
        if(pathArray && pathArray.count >= 2) {
            path = pathArray.lastObject;
            path = [NSString stringWithFormat:@"%@/%@", fileDirPath, path];
        }
    }
#else
    
#endif
    return path;
}

@end

@implementation IMChatImageModel

- (instancetype)initWithSuffix:(NSString *)suffix nativePath:(NSString *)nativePath url:(NSString *)url thumbnail:(IMThumbnail *)thumbnail {
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
