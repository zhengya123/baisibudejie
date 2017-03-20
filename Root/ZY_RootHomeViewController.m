//
//  ZY_RootHomeViewController.m
//  Baisibudejie
//
//  Created by dqong on 2016/11/1.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_RootHomeViewController.h"
#import "PrefixHeader.pch"
@interface ZY_RootHomeViewController ()

@property (nonatomic, strong) UIImageView * imageV;
@property (nonatomic, strong) UILabel     * imageLabel;
@end

@implementation ZY_RootHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NoNetImage.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [self.view addSubview:self.NoNetImage];
    self.imageV.frame = CGRectMake(SCREEN_W/2 - 50, SCREEN_H/2 - 50, 100, 100);
    [self.NoNetImage addSubview:self.imageV];
    self.imageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame), SCREEN_W, 40);
    [self.NoNetImage addSubview:self.imageLabel];
    self.NoNetImage.hidden = YES;
    
}
-(UIView *)NoNetImage{
    if (_NoNetImage == nil) {
        _NoNetImage = [UIView new];
        _NoNetImage.backgroundColor = [UIColor whiteColor];
    }
    return _NoNetImage;
}
-(UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [UIImageView new];
        _imageV.image = [UIImage imageNamed:@"yxs_playBack_nomessage"];
    }
    return _imageV;
}
-(UILabel *)imageLabel{
    if (_imageLabel == nil) {
        _imageLabel = [UILabel new];
        _imageLabel.backgroundColor = [UIColor clearColor];
        _imageLabel.textAlignment = NSTextAlignmentCenter;
        _imageLabel.textColor = [UIColor blackColor];
        _imageLabel.font = [UIFont systemFontOfSize:15];
        _imageLabel.text = @"咦，好像没网了";
    }
    return _imageLabel;
}
@end
