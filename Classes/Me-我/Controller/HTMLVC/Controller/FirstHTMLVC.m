//
//  FirstHTMLVC.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "FirstHTMLVC.h"
#import "PrefixHeader.pch"
@interface FirstHTMLVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * my_webView;
@end

@implementation FirstHTMLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"My First HTML";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.858 green:0.916 blue:0.886 alpha:1.000]];
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self createUI];
    
}
-(void)createUI{
    self.my_webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [self.view addSubview:self.my_webView];
    [self.my_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.99test.xingyun.net/index.php?r=newmeeting/info&id=1021&is_app=1&225"]]];
//    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"Untitled-1" ofType:@"html"];
//    NSString * htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.my_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];

}
#pragma mark - webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载出错"];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

   // NSString * requestString = [[request URL] absoluteString];
    return YES;

}
#pragma mark - 懒加载
-(UIWebView *)my_webView{
    if (_my_webView == nil) {
        _my_webView = [UIWebView new];
        _my_webView.backgroundColor = [UIColor whiteColor];
        _my_webView.delegate = self;
        _my_webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _my_webView.scalesPageToFit = YES;
        _my_webView.multipleTouchEnabled = YES;
        _my_webView.userInteractionEnabled = YES;
    }
    return _my_webView;
}
@end
