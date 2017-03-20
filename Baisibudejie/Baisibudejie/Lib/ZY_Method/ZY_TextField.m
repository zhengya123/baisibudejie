//
//  ZY_TextField.m
//  mobileinspect
//
//  Created by dqong on 2016/11/16.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ZY_TextField.h"

@implementation ZY_TextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect

{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor redColor] set];//设置下划线颜色 这里是红色 可以自定义
    
    CGFloat y = CGRectGetHeight(self.frame);
    
    CGContextMoveToPoint(context, 0, y);
    
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    
    //设置线的宽度
    
    CGContextSetLineWidth(context, 2);
    
    //渲染 显示到self上
    
    CGContextStrokePath(context);
    
}

@end
