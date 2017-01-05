//
//  LoginViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/9.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "LoginViewController.h"
#import "PrefixHeader.pch"
#import "ZY_textField_View.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSTimer * time;

}
@property (nonatomic, strong) UIImageView * bg_imageView;
@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UIButton * registBtn;
@property (nonatomic, strong) UIButton * LoginBtn;
@property (nonatomic, strong) UIButton * forGotPassWordBtn;
@property (nonatomic, strong) ZY_textField_View * LoginNameTextField;
@property (nonatomic, strong) ZY_textField_View * LoginPassWordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.353 alpha:0.971];
    [self createUI];
}
-(void)createUI{
    [self.view addSubview:self.bg_imageView];
    //返回按钮
    self.backBtn.frame = CGRectMake(20, 35, 25, 25);
    [self.view addSubview:self.backBtn];
    
    //注册按钮
    self.registBtn.frame = CGRectMake(SCREEN_W - 100, 30, 80, 40);
    [self.view addSubview:self.registBtn];
    
    //账号和密码
    self.LoginNameTextField.frame = CGRectMake(30, 200, SCREEN_W - 60, 40);
    self.LoginPassWordTextField.frame = CGRectMake(30, self.LoginNameTextField.frame.size.height + self.LoginNameTextField.frame.origin.y + 20, SCREEN_W - 60, 40);
    [self.view addSubview:self.LoginNameTextField];
    [self.view addSubview:self.LoginPassWordTextField];
    
    //登陆按钮
    self.LoginBtn.frame = CGRectMake(30, self.LoginPassWordTextField.frame.size.height + self.LoginPassWordTextField.frame.origin.y + 50, SCREEN_W - 60, 40);
    [self.view addSubview:self.LoginBtn];
    
    //忘记密码按钮
    self.forGotPassWordBtn.frame = CGRectMake(SCREEN_W - 140, self.LoginBtn.frame.size.height + self.LoginBtn.frame.origin.y, 90, 40);
    [self.view addSubview:self.forGotPassWordBtn];
   
    //快速登录
    ZY_button * QQBtn = [ZY_button buttonWithType:UIButtonTypeCustom frame:CGRectMake(20, SCREEN_H - 110, 80, 100) title:@"QQ登录" titleColor:[UIColor whiteColor] titleFont:15 textAlignment:NSTextAlignmentCenter image:[UIImage imageNamed:@"login_QQ_icon"] imageViewContentMode:UIViewContentModeLeft handler:^(UIButton *sender) {
        ZYLog(@"QQ点击事件");
    }];

    ZY_button * weiboBtn = [ZY_button buttonWithType:UIButtonTypeCustom frame:CGRectMake(SCREEN_W/2 - 40, SCREEN_H - 110, 80, 100) title:@"微博登录" titleColor:[UIColor whiteColor] titleFont:15 textAlignment:NSTextAlignmentCenter image:[UIImage imageNamed:@"login_sina_icon"] imageViewContentMode:UIViewContentModeLeft handler:^(UIButton *sender) {
        ZYLog(@"weibo点击事件");
    }];
    
    ZY_button * tengxunBtn = [ZY_button buttonWithType:UIButtonTypeCustom frame:CGRectMake(SCREEN_W - 100, SCREEN_H - 110, 80, 100) title:@"腾讯登录" titleColor:[UIColor whiteColor] titleFont:15 textAlignment:NSTextAlignmentCenter image:[UIImage imageNamed:@"login_tecent_icon"] imageViewContentMode:UIViewContentModeLeft handler:^(UIButton *sender) {
        ZYLog(@"tengxun点击事件");
    }];
    [self.view addSubview:QQBtn];
    [self.view addSubview:weiboBtn];
    [self.view addSubview:tengxunBtn];
}
#pragma mark - 登陆按钮
-(void)LoginClick:(UIButton *)btn{
    [self.LoginBtn setTitle:@"正在登录中。。。" forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults]setObject:self.LoginPassWordTextField.textField.text forKey:@"UserPassWord"];
    //模拟登陆
    time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timers) userInfo:nil repeats:YES];
   [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
//    
//    [UIView animateWithDuration:1.0f animations:^{
//        window.alpha = 0;
//        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//    } completion:^(BOOL finished) {
//        exit(0);
//    }];
}
-(void)timers{
    [time invalidate];
    time = nil;
    [self.LoginBtn setTitle:@"登    陆" forState:UIControlStateNormal];
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ZY_RootTabBarController * rootTabBar = [ZY_RootTabBarController new];
    appdelegate.window.rootViewController = rootTabBar;

}
#pragma mark - 返回按钮
-(void)backClick:(UIButton *)btn{

    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - 注册按钮
-(void)registClick:(UIButton *)btn{
    ZYLog(@"跳转到注册界面--暂未开发");

}
#pragma mark - 忘记密码
-(void)ForgotPassWordClick:(UIButton *)btn{

    ZYLog(@"忘记密码按钮");

}
#pragma mark - lan
-(UIImageView *)bg_imageView{
    if (_bg_imageView == nil) {
        _bg_imageView = [UIImageView new];
        _bg_imageView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        _bg_imageView.image = [UIImage imageNamed:@"login_register_background"];
    }
    return _bg_imageView;

}
-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backBtn;
}
-(UIButton *)registBtn{
    if (_registBtn == nil) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}
-(ZY_textField_View *)LoginNameTextField{
    if (_LoginNameTextField == nil) {
        _LoginNameTextField = [ZY_textField_View new];
        _LoginNameTextField.ly_placeholder = @"用户名";
        _LoginNameTextField.tag = 0;
        
    }
    return _LoginNameTextField;
}
-(ZY_textField_View *)LoginPassWordTextField{
    if (_LoginPassWordTextField == nil) {
        _LoginPassWordTextField = [ZY_textField_View new];
        _LoginPassWordTextField.ly_placeholder = @"密码";
        _LoginPassWordTextField.tag = 1;
        
    }
    return _LoginPassWordTextField;
}
-(UIButton *)LoginBtn{
    if (_LoginBtn == nil) {
        _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_LoginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtnBg"] forState:UIControlStateNormal];
        [_LoginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtnBgClick"] forState:UIControlStateHighlighted];
        [_LoginBtn setTitle:@"登    陆" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       // _LoginBtn.layer.masksToBounds = YES;
       // _LoginBtn.layer.cornerRadius  = 8;
        [_LoginBtn addTarget:self action:@selector(LoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginBtn;
}
-(UIButton *)forGotPassWordBtn{
    if (_forGotPassWordBtn == nil) {
        _forGotPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forGotPassWordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forGotPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_forGotPassWordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forGotPassWordBtn addTarget:self action:@selector(ForgotPassWordClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forGotPassWordBtn;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [time invalidate];
    time = nil;

}
@end
