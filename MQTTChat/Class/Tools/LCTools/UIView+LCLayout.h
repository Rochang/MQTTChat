//
//  UIView+LCLayout.h
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView *(^layoutValueBlock)(CGFloat value);
typedef UIView *(^layoutEdgeBlock)(UIEdgeInsets edge);
typedef UIView *(^layoutPointBlock)(CGPoint point);
typedef UIView *(^layoutSizeBlock)(CGSize size);


@interface UIView (LCLayout)

#pragma mark - setter / getter
@property (assign, nonatomic) CGFloat x_gs;
@property (assign, nonatomic) CGFloat y_gs;
@property (assign, nonatomic) CGFloat width_gs;
@property (assign, nonatomic) CGFloat height_gs;

@property (assign, nonatomic) CGFloat top_gs;
@property (assign, nonatomic) CGFloat bottom_gs;
@property (assign, nonatomic) CGFloat left_gs;
@property (assign, nonatomic) CGFloat right_gs;

@property (assign, nonatomic) CGFloat centerX_gs;
@property (assign, nonatomic) CGFloat centerY_gs;
@property (assign, nonatomic) CGSize size_gs;
@property (assign, nonatomic) CGPoint orgin_gs;

- (void)addSubViews_lc:(NSArray <UIView *>*)subViews;

#pragma mark - 链式

- (layoutValueBlock)x_lc;
- (layoutValueBlock)y_lc;
- (layoutValueBlock)width_lc;
- (layoutValueBlock)height_lc;

- (layoutValueBlock)top_lc;
- (layoutValueBlock)bottom_lc;
- (layoutValueBlock)left_lc;
- (layoutValueBlock)right_lc;

- (layoutPointBlock)center_lc;
- (layoutValueBlock)centerX_lc;
- (layoutValueBlock)centerY_lc;
- (layoutSizeBlock)size_lc;

/** 跟父控件的edge,传入UIEdgeInsets */
- (layoutEdgeBlock)edge_lc;

@end
