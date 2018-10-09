//
//  LCView.m
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import "LCView.h"

@implementation LCView

#pragma mark - UIView
+ (UIView *)viewWithFrame:(CGRect)frame backColor:(UIColor *)backColor {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backColor;
    return view;
}


#pragma mark - UIButton
/** 多项 */
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
                          sel:(SEL)sel
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (selTitle) {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (selTitleColor) {
        [button setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    if (backColor) {
        button.backgroundColor = backColor;
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (selImage) {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    if (bgImage) {
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    }
    if (bgsSelImage) {
        [button setBackgroundImage:bgsSelImage forState:UIControlStateSelected];
    }
    if (fontSize != 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    if (action) {
        [button addAction:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

/** 文字 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   titleColor:(UIColor *)titleColor
                selTitleColor:(UIColor *)selTitleColor
                    backColor:(UIColor *)backColor
                        title:(NSString *)title
                     selTitle:(NSString *)selTitle
                     fontSize:(CGFloat)fontSize
                       action:(actionBlock)action {
    return [self buttonWithFrame:frame
                      titleColor:titleColor
                   selTitleColor:selTitleColor
                       backColor:backColor
                           image:nil
                        selImage:nil
                         bgImage:nil
                      bgSelImage:nil
                           title:title
                        selTitle:selTitle
                        fontSize:fontSize
                          action:action
                          target:nil
                             sel:nil];
}

/** 图片 block*/
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                       action:(actionBlock)action {
    return [self buttonWithFrame:frame
                      titleColor:nil
                   selTitleColor:nil
                       backColor:nil
                           image:image
                        selImage:selImage
                         bgImage:nil
                      bgSelImage:nil
                           title:nil
                        selTitle:nil
                        fontSize:0
                          action:action
                          target:nil
                             sel:nil];
}

/** 背景图片 block */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                   bgSelImage:(UIImage *)bgsSelImage
                       action:(actionBlock)action {
    return [self buttonWithFrame:frame
                      titleColor:nil
                   selTitleColor:nil
                       backColor:nil
                           image:nil
                        selImage:nil
                         bgImage:bgImage
                      bgSelImage:bgsSelImage
                           title:nil
                        selTitle:nil
                        fontSize:0
                          action:action
                          target:nil
                             sel:nil];
}

/** 文字 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   titleColor:(UIColor *)titleColor
                selTitleColor:(UIColor *)selTitleColor
                    backColor:(UIColor *)backColor
                        title:(NSString *)title
                     selTitle:(NSString *)selTitle
                     fontSize:(CGFloat)fontSize
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                      titleColor:titleColor
                   selTitleColor:selTitleColor
                       backColor:backColor
                           image:nil
                        selImage:nil
                         bgImage:nil
                      bgSelImage:nil
                           title:nil
                        selTitle:selTitle
                        fontSize:fontSize
                          action:nil
                          target:target
                          sel:action];
}

/** 图片 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                      titleColor:nil
                   selTitleColor:nil
                       backColor:nil
                           image:image
                        selImage:selImage
                         bgImage:nil
                      bgSelImage:nil
                           title:nil
                        selTitle:nil
                        fontSize:0
                          action:nil
                          target:target
                          sel:action];
}

/** 背景图片 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                   bgSelImage:(UIImage *)bgsSelImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                      titleColor:nil
                   selTitleColor:nil
                       backColor:nil
                           image:nil
                        selImage:nil
                         bgImage:bgImage
                      bgSelImage:bgsSelImage
                           title:nil
                        selTitle:nil
                        fontSize:0
                          action:nil
                          target:target
                             sel:action];
}

#pragma mark - UIlabel
+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor textAlignment:(NSTextAlignment)textAlignment lineNumber:(NSInteger)number text:(NSString *)text fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (text.length) {
        label.text = text;
    }
    if(textColor) {
        label.textColor = textColor;
    }
    if (backColor) {
        label.backgroundColor = backColor;
    }
    label.textAlignment = textAlignment;
    label.numberOfLines = number;
    if (fontSize != 0) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor text:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self labelWithFrame:frame textColor:textColor backColor:backColor textAlignment:NSTextAlignmentLeft lineNumber:1 text:text fontSize:fontSize];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor backColor:(UIColor *)backColor numberOfLines:(NSInteger)number fontSize:(CGFloat)fontSize text:(NSString *)text {
    return [self labelWithFrame:CGRectZero textColor:textColor backColor:backColor textAlignment:NSTextAlignmentLeft lineNumber:number text:text fontSize:fontSize];
}


#pragma mark - Tableview
+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate showHorizontal:(BOOL)showH showVertical:(BOOL)showV backColor:(UIColor *)backColor footerView:(UIView *)footerView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    if (backColor) {
        tableView.backgroundColor = backColor;
    }
    if (footerView) {
        tableView.tableFooterView = footerView;
    }
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    tableView.showsHorizontalScrollIndicator = showH;
    tableView.showsVerticalScrollIndicator = showV;
    return tableView;
}

+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate {
    return [self tableViewWithFrame:frame style:style dataSource:dataSource delegate:delegate showHorizontal:YES showVertical:YES backColor:nil footerView:[[UIView alloc] init]];
}

+ (UITableView *)tableViewWithDataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate {
    return [self tableViewWithFrame:CGRectZero style:UITableViewStylePlain dataSource:dataSource delegate:delegate];
}


#pragma mark - UIScrollview
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegete showsHorizontal:(BOOL)horizontal showVertical:(BOOL)vertical pagingEnable:(BOOL)page bounces:(BOOL)bounces backColor:(UIColor *)backColor {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = delegete;
    scrollView.showsHorizontalScrollIndicator = horizontal;
    scrollView.showsVerticalScrollIndicator = vertical;
    scrollView.pagingEnabled = page;
    scrollView.bounces = bounces;
    if (backColor) {
        scrollView.backgroundColor = backColor;
    }
    return scrollView;
}

+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegete {
    return [self scrollViewWithFrame:frame delegate:delegete showsHorizontal:YES showVertical:YES pagingEnable:NO bounces:YES backColor:nil];
}

#pragma mark - UICollectView
+ (UICollectionView *)collectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout direction:(UICollectionViewScrollDirection)direction minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource showHorizontal:(BOOL)showH showVertical:(BOOL)showV pagingEnabled:(BOOL)page backColor:(UIColor *)color {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    layout.minimumInteritemSpacing = interSpace;
    layout.minimumLineSpacing = lineSpace;
    layout.scrollDirection = direction;
    collectionView.delegate = delegate;
    collectionView.dataSource = dataSource;
    collectionView.showsHorizontalScrollIndicator = showH;
    collectionView.showsVerticalScrollIndicator = showV;
    collectionView.pagingEnabled = page;
    if (color) {
        collectionView.backgroundColor = color;
    }
    return collectionView;
}

+ (UICollectionView *)collectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource backColor:(UIColor *)color {
    return [self collectionViewWithFrame:frame layout:layout direction:UICollectionViewScrollDirectionVertical minInterSpace:interSpace minLineSpace:lineSpace delegate:delegate dataSource:dataSource showHorizontal:YES showVertical:YES pagingEnabled:YES backColor:color];
}

+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout minInterSpace:(CGFloat)interSpace minLineSpace:(CGFloat)lineSpace delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource backColor:(UIColor *)color {
    return [self collectionViewWithFrame:CGRectZero layout:layout minInterSpace:interSpace minLineSpace:lineSpace delegate:delegate dataSource:dataSource backColor:color];
}

#pragma mark - UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}

+ (UIImageView *)imageViewWithImage:(NSString *)image {
    return [self imageViewWithFrame:CGRectZero image:image];
}

#pragma mark - UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame backColor:(UIColor *)backColor placeTitle:(NSString *)placeTitle {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeTitle;
    textField.backgroundColor = backColor;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

#pragma mark - UITextView
+ (UITextView *)textViewWithBackColor:(UIColor *)color font:(UIFont *)font delegate:(id<UITextViewDelegate>)delegate{
    return [self textViewWithFrame:CGRectZero backColor:color font:font delegate:delegate];
}

+ (UITextView *)textViewWithFrame:(CGRect)frame backColor:(UIColor *)color font:(UIFont *)font delegate:(id<UITextViewDelegate>)delegate{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.delegate = delegate;
    textView.backgroundColor = color;
    textView.font = font;
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName : font}];
    return textView;
}

#pragma mark - UIBarButtonItem
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image action:(actionBlock)action {
    return [[UIBarButtonItem alloc] initWithImage:image action:action];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(actionBlock)action {
    return [[UIBarButtonItem alloc] initWithTitle:title action:action];
}

#pragma mark - UITapGestureRecognizer
+ (UITapGestureRecognizer *)tapWithTarget:(id)target action:(SEL)action {
    return [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    
}

#pragma mark - UIProgressView
+ (UIProgressView *)progressViewWithFrame:(CGRect)frame trackTintColor:(UIColor *)tintColor progressColor:(UIColor *)progressColor {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:frame];
    progressView.trackTintColor = tintColor;
    progressView.progressTintColor = progressColor;
    return progressView;
}

#pragma mark - UISlider
+ (UISlider *)sliderWithFrame:(CGRect)frame thumbImage:(NSString *)image minColor:(UIColor *)minColor maxColor:(UIColor *)maxColor {
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    slider.minimumTrackTintColor = minColor;
    slider.maximumTrackTintColor = maxColor;
    if (image.length) {
        [slider setThumbImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    return slider;
}

@end
