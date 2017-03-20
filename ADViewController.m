//
//  ADViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ADViewController.h"
#import "PrefixHeader.pch"
#import "AppDelegate.h"
#import "ZY_RootTabBarController.h"
@interface ADViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIButton  * backBtn;
@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.AD_URL]]];
    
    self.backBtn.frame = CGRectMake(10, 30, 40, 40);
    [self.view addSubview:self.backBtn];
}
-(void)back_btn:(UIButton *)btn{

    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ZY_RootTabBarController * rootTabBar = [ZY_RootTabBarController new];
    appdelegate.window.rootViewController = rootTabBar;

}
#pragma mark - webView
-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back_btn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end
