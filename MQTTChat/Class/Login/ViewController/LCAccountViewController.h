//
//  LCAccountViewController.h
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCAccountViewController : UIViewController

@property (nonatomic, copy) void (^callBackBlock)(LCAccountModel *model);

@end

NS_ASSUME_NONNULL_END
