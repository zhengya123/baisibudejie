//
//  FTRulerScrollView.h
//  FTHealthProject
//
//  Created by NB1539 on 16/10/21.
//  Copyright © 2016年 WangSanpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCELEFTANDRIGHT 8.f // 标尺左右距离
#define DISTANCEVALUE 8.f // 每隔刻度实际长度8个点
#define DISTANCETOPANDBOTTOM 20.f // 标尺上下距离

@interface FTRulerScrollView : UIScrollView
@property (assign, nonatomic) NSUInteger rulerCount;
/** 尺子平均数 */
@property (strong, nonatomic) NSNumber *rulerAverage;
@property (assign, nonatomic) NSUInteger rulerHeight; /// 尺子高度
@property (assign, nonatomic) NSUInteger rulerWidth; /// 尺子宽度
@property (assign, nonatomic) CGFloat rulerValue;
@property (assign, nonatomic) BOOL mode;

- (void)drawRuler;
@end
