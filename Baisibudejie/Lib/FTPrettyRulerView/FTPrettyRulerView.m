//
//  FTPrettyRulerView.m
//  FTHealthProject
//
//  Created by NB1539 on 16/10/21.
//  Copyright © 2016年 WangSanpeng. All rights reserved.
//

#import "FTPrettyRulerView.h"
#import "FTRulerScrollView.h"

#define SHEIGHT 8 // 中间指示器顶部闭合三角形高度
#define INDICATORCOLOR [UIColor redColor].CGColor // 中间指示器颜色

@implementation FTPrettyRulerView {
    FTRulerScrollView *rulerScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}
- (void)setupView {
    //背景颜色
    self.backgroundColor = [UIColor redColor];
    rulerScrollView = [self rulerScrollView];
    [self addSubview:rulerScrollView];
}
- (CGFloat)rulerValue {
    return rulerScrollView.rulerValue;
}
#pragma mark public Methods
- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode {
    NSAssert(rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 rulerScrollView\n");
    NSAssert(currentValue < [average floatValue] * count, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    [self layoutIfNeeded];
    rulerScrollView.rulerCount   = count;
    rulerScrollView.rulerAverage = average;
    rulerScrollView.rulerValue   = currentValue;
    rulerScrollView.mode         = mode;
    rulerScrollView.rulerHeight = self.frame.size.height;
    rulerScrollView.rulerWidth  = self.frame.size.width;
    [rulerScrollView drawRuler];
    [self drawRacAndLine];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(FTRulerScrollView *)scrollView {
    
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
    CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
    if (ruleValue < 0.f) {
        return;
    } else if (ruleValue > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(ftRrettyRuler:rulerValue:)]) {
        if (!scrollView.mode) {
            scrollView.rulerValue = ruleValue;
        }
        scrollView.mode = NO;
        [self.delegate ftRrettyRuler:self rulerValue:scrollView.rulerValue];
    }

}
- (void)scrollViewDidEndDecelerating:(FTRulerScrollView *)scrollView {
    [self animationRebound:scrollView];
}
- (void)scrollViewDidEndDragging:(FTRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}
#pragma mark private Methods
- (FTRulerScrollView *)rulerScrollView {
    FTRulerScrollView *rsView = [FTRulerScrollView new];
    rsView.delegate           = self;
    rsView.backgroundColor = [UIColor clearColor];
    rsView.showsHorizontalScrollIndicator = NO;
    return rsView;
}
- (void)animationRebound:(FTRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
    CGFloat oX = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
#ifdef DEBUG
    NSLog(@"ago*****************ago:oX:%f",oX);
#endif
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        oX = [self notRounding:oX afterPoint:0];
    }
    else {
        oX = [self notRounding:oX afterPoint:1];
    }
#ifdef DEBUG
    NSLog(@"after*****************after:oX:%.1f",oX);
#endif
    CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}
/**
 绘制显示View样式
 */
- (void)drawRacAndLine {
    // 圆弧
    CAShapeLayer *shapeLayerArc = [CAShapeLayer layer];
    shapeLayerArc.strokeColor   = [UIColor lightGrayColor].CGColor;
    shapeLayerArc.fillColor     = [UIColor clearColor].CGColor;
    shapeLayerArc.lineWidth     = 1.f;
    shapeLayerArc.lineCap       = kCALineCapButt;
    shapeLayerArc.frame         = self.bounds;
    // 渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors    = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.6f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint   = CGPointMake(1, .5);
    
    CGMutablePathRef pathArc = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathArc, NULL, 0, DISTANCETOPANDBOTTOM);
    CGPathAddQuadCurveToPoint(pathArc, NULL, self.frame.size.width / 2, - 20, self.frame.size.width, DISTANCETOPANDBOTTOM);
    
    shapeLayerArc.path = pathArc;
    [self.layer addSublayer:shapeLayerArc];
    [self.layer addSublayer:gradient];

    // 红色指示器
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = [UIColor redColor].CGColor;
    shapeLayerLine.fillColor = INDICATORCOLOR;
    shapeLayerLine.lineWidth = 1.f;
    shapeLayerLine.lineCap = kCALineCapSquare;
    
    NSUInteger ruleHeight = 20; // 文字高度
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, self.frame.size.height - DISTANCETOPANDBOTTOM - ruleHeight);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, DISTANCETOPANDBOTTOM + SHEIGHT);
    
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 - SHEIGHT / 2, DISTANCETOPANDBOTTOM);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 + SHEIGHT / 2, DISTANCETOPANDBOTTOM);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, DISTANCETOPANDBOTTOM + SHEIGHT);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
}

#pragma mark - Common Tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler*roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces floatValue];
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}
@end
