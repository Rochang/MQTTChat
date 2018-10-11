//
//  IMSourceManager.h
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMSourceManager : IMBaseManager

/** 上传文件 */
- (void)upLoadFile;

/** 下载文件 */
- (void)downLoadFile;

@end

NS_ASSUME_NONNULL_END
