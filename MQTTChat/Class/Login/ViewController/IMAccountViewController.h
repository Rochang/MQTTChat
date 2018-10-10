//
//  IMAccountViewController.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMAccountViewController : UIViewController

@property (nonatomic, copy) void (^callBackBlock)(IMAccountModel *model);

@end

NS_ASSUME_NONNULL_END
