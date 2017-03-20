//
//  FellowViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "FellowViewController.h"
#import "PrefixHeader.pch"
#import "HHPatientDataViewController.h"
@interface FellowViewController ()
@property (nonatomic, strong) UIButton * LoginAndRegistBtn;
@end

@implementation FellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"关注";
    
    self.LoginAndRegistBtn.frame = CGRectMake(50, SCREEN_H/2, SCREEN_W - 100, 40);
    [self.view addSubview:self.LoginAndRegistBtn];
}

-(void)LoginClickss:(UIButton *)btn{
   
    HHPatientDataViewController * LoginVC = [HHPatientDataViewController new];
    [self.navigationController pushViewController:LoginVC animated:YES];

}
#pragma mark - 登录注册按钮
-(UIButton *)LoginAndRegistBtn{
    if (_LoginAndRegistBtn == nil) {
        _LoginAndRegistBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _LoginAndRegistBtn.backgroundColor = [UIColor whiteColor];
        [_LoginAndRegistBtn setTitle:@"立即登录注册" forState:UIControlStateNormal];
        [_LoginAndRegistBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_LoginAndRegistBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_LoginAndRegistBtn addTarget:self action:@selector(LoginClickss:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginAndRegistBtn;
}
@end
