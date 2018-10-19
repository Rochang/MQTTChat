//
//  IMPresentationController.h
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//  自定义modal 动画

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMPresentationController : UIPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
