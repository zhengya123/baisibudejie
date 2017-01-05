//
//  OtherViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "OtherViewController.h"
#import "PrefixHeader.pch"
#import "UIView+UIView_ZYExtension.h"
#import "CAReplicatorLayerAnimal.h"

#define popTime 0.15
@interface OtherViewController ()
@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UIButton * clickBtn;
@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, strong) UIView * testAnimalView1;
@property (nonatomic, strong) UIView * testAnimalView2;
@property (nonatomic, strong) UIView * testAnimalView3;
@property (nonatomic, strong) UIView * testAnimalView4;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButton];
    self.backBtn.frame = CGRectMake(SCREEN_W/2 - 25, SCREEN_H - 100, 50, 50);
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.clickBtn];
    
    
    [self.view addSubview:self.testAnimalView1];
    [self.view addSubview:self.testAnimalView2];
    [self.view addSubview:self.testAnimalView3];
    [self.view addSubview:self.testAnimalView4];
   
}


-(void)createButton{
    //循环创建按钮
    for (NSInteger i = 0; i<5; i++)
    {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - 100 ,SCREEN_H - 100, 60, 60)];
        //标记tag
        button.tag = 100+i;
        button.backgroundColor = [UIColor orangeColor];
        NSString *string = [NSString stringWithFormat:@"%ld",i];
        [button setTitle:string forState:UIControlStateNormal];
        button.layer.cornerRadius = 30;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.buttonArray addObject:button];
    }


}
-(void)action:(UIButton*)button{
    NSLog(@"%ld",button.tag - 100);
}
/**
 弹出
 */
- (void)show
{   self.clickBtn.enabled = NO;
    //旋转弹出按钮
    [UIView animateWithDuration:popTime animations:^{
        self.clickBtn.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    }];
    
    //取出按钮，添加动画
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //位移动画
        UIButton *button = self.buttonArray[idx];
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
        anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.clickBtn.zy_centerX, self.clickBtn.zy_centerY)];
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.zy_centerX, self.view.zy_centerY + 80 * idx - 250)];
        anima.duration = popTime;
        anima.fillMode = kCAFillModeForwards;
        anima.removedOnCompletion = NO;
        anima.beginTime = CACurrentMediaTime() + 0.02 * idx;
        [button.layer addAnimation:anima forKey:nil];
        //缩放动画
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.duration = popTime;
        scaleAnima.fromValue = @0;
        scaleAnima.toValue = @1;
        scaleAnima.fillMode = kCAFillModeForwards ;
        scaleAnima.removedOnCompletion = NO ;
        scaleAnima.beginTime = CACurrentMediaTime() + 0.02 * idx;
        [button.layer addAnimation:scaleAnima forKey:nil];
        //等动画结束后，改变按钮真正位置
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(popTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.clickBtn.enabled = YES;
            button.center = CGPointMake(self.view.zy_centerX,  self.view.zy_centerY + 80 * idx - 250);
        });
    }];
}

/**
 隐藏
 */
- (void)dismiss
{
    
    self.clickBtn.enabled = NO;
    [UIView animateWithDuration:popTime animations:^{
        self.clickBtn.transform = CGAffineTransformMakeRotation(0);
    }];
    
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = self.buttonArray[idx];
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
        anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.zy_centerX, self.view.zy_centerY + 80 * idx - 250)];
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.clickBtn.zy_centerX, self.clickBtn.zy_centerY)];
        anima.duration = popTime;
        anima.fillMode = kCAFillModeForwards;
        anima.removedOnCompletion = NO;
        anima.beginTime = CACurrentMediaTime() + 0.02 * (4 - idx);
        [button.layer addAnimation:anima forKey:nil];
        
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.duration = popTime;
        scaleAnima.fromValue = @1;
        scaleAnima.toValue = @0;
        scaleAnima.fillMode = kCAFillModeForwards ;
        scaleAnima.removedOnCompletion = NO ;
        scaleAnima.beginTime = CACurrentMediaTime() + 0.02 * (4 - idx);
        [button.layer addAnimation:scaleAnima forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(popTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.clickBtn.enabled = YES;
            button.center = CGPointMake(self.clickBtn.zy_centerX,  self.clickBtn.zy_centerY);
        });
        
    }];
}

#pragma mark - 返回按钮点击事件
-(void)back_Click:(UIButton *)btn{

[self dismissViewControllerAnimated:YES completion:^{
    
}];

}
-(void)clickBtnClick:(UIButton *)btn{
    if (btn.selected == NO)
    {
        //弹出
        [self show];
        btn.selected = YES;
    }
    else
    {
        //消失
        [self dismiss];
        btn.selected = NO;
    }
    


}
#pragma mark - 返回按钮
-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"取消" forState:UIControlStateNormal];
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius  = 12;
        [_backBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_backBtn addTarget:self action:@selector(back_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;

}
-(UIButton *)clickBtn{
    if (_clickBtn == nil) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame = CGRectMake(SCREEN_W - 100, SCREEN_H - 100, 60, 60);
        [_clickBtn setBackgroundColor:[UIColor redColor]];
        _clickBtn.layer.masksToBounds = YES;
        _clickBtn.layer.cornerRadius  = 15;
        [_clickBtn addTarget:self action:@selector(clickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clickBtn;
}
-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}
-(UIView *)testAnimalView1{
    if (_testAnimalView1 == nil) {
        _testAnimalView1 = [UIView new];
        _testAnimalView1.frame = CGRectMake(20, 100, 100, 100);
        [_testAnimalView1.layer addSublayer:[CAReplicatorLayerAnimal replicatorLayer_Grid]];
    }
    return _testAnimalView1;
}
-(UIView *)testAnimalView2{
    if (_testAnimalView2 == nil) {
        _testAnimalView2 = [UIView new];
        _testAnimalView2.frame = CGRectMake(SCREEN_W - 120, 100, 100, 100);
        [_testAnimalView2.layer addSublayer:[CAReplicatorLayerAnimal replicatorLayer_Wave]];
    }
    return _testAnimalView2;
}
-(UIView *)testAnimalView3{
    if (_testAnimalView3 == nil) {
        _testAnimalView3 = [UIView new];
        _testAnimalView3.frame = CGRectMake(20, 300, 100, 100);
        [_testAnimalView3.layer addSublayer:[CAReplicatorLayerAnimal replicatorLayer_Circle]];
    }
    return _testAnimalView3;
}
-(UIView *)testAnimalView4{
    if (_testAnimalView4 == nil) {
        _testAnimalView4 = [UIView new];
        _testAnimalView4.frame = CGRectMake(SCREEN_W - 120, 300, 100, 100);
        [_testAnimalView4.layer addSublayer:[CAReplicatorLayerAnimal replicatorLayer_Triangle]];
    }
    return _testAnimalView4;
}
@end
