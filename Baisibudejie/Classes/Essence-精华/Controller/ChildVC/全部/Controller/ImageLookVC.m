//
//  ImageLookVC.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/16.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ImageLookVC.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@interface ImageLookVC ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView  * imageView;
@property (nonatomic, strong) UIButton     * backBtn;


@end

@implementation ImageLookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * stateBarBlockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    stateBarBlockView.backgroundColor = [UIColor redColor];
    [self.view addSubview:stateBarBlockView];
    
    [self createUI];
    
}
-(void)createUI{
    self.scrollView.frame = CGRectMake(0, 20, SCREEN_W, SCREEN_H - 20);
    self.imageView.frame = CGRectMake(0, 20, SCREEN_W, self.imageHeight * SCREEN_W - 20);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    self.scrollView.contentSize = CGSizeMake(0, self.imageHeight * SCREEN_W);
    
    self.backBtn.frame = CGRectMake(10, 23, 35, 35);
    [self.view addSubview:self.backBtn];
    
    [self.view makeToast:@"点击图片可以保存哦" duration:2 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];

}
-(void)backBtnClick:(UIButton *)btn{

    [self dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)saveToPhotoClick{
    UIActionSheet * alertSheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存到相册" otherButtonTitles:nil, nil];
    [alertSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self saveToPhoto];
    }

}
#pragma mark - 保存到相册
-(void)saveToPhoto{
UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString * message = nil;
    if (error != NULL) {
        message = @"图片保存失败";
    }else {
        message = @"图片保存成功";
    }
    [self.view makeToast:message duration:3 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];
}

#pragma mark - 懒加载
-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveToPhotoClick)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
    }
    return _scrollView;
}
-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end
