//
//  ZY_BottonView.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/20.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZY_BottonView.h"
#import "PrefixHeader.pch"
@implementation ZY_BottonView


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 200);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _rebackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rebackBtn.frame = CGRectMake(SCREEN_W - 40, 10, 20, 20);
        [_rebackBtn setBackgroundImage:[UIImage imageNamed:@"backImages"] forState:UIControlStateNormal];
        [_rebackBtn addTarget:self action:@selector(rebackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _testLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREEN_W - 20, 30)];
        [self addSubview:_testLabel];
        [self addSubview:_rebackBtn];
        
    }
    return self;
}

+ (ZY_BottonView *)shareView{
    static ZY_BottonView * zy_bottonView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        zy_bottonView = [[ZY_BottonView alloc]init];
    });
    return zy_bottonView;
}
//View消失
-(void)rebackBtnClick:(UIButton *)btn{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        ZYLog(@"走了下移显示的方法");
        weakSelf.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 200);
    
        
    }];
}
-(void)remove{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        ZYLog(@"走了下移显示的方法");
        weakSelf.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 200);
        
        
    }];


}
//显示
-(void)show{

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        ZYLog(@"走了显示的方法");
         [[UIApplication sharedApplication].keyWindow addSubview:weakSelf];
        weakSelf.frame = CGRectMake(0, SCREEN_H - 200, SCREEN_W, 200);
        _testLabel.text = @"这是一个测试的View";
        
    }];
   
    
}
@end
