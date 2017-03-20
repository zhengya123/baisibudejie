//
//  ZY_verification_Button.m
//  ZYHandMade
//
//  Created by dqong on 16/8/31.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_verification_Button.h"

@interface ZY_verification_Button ()

@property (nonatomic, copy)void(^block)(ZY_verification_Button *button);
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) int second;
@property (nonatomic, assign) int totalSecond;
@end


@implementation ZY_verification_Button

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
}


- (void)buttonClickWithTimer:(NSTimeInterval)second callBack:(void(^)(ZY_verification_Button *button))block
{
    _second = second;
    _totalSecond = second;
    _block = [block copy];
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(ZY_verification_Button *)button
{
    button.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%zd秒后重新发送", _totalSecond] forState:UIControlStateDisabled];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(code) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _block(button);
}

- (void)code
{
    [self setTitle:[NSString stringWithFormat:@"%zd秒后重新发送", --_second] forState:UIControlStateDisabled];
    if (_second <= 0) {
        if ([_timer isValid]) {
            [_timer invalidate];
            _second = _totalSecond;
            _timer = nil;
            self.enabled = YES;
        }
    }
}

@end
