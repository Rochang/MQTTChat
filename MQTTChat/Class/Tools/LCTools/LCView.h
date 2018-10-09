//
//  LCView.h
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^actionBlock)(id sender);

@interface LCView : NSObject

#pragma mark - UIView
+ (UIView *)viewWithFrame:(CGRect)frame backColor:(UIColor *)backColor;

#pragma mark - UIButton
/** 多项 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   titleColor:(UIColor *)titleColor
                selTitleColor:(UIColor *)selTitleColor
                    backColor:(UIColor *)backColor
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                      bgImage:(UIImage *)bgImage
                   bgSelImage:(UIImage *)bgsSelImage
                        title:(NSString *)title
                     selTitle:(NSString *)selTitle
                     fontSize:(CGFloat)fontSize
                       action:(actionBlock)action
                       target:(id)target
                          sel:(SEL)sel;


/** 文字 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   titleColor:(UIColor *)titleColor
                selTitleColor:(UIColor *)selTitleColor
                    backColor:(UIColor *)backColor
                        title:(NSString *)title
                     selTitle:(NSString *)selTitle
                     fontSize:(CGFloat)fontSize
                       action:(actionBlock)action;

/** 图片 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                       action:(actionBlock)action;

/** 背景图片 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                   bgSelImage:(UIImage *)bgsSelImage
                       action:(actionBlock)action;

/** 文字 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   titleColor:(UIColor *)titleColor
                selTitleColor:(UIColor *)selTitleColor
                    backColor:(UIColor *)backColor
                        title:(NSString *)title
                     selTitle:(NSString *)selTitle
                     fontSize:(CGFloat)fontSize
                       target:(id)target
                        action:(SEL)action;

/** 图片 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                       target:(id)target
                       action:(SEL)action;

/** 背景图片 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                   bgSelImage:(UIImage *)bgsSelImage
                       target:(id)target
                       action:(SEL)action;


#pragma mark - UIlabel
/** 多项 */
+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor textAlignment:(NSTextAlignment)textAlignment lineNumber:(NSInteger)number text:(NSString *)text fontSize:(CGFloat)fontSize;

/** 简单 */
+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor text:(NSString *)text fontSize:(CGFloat)fontSize;

/** no frame */
+ (UILabel *)labelWithTextColor:(UIColor *)textColor backColor:(UIColor *)backColor numberOfLines:(NSInteger)number fontSize:(CGFloat)fontSize text:(NSString *)text;

#pragma mark - Tableview
/** tableView 多项 */
+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate showHorizontal:(BOOL)showH showVertical:(BOOL)showV backColor:(UIColor *)backColor footerView:(UIView *)footerView;

/** tableView 简单 */
+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate;

/** no frame */
+ (UITableView *)tableViewWithDataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate;

#pragma mark - UIScrollview
/** 多项 */
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegete showsHorizontal:(BOOL)horizontal showVertical:(BOOL)vertical pagingEnable:(BOOL)page bounces:(BOOL)bounces backColor:(UIColor *)backColor;

/** 简单 */
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegete;

#pragma mark - UICollectView
/** 多项 */
+ (UICollectionView *)collectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout direction:(UICollectionViewScrollDirection)direction minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource showHorizontal:(BOOL)showH showVertical:(BOOL)showV pagingEnabled:(BOOL)page backColor:(UIColor *)color;

/** 简单 */
+ (UICollectionView *)collectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource backColor:(UIColor *)color;

/** no frame */
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource backColor:(UIColor *)color;

#pragma mark - UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)image;
+ (UIImageView *)imageViewWithImage:(NSString *)image;

#pragma mark - UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame backColor:(UIColor *)backColor placeTitle:(NSString *)placeTitle;

#pragma mark - UITextView
/** 不带frame */
+ (UITextView *)textViewWithBackColor:(UIColor *)color font:(UIFont *)font delegate:(id<UITextViewDelegate>)delegate;

/** 带frame */
+ (UITextView *)textViewWithFrame:(CGRect)frame backColor:(UIColor *)color font:(UIFont *)font delegate:(id<UITextViewDelegate>)delegate;

#pragma mark - UIBarButtonItem
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image action:(actionBlock)action;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(actionBlock)action;

#pragma mark - UITapGestureRecognizer
+ (UITapGestureRecognizer *)tapWithTarget:(id)target action:(SEL)action;

#pragma mark - UIProgressView
+ (UIProgressView *)progressViewWithFrame:(CGRect)frame trackTintColor:(UIColor *)tintColor progressColor:(UIColor *)progressColor;

#pragma mark - UISlider
+ (UISlider *)sliderWithFrame:(CGRect)frame thumbImage:(NSString *)image minColor:(UIColor *)minColor maxColor:(UIColor *)maxColor;
@end
