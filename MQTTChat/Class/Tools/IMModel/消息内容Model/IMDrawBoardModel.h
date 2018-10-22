//
//  IMDrawBoardModel.h
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EarserWidth     3 //橡皮宽度（比例值）
#define BrushrWidth     1 //画笔宽度（比例值）
#define BrushBoldWidth  3 //粗笔宽度
#define BrushBlueColor 0x187DD5
#define BrushYellowColor 0xFDC565
#define BrushBlackColor 0x000000
#define BrushRedColor 0xFF6666

// 画板点model
@interface IMBrushCoordModel : NSObject
@property (nonatomic, strong) NSNumber *x;//Float:画笔路径的X轴坐标
@property (nonatomic, strong) NSNumber *y;//Float:画笔路径的Y轴坐标
//真实坐标
@property(nonatomic, strong) NSNumber *originalX;
@property(nonatomic, strong) NSNumber *originalY;
//使用真实坐标构造
- (instancetype)initWithOrigin:(float)x y:(float)y;
//使用比例坐标构建
- (instancetype)initWithProportion:(float)proportionX proportionY:(float)proportionY;
//真实X坐标
- (float)getOriginalX;
//真实Y坐标
- (float)getOriginalY;
@end

// 画笔Model
@interface IMBrushModel : NSObject

@property (nonatomic, assign) IMDrawBoardActionType type;//Int:画笔类型;1画笔，2橡皮擦
@property (nonatomic, strong) NSString *color; // 画笔颜色;字符串形式的16进制色值(不含#)
@property (nonatomic, strong) NSNumber *width; // 画笔宽度
@property (nonatomic, strong) NSMutableArray <IMBrushCoordModel *>*coords; // 画笔路径集合
@property (nonatomic, strong) NSNumber *originalWidth; //真实宽度

+ (IMBrushModel *)defaultBrush;
- (instancetype)initWithType:(IMDrawBoardActionType)type width:(int)width uiColor:(UIColor *)uiColor beginPoint:(IMBrushCoordModel *)beginPoint;
- (int)getOriginalWidth;
- (IMDrawBoardActionType)drawingBoardActionType;
- (UIColor *)uiColor;
- (void)setColorWithUIColor:(UIColor *)uiColor;
- (void)setDrawingBoardOrderType:(NSNumber *)type;

@end

NS_ASSUME_NONNULL_BEGIN
// 画板Model
@interface IMDrawBoardModel : NSObject

@property (nonatomic, assign) IMDrawBoardOrderType type; // 操作类型;1画笔，2撤销，3恢复，4清屏
@property (nonatomic, strong) IMBrushModel *brush; // 画笔信息

+ (IMDrawBoardModel *)defaultDrawingBoard;
//橡皮擦擦除
+ (IMDrawBoardModel *)erasureDrawingBoard;
//清屏
+ (IMDrawBoardModel *)clearDrawingBoard;
//撤销
+ (IMDrawBoardModel *)cancelDrawingBoard;
//恢复
+ (IMDrawBoardModel *)recoverDrawingBoard;
- (IMDrawBoardActionType)drawingBoardOrderType;
- (void)update:(IMDrawBoardModel *)drawingBoard;
- (void)clearCustomValues;

@end

NS_ASSUME_NONNULL_END
