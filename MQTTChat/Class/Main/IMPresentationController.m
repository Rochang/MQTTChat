//
//  IMPresentationController.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMPresentationController.h"

@interface IMPresentationController ()

@property (nonatomic, strong) UIVisualEffectView *maskView;
@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation IMPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    return [self initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController height:300];
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController height:(CGFloat)height {
    self =  [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    self.viewHeight = height;
    return self;
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    self.presentedView.frame = CGRectMake(0, KScreen_H-self.viewHeight, KScreen_W, self.viewHeight);
    UIBlurEffect *blur  = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _maskView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _maskView.frame = self.containerView.bounds;
    _maskView.alpha = 0.f;
    _maskView.backgroundColor = [UIColor blackColor];
    [self.containerView insertSubview:_maskView atIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick:)];
    [_maskView addGestureRecognizer:tap];
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.6f;
    }];
}

#pragma mark - override
- (void)presentationTransitionWillBegin {
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if(!completed) [_maskView removeFromSuperview];
}

- (void)dismissalTransitionWillBegin {
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.f;
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if(completed) [_maskView removeFromSuperview];
}

- (CGRect)frameOfPresentedViewInContainerView {
    self.presentedView.frame = CGRectMake(0, KScreen_H - 300, KScreen_W, 300);
    return self.presentedView.frame;
}

- (void)maskViewClick:(UITapGestureRecognizer *)tap {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
