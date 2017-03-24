//
//  ZY_ErrorView.h
//  Baisibudejie
//
//  Created by dqong on 2017/3/22.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZY_ErrorView : UIView
@property (nonatomic, strong) UIView  * showView;
@property (nonatomic, strong) UIImageView * showImage;
@property (nonatomic, strong) UILabel * errorLabel;

+(ZY_ErrorView *)shareError;
/**
 * 支持字体长度自适应，可换行
 * string 错误信息
 * font   字体大小
 * time   持续时间
 **/
-(void)showWithStr:(NSString *)string
               Font:(CGFloat)font
               Time:(NSTimeInterval)time;
@end
