//
//  ZY_button.m
//  Baisibudejie
//
//  Created by dqong on 16/10/9.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_button.h"
//title所占的conentView的比例
#define kTitleRatio 0.3
@implementation ZY_button

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:       (CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment  image:(UIImage *)image imageViewContentMode:(UIViewContentMode)imageViewContentMode handler:(tapHandler)handler{
    //button的类型
    ZY_button *button = [super buttonWithType:buttonType];
    button.backgroundColor = [UIColor clearColor];
    //button的frame
    button.frame = frame;
    //文字居中
    button.titleLabel.textAlignment = textAlignment;
    //文字大小
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    //文字颜色
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    //图片填充的内容模式
    button.imageView.contentMode = imageViewContentMode;
    //button的title
    [button setTitle:title forState:UIControlStateNormal];
    //button的image
    [button setImage:image forState:UIControlStateNormal];
    //button的点击事件
    button.handler = handler;
    [button addTarget:button action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark - handleButton
- (void)handleButton:(UIButton *)sender{
    if (self.handler) {
        self.handler(sender);
    }
}
/**
 *  文字在左，图片在右
 */
//#pragma mark - 调整内部ImageView的frame
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat imageX = contentRect.size.width * kTitleRatio;
//    CGFloat imageY = 0;
//    CGFloat imageWidth = contentRect.size.width * (1 - kTitleRatio);
//    CGFloat imageHeight = contentRect.size.height;
//    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
//}
//#pragma mark - 调整内部UIlable的frame
//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CGFloat titleX = 0;
//    CGFloat titleY = 0;
//    CGFloat titleWidth = contentRect.size.width * kTitleRatio - 20;
//    CGFloat titleHeight = contentRect.size.height;
//    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
//}
/**
 *  图片在上，文字在下
 */
#pragma mark - 调整内部ImageView的frame --
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * (1 - kTitleRatio);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
#pragma mark - 调整内部UIlable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}
@end
