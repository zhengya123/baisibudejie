//
//  FTPrettyRulerView.h
//  FTHealthProject
//
//  Created by NB1539 on 16/10/21.
//  Copyright © 2016年 WangSanpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTPrettyRulerView;
@protocol FTPrettyRulerViewDelegate <NSObject>

- (void)ftRrettyRuler:(FTPrettyRulerView *)rulerView rulerValue:(CGFloat )rulerValue;

@end

@interface FTPrettyRulerView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) id<FTPrettyRulerViewDelegate> delegate;

@property (assign, nonatomic, readonly) CGFloat rulerValue;
/*
 *  count * average = 刻度最大值
 *  @param count        10个小刻度为一个大刻度，大刻度的数量
 *  @param average      每个小刻度的值，最小精度 0.1
 *  @param currentValue 直尺初始化的刻度值
 *  @param mode         是否最小模式
 */
- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode;
@end
