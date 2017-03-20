//
//  UIView+UIView_ZYExtension.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "UIView+UIView_ZYExtension.h"

@implementation UIView (UIView_ZYExtension)

-(void)setZy_width:(CGFloat)zy_width
{
    CGRect frame = self.frame;
    frame.size.width = zy_width;
    self.frame = frame;
}
-(CGFloat)zy_width
{
    return self.frame.size.width;
}
-(void)setZy_height:(CGFloat)zy_height
{
    CGRect frame = self.frame;
    frame.size.height = zy_height;
    self.frame = frame;
}
-(CGFloat)zy_height
{
    return self.frame.size.height;
}
-(void)setZy_x:(CGFloat)zy_x
{
    CGRect frame = self.frame;
    frame.origin.x = zy_x;
    self.frame = frame;
}
-(CGFloat)zy_x
{
    return self.frame.origin.x;
}
-(void)setZy_y:(CGFloat)zy_y
{
    CGRect frame = self.frame;
    frame.origin.y = zy_y;
    self.frame = frame;
}
-(CGFloat)zy_y
{
    return self.frame.origin.y;
}
-(void)setZy_centerX:(CGFloat)zy_centerX
{
    CGPoint center = self.center;
    center.x = zy_centerX;
    self.center = center;
}
-(CGFloat)zy_centerX
{
    return self.center.x;
}
-(void)setZy_centerY:(CGFloat)zy_centerY
{
    CGPoint center = self.center;
    center.y = zy_centerY;
    self.center = center;
}
-(CGFloat)zy_centerY
{
    return self.center.y;
}
@end
