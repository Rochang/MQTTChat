//
//  IMChatContentModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatContentModel.h"

@implementation IMChatContentModel

- (void)setFileStatus:(IMChatFIileStatus)fileStatus {
    _fileStatus = fileStatus;
    if (fileStatus == IMChatFIleDownloadrSuccess) {
        _loadProgress = 1;
    }
    else if (fileStatus == IMChatFIleDownloadFail) {
        _loadProgress = 0;
    }
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

- (void)setLoadProgress:(CGFloat)loadProgress {
    _loadProgress = loadProgress;
    _fileStatus = loadProgress >= 1 ? IMChatFIleDownloadrSuccess : IMChatFIleDownloading;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    _loadProgress = 1;
    _fileStatus = IMChatFIleDownloadrSuccess;
}

@end
