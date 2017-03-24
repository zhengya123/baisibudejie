//
//  ZY_ErrorView.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/22.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZY_ErrorView.h"
#import "ZY_Method.h"
#define ZY_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define ZY_SCREEN_H [UIScreen mainScreen].bounds.size.height
@implementation ZY_ErrorView

+(ZY_ErrorView *)shareError{
    
    static ZY_ErrorView * zy_ErrorView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        zy_ErrorView = [[ZY_ErrorView alloc]init];
    });
    return zy_ErrorView;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:0.2];
        self.showView.frame = CGRectMake(ZY_SCREEN_W/2 - SCREEN_W/6, ZY_SCREEN_H/2 - SCREEN_W/6, ZY_SCREEN_W/3,ZY_SCREEN_W/3);
        self.showImage.frame = CGRectMake(ZY_SCREEN_W/6 - 25, 20,50, 50);
        self.errorLabel.frame = CGRectMake(0, CGRectGetMaxY(self.showImage.frame) + 10, ZY_SCREEN_W/3, 30);
        [self.showView addSubview:self.showImage];
        [self.showView addSubview:self.errorLabel];
        [self addSubview:self.showView];
    }
    return self;
}
-(void)updateFramestr:(NSString *)string size:(CGFloat)size{
   
    float width = [ZY_Method stringWithSize:string fontOfSize:size];
    if (width > ZY_SCREEN_W/3 && width <= ZY_SCREEN_W - 60) {
        float height = [ZY_Method heightWithString:string fontSize:size width:width + 10];
        if (height > 30) {
            self.showView.frame = CGRectMake(ZY_SCREEN_W/2 - width/2 - 5, ZY_SCREEN_H/2 - SCREEN_W/6, width + 10,ZY_SCREEN_W/3 + height - 30);
            self.showImage.frame = CGRectMake((width + 10)/2 - 25, 20, 50, 50);
            self.errorLabel.frame = CGRectMake(5, CGRectGetMaxY(self.showImage.frame) + 10, width, height);
            self.errorLabel.textAlignment = NSTextAlignmentLeft;
        }else{
            self.showView.frame = CGRectMake(ZY_SCREEN_W/2 - width /2 - 5, ZY_SCREEN_H/2 - SCREEN_W/6, width + 10,ZY_SCREEN_W/3);
            self.showImage.frame = CGRectMake(width/2 - 25, 20, 50, 50);
            self.errorLabel.frame = CGRectMake(5, CGRectGetMaxY(self.showImage.frame) + 10, width, 30);
            self.errorLabel.textAlignment = NSTextAlignmentCenter;
        }
        
    }else if (width > ZY_SCREEN_W - 60){
        
        width = ZY_SCREEN_W - 60;
        float height = [ZY_Method heightWithString:string fontSize:size width:width];
        self.showView.frame = CGRectMake(ZY_SCREEN_W/2 - width/2 - 5, ZY_SCREEN_H/2 - SCREEN_W/6, width + 10,ZY_SCREEN_W/3 + height - 30);
        self.showImage.frame = CGRectMake((width + 10)/2 - 25, 20, 50, 50);
        self.errorLabel.frame = CGRectMake(5, CGRectGetMaxY(self.showImage.frame) + 10, width, height);
        self.errorLabel.textAlignment = NSTextAlignmentLeft;
        
    }else{
    
        self.showView.frame = CGRectMake(ZY_SCREEN_W/2 - SCREEN_W/6, ZY_SCREEN_H/2 - SCREEN_W/6, ZY_SCREEN_W/3,ZY_SCREEN_W/3);
        self.showImage.frame = CGRectMake(ZY_SCREEN_W/6 - 25, 20, 50, 50);
        self.errorLabel.frame = CGRectMake(5, CGRectGetMaxY(self.showImage.frame) + 10, ZY_SCREEN_W/3 - 10, 30);
        self.errorLabel.textAlignment = NSTextAlignmentCenter;
    }
}

-(void)showWithStr:(NSString *)string Font:(CGFloat)font Time:(NSTimeInterval)time{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.errorLabel.text = string;
    self.errorLabel.font = [UIFont systemFontOfSize:font];
    [self updateFramestr:string size:font];
    [self performSelector:@selector(hides) withObject:nil afterDelay:time];
    [self.showView.layer addAnimation:animation forKey:nil];

}
-(void)hides{
   
         [self removeFromSuperview];
   
}
#pragma mark - lan
-(UIView *)showView{
    if (_showView == nil) {
        _showView = [UIView new];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius  = 8;
    }
    return _showView;
}
-(UIImageView *)showImage{
    if (_showImage == nil) {
        _showImage = [UIImageView new];
        _showImage.image = [UIImage imageNamed:@"ErrorImage"];
        _showImage.backgroundColor = [UIColor whiteColor];
    }
    return _showImage;

}
-(UILabel *)errorLabel{
    if (_errorLabel == nil) {
        _errorLabel = [UILabel new];
        _errorLabel.textColor = [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1.0];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.numberOfLines = 0;
    }
    return _errorLabel;
}
@end
