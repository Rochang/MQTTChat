//
//  ChatFilesManager.h
//  SIMIMSDK_Example
//
//  Created by 罗函 on 2017/10/13.
//  Copyright © 2017年 LuohanCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatFilesManager : NSObject
+ (NSString *)sandboxDir;
+ (BOOL)createDirectoryWithPath:(NSString *)path directoryName:(NSString *)directoryName;
+ (BOOL)checkFileIsExistsInSandbox:(NSString *)path fileName:(NSString *)fileName;

@end
