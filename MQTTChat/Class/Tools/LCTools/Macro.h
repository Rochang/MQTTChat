//
//  Macro.h
//  MQTTChat
//
//  Created by rochang on 2018/9/27.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark - DEBUG
/************************* DEBUG ***************************/
#ifdef DEBUG
#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NSLog(...)
#endif

#pragma mark - easy
/************************* easy ***************************/
#define __WEAKSELF(X) __weak typeof(X) weakSelf = X;
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define UserDefaultsSet(value,key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define UserDefaultsGet(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define Image(nameStr)        [UIImage imageNamed:nameStr]
#define Url(urlStr)           [NSURL URLWithString:urlStr]
#define Bundle(bundleName, pic) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]] pathForResource:pic ofType:@"png"]]

#pragma mark - UI
/************************* UI ***************************/
#define kIPhone5s (ScreenWidth == 320)
#define kIPhone6 (ScreenWidth == 375)
#define kIPhone6p (ScreenWidth == 414)
#define kScreenScale ScreenWidth/375

#pragma mark - 字体
/************************* 字体 ***************************/
#define Font(size)  [UIFont systemFontOfSize:(size)]
#define ScaleFont(size)  [UIFont systemFontOfSize:(size)*ScreenScale]
#define ScaleSize(size)  (size)*ScreenScale

#define ColorRandom [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

/************************* 颜色 ***************************/
#define ColorRGB(r, g, b)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define ColorRGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ColorHex(s)   [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0green:(((s &0xFF00) >>8))/255.0blue:((s &0xFF))/255.0alpha:1.0]

#define ColorHexA(s, alpha)   [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:alpha]
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* Macro_h */
