//
//  UIView+LCLayout.m
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import "UIView+LCLayout.h"

@implementation UIView (LCLayout)

#pragma mark - setter / getter
- (CGFloat)x_gs {
    return self.frame.origin.x;
}

- (void)setX_gs:(CGFloat)x_gs {
    CGRect frame = self.frame;
    frame.origin.x = x_gs;
    self.frame = frame;
}

- (CGFloat)y_gs {
    return self.frame.origin.y;
}

- (void)setY_gs:(CGFloat)y_gs {
    CGRect frame = self.frame;
    frame.origin.y = y_gs;
    self.frame = frame;
}

- (CGFloat)width_gs {
    return self.frame.size.width;
}

- (void)setWidth_gs:(CGFloat)width_gs {
    CGRect frame = self.frame;
    frame.size.width = width_gs;
    self.frame = frame;
}

- (CGFloat)height_gs {
    return self.frame.size.height;
}

- (void)setHeight_gs:(CGFloat)height_gs {
    CGRect frame = self.frame;
    frame.size.height = height_gs;
    self.frame = frame;
}

- (CGFloat)left_gs {
    return self.x_gs;
}

- (void)setLeft_gs:(CGFloat)left_gs {
    self.x_gs = left_gs;
}

- (CGFloat)top_gs {
    return self.y_gs;
}

- (void)setTop_gs:(CGFloat)top_gs {
    self.y_gs = top_gs;
}

- (CGFloat)right_gs {
    return self.x_gs + self.width_gs;
}

- (void)setRight_gs:(CGFloat)right_gs {
    self.x_gs = right_gs - self.width_gs;
}

- (CGFloat)bottom_gs {
    return self.y_gs + self.height_gs;
}

- (void)setBottom_gs:(CGFloat)bottom_gs {
//    self.height_gs = bottom_gs - self.y_gs;
    self.y_gs = bottom_gs - self.height_gs;
}

- (CGFloat)centerX_gs {
    return self.center.x;
}

- (void)setCenterX_gs:(CGFloat)centerX_gs {
    CGPoint center = self.center;
    center.x = centerX_gs;
    self.center = center;
}

- (CGFloat)centerY_gs {
    return self.center.y;
}

- (void)setCenterY_gs:(CGFloat)centerY_gs {
    CGPoint center = self.center;
    center.y = centerY_gs;
    self.center = center;
}

- (CGSize)size_gs {
    return self.frame.size;
}

- (void)setSize_gs:(CGSize)size_gs {
    CGRect frame = self.frame;
    frame.size = size_gs;
    self.frame = frame;
}

- (CGPoint)orgin_gs {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (void)setOrgin_gs:(CGPoint)orgin_gs {
    CGRect frame = self.frame;
    frame.origin = orgin_gs;
    self.frame = frame;
}

- (void)addSubViews_lc:(NSArray<UIView *> *)subViews {
    if (subViews.count) {
        [subViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addSubview:obj];
        }];
    }
}

#pragma mark - 链式
- (layoutValueBlock)x_lc {
    return ^(CGFloat value){
        self.x_gs = value;
        return self;
    };
}

- (layoutValueBlock)y_lc {
    return ^(CGFloat value){
        self.y_gs = value;
        return self;
    };
}

- (layoutValueBlock)width_lc {
    return ^(CGFloat value){
        self.width_gs = value;
        return self;
    };
}

- (layoutValueBlock)height_lc {
    return ^(CGFloat value){
        self.height_gs = value;
        return self;
    };
}

- (layoutValueBlock)top_lc {
    return ^(CGFloat value){
        self.y_lc(value);
        return self;
    };
}

- (layoutValueBlock)bottom_lc {
    return ^(CGFloat value){
        self.height_gs = value - self.y_gs;
        return self;
    };
}

- (layoutValueBlock)left_lc {
    return ^(CGFloat value){
        self.x_lc(value);
        return self;
    };
}

- (layoutPointBlock)center_lc {
    return ^(CGPoint point) {
        self.center = point;
        return self;
    };
}

- (layoutSizeBlock)size_lc {
    return ^(CGSize size) {
        self.size_gs = size;
        return self;
    };
}

- (layoutValueBlock)centerX_lc {
    return ^(CGFloat value){
        self.center = CGPointMake(value, self.center.y);
        return self;
    };
}

- (layoutValueBlock)centerY_lc {
    return ^(CGFloat value){
        self.center = CGPointMake(self.center.x, value);
        return self;
    };
}

- (layoutValueBlock)right_lc {
    return ^(CGFloat value){
        self.width_gs = value - self.x_gs;
        return self;
    };
}

- (layoutEdgeBlock)edge_lc {
    return ^(UIEdgeInsets edge){
        self.top_gs = edge.top;
        self.left_gs = edge.left;
        self.bottom_gs = edge.bottom + self.superview.height_gs;
        self.right_gs = edge.right + self.superview.width_gs;
        return self;
    };
}

@end
