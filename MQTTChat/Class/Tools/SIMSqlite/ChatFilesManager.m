//
//  ChatFilesManager.m
//  SIMIMSDK_Example
//
//  Created by 罗函 on 2017/10/13.
//  Copyright © 2017年 LuohanCC. All rights reserved.
//

#import "ChatFilesManager.h"
#import "ChatFMDBBase.h"

static const NSString *tag = @"ChatFilesManager";

@implementation ChatFilesManager

+ (NSString *)sandboxDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


/**
 在沙盒下创建文件夹

 @param path 用户的Imid作为上一级文件夹(可传空)
 @param directoryName 文件夹名字
 @return YES:创建成功;NO:文件夹已存在或创建失败
 */
+ (BOOL)createDirectoryWithPath:(NSString *)path directoryName:(NSString *)directoryName {
    if(!directoryName || directoryName.length == 0) return NO;
    NSString *display = nil;
    NSString *createPath = [ChatFilesManager sandboxDir];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if(path && path.length > 0) {
        createPath = [createPath stringByAppendingPathComponent:path];
    }
    createPath = [createPath stringByAppendingPathComponent:directoryName];
    if (![fileManager fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        display = [NSString stringWithFormat:@"%@创建成功", path];
        return YES;
    } else {
        display = [NSString stringWithFormat:@"%@已经存在", path];
        return NO;
    }
    ChatLog(tag, display);
}

/**
 检查文件是否存在

 @param path 文件路径
 @param fileName 文件名称
 @return 存在/不存在/错误
 */
+ (BOOL)checkFileIsExistsInSandbox:(NSString *)path fileName:(NSString *)fileName {
    if(!path && !fileName) return NO;
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}
@end
