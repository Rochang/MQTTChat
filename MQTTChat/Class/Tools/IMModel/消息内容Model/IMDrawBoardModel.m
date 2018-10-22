//
//  IMDrawBoardModel.m
//  MQTTChat
//
//  Created by rochang on 2018/10/22.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMDrawBoardModel.h"
#pragma mark - IMBrushCoordModel
@implementation IMBrushCoordModel

// 使用真实坐标构造
- (instancetype)initWithOrigin:(float)x y:(float)y {
    if(!(self = [super init])) return nil;
    _originalX = @(x);
    _originalY = @(y);
    _x = @([IMBrushCoordModel pixConvertToProportion:x]);
    _y = @([IMBrushCoordModel pixConvertToProportion:y]);
    return self;
}

// 使用比例坐标构建
- (instancetype)initWithProportion:(float)proportionX proportionY:(float)proportionY {
    if(!(self = [super init])) return nil;
    _x = @(proportionX);
    _y = @(proportionY);
    _originalX = @([IMBrushCoordModel proportionConvertToPix:proportionX]);
    _originalY = @([IMBrushCoordModel proportionConvertToPix:proportionY]);
    return self;
}


- (float)getOriginalX {
    if(!_originalX) {
        _originalX = _x ? @([IMBrushCoordModel proportionConvertToPix:_x.floatValue]) : @(0);
    }
    return [IMBrushCoordModel roundFloat:_originalX.floatValue];
}

- (float)getOriginalY {
    if(!_originalY) {
        _originalY = _y ? @([IMBrushCoordModel proportionConvertToPix:_y.floatValue]) : @(0);
    }
    return [IMBrushCoordModel roundFloat:_originalY.floatValue];
}

//像素转比例
+ (float)pixConvertToProportion:(float)value {
    return value / KScreen_W * 100;
}

//比例转像素
+ (float)proportionConvertToPix:(float)value {
    return value / 100 * KScreen_W;
}

+ (float)roundFloat:(float)price {
    NSString *temp = [NSString stringWithFormat:@"%.7f",price];
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
}

@end


#pragma mark - IMBrushModel
@implementation IMBrushModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"coords" : IMBrushCoordModel.class};
}

- (instancetype)initWithType:(IMDirectiveActionType)type width:(int)width uiColor:(UIColor*)uiColor beginPoint:(IMBrushCoordModel *)beginPoint {
    if(!(self = [super init])) return nil;
    
    [self setWidthAndOriginWidth:width];
    [self setColorWithUIColor:uiColor];
    if(beginPoint) {
        _coords = [[NSMutableArray alloc] initWithObjects:beginPoint, nil];
    }
    return self;
}

- (void)setWidthAndOriginWidth:(int)width {
    _width = @(width);
    _originalWidth = @([IMBrushCoordModel proportionConvertToPix:width]);
}

- (int)getOriginalWidth {
    if(!_originalWidth) {
        _originalWidth = _width ? @([IMBrushCoordModel proportionConvertToPix:_width.floatValue]) : @(BrushrWidth);
    }
    return _originalWidth.intValue;
}

+ (IMBrushModel *)defaultBrush {
    IMBrushModel *brush = [IMBrushModel new];
    brush.type = IMDrawBoardActionTypeBrushes;
    [brush setWidthAndOriginWidth:BrushrWidth];
    [brush setColorWithUIColor:[UIColor colorWithRGB:BrushBlueColor]];
    return brush;
}

- (UIColor *)uiColor {
    UIColor *cor = nil;
    if(_color) {
        if(_color.length == 6) {
            _color = [NSString stringWithFormat:@"FF%@", _color];
        }
        if(_color.length == 8) {
            NSString *alphaStr = [_color substringToIndex:2];
            NSString *rgbStr   = [_color substringFromIndex:2];
            NSString *colorStr = [NSString stringWithFormat:@"#%@%@", rgbStr, alphaStr];
            cor = [UIColor colorWithHexString:colorStr];
        }
    }
    if(!cor) {
        cor = [UIColor blackColor];
    }
    [self setColorWithUIColor:cor];
    return cor;
}

- (void)setColorWithUIColor:(UIColor *)uiColor {
    NSString *colorStr = uiColor.hexStringWithAlpha;
    if(colorStr && [[colorStr substringToIndex:1] isEqualToString:@"#"]) {
        colorStr = [colorStr substringFromIndex:1];
    }
    if(colorStr.length == 8) {
        NSString *alphaStr = [colorStr substringFromIndex:6];
        NSString *rgbStr   = [colorStr substringToIndex:6];
        colorStr = [NSString stringWithFormat:@"%@%@", alphaStr, rgbStr];
        _color = colorStr;
    }
}

- (void)setDrawingBoardOrderType:(NSNumber *)type {
    _type = type;
    if(!_type) return;
    switch (type.integerValue) {
        case DrawingBoardActionEraser:{ //设置成橡皮擦
            [self setColorWithUIColor:[UIColor colorWithRGBA:0xFFFFFFFF]];
            [self setWidthAndOriginWidth:EarserWidth];
        }
            break;
        case DrawingBoardActionBrushes:{ //设置成画笔
            [self setColorWithUIColor:[UIColor colorWithRGBA:0x000000FF]];
            [self setWidthAndOriginWidth:BrushrWidth];
        }
        default:
            break;
    }
}

- (DrawingBoardActionType)drawingBoardActionType {
    if(!_type) return DrawingBoardActionBrushes;
    return _type.integerValue;
}

@end


#pragma mark - IMDrawBoardModel
@implementation IMDrawBoardModel

+ (SIMDrawingBoard *)defaultDrawingBoard {
    SIMDrawingBoard *board = [SIMDrawingBoard new];
    board.type = @(DrawingBoardOrderBrushes);
    board.brush = [SIMBrush defaultBrush];
    return board;
}
//橡皮擦擦除
+ (SIMDrawingBoard *)erasureDrawingBoard {
    SIMDrawingBoard *board = [SIMDrawingBoard new];
    board.type = @(DrawingBoardOrderBrushes);
    [board.brush setDrawingBoardOrderType:@(DrawingBoardActionEraser)];
    return board;
}
//清屏
+ (SIMDrawingBoard *)clearDrawingBoard {
    SIMDrawingBoard *board = [SIMDrawingBoard new];
    board.type = @(DrawingBoardOrderClear);
    return board;
}
//撤销
+ (SIMDrawingBoard *)cancelDrawingBoard {
    SIMDrawingBoard *board = [SIMDrawingBoard new];
    board.type = @(DrawingBoardOrderRepeal);
    return board;
}
//恢复
+ (SIMDrawingBoard *)recoverDrawingBoard {
    SIMDrawingBoard *board = [SIMDrawingBoard new];
    board.type = @(DrawingBoardOrderRecover);
    return board;
}
- (DrawingBoardOrderType)drawingBoardOrderType {
    if(!_type) return DrawingBoardOrderBrushes;
    return _type.integerValue;
}
//更新画笔信息，不带坐标点
- (void)update:(SIMDrawingBoard *)drawingBoard {
    if(!drawingBoard) return;
    _type = drawingBoard.type;
    if(!drawingBoard.brush) return;
    [_brush setWidthAndOriginWidth:drawingBoard.brush.width.intValue];
    _brush.color = drawingBoard.brush.color;
}

- (void)clearCustomValues {
    if(!_brush) return;
    _brush.originalWidth = nil;
    for (IMBrushCoordModel *coord in _brush.coords) {
        coord.originalX = coord.originalY = nil;
    }
}

@end
