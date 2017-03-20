//
//  ZY_button.h
//  Baisibudejie
//
//  Created by dqong on 16/10/9.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tapHandler)(UIButton *sender);
@interface ZY_button : UIButton
@property (nonatomic,strong)tapHandler handler;
+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment  image:(UIImage *)image imageViewContentMode:(UIViewContentMode)imageViewContentMode handler:(tapHandler)handler;
@end
