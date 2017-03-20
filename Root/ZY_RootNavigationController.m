//
//  ZY_RootNavigationController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_RootNavigationController.h"

@interface ZY_RootNavigationController ()

@end

@implementation ZY_RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:1.000 green:0.158 blue:0.176 alpha:1.000];
   
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字属性
    NSMutableDictionary *textAttrs            = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //textAttrs[NSFontAttributeName]            = ECG_AUTO_FONT_16;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
// 重写push方法,方便统一处理返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 判断下是否是根控制器
    
    if (self.childViewControllers.count != 0) { // 非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条左边的按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewControllerBack"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}
// 返回到上一个界面
- (void)back
{
    [self popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
