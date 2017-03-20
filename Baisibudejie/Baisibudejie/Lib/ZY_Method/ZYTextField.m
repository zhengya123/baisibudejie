//
//  ZYTextField.m
//  mobileinspect
//
//  Created by dqong on 16/7/20.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ZYTextField.h"
#import <objc/runtime.h>

#define YCplaceholderTextColor @"_placeholderLabel.textColor"
@implementation ZYTextField

+ (void)initialize {
    
    [self getIvars];
    
}

// 获取私有变量名称
+ (void)getIvars {
    
    unsigned int count = 0;
    
    //Ivar *ivars = class_copyIvarList([UITextField class], &count);

    for (int i = 0; i < count; i++) {
        //Ivar ivar = ivars[i];
        
        //NSLog(@"%s----%s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}

- (void)awakeFromNib {
    
    // 设置光标的颜色
    self.tintColor = self.textColor;
}

// 获取到焦点
- (BOOL)becomeFirstResponder {
    
    // 利用运行时获取key,设置占位文字的颜色
    [self setValue:[UIColor redColor] forKeyPath:YCplaceholderTextColor];
    
    return [super becomeFirstResponder];
}

// 失去焦点
- (BOOL)resignFirstResponder {
    
    // 利用运行时获取key,设置占位文字的颜色
    [self setValue:[UIColor whiteColor] forKeyPath:YCplaceholderTextColor];
    
    return [super resignFirstResponder];
}

- (void)createAlertLayer{
    // 设置layer相关属性
    self.alertLayer = [CAShapeLayer layer];
    // 大小和文本框一致
    self.alertLayer.frame = self.bounds;
    // 画线 非圆角
    self.alertLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.alertLayer.bounds cornerRadius:0].CGPath;
    // 线宽
    self.alertLayer.lineWidth = 6. / [[UIScreen mainScreen] scale];
    // 设置为实线
    self.alertLayer.lineDashPattern = nil;
    // 填充颜色透明色
    self.alertLayer.fillColor = [UIColor clearColor].CGColor;
    // 边框颜色为红色
    self.alertLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:self.alertLayer];
}
-(void)showAlert{

    [self createAlertLayer];
    
    // 透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.repeatCount = 5;
    opacityAnimation.repeatDuration = 2;
    opacityAnimation.autoreverses = YES;
    [self.alertLayer addAnimation:opacityAnimation forKey:@"opacity"];
    
    // 2秒后移除动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        // 移除动画
        [self.alertLayer removeFromSuperlayer];
    });
    
}
@end
