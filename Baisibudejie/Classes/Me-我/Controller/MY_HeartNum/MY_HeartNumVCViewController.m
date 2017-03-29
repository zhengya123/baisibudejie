//
//  MY_HeartNumVCViewController.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/24.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "MY_HeartNumVCViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HeartBeat.h"
#import "HeartLive.h"
#import "UIImage+GIF.h"
@interface MY_HeartNumVCViewController ()<HeartBeatPluginDelegate>

@property (strong, nonatomic) HeartLive *live;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel * errorLabel;
@property (nonatomic, strong) UIButton * startBtn;
@property (nonatomic, strong) UISlider * changeLevelSlide;

@end

@implementation MY_HeartNumVCViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[HeartBeat shareManager] stop];
     [UIApplication sharedApplication].idleTimerDisabled = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.live = [[HeartLive alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150)];
    [self.view addSubview:self.live];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    self.label.layer.borderColor = [UIColor blackColor].CGColor;
    self.label.layer.borderWidth = 1;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:28];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 60)];
    self.errorLabel.textColor = [UIColor blackColor];
    self.errorLabel.font = [UIFont systemFontOfSize:20];
    self.errorLabel.text = @"请将手指覆盖住后置摄像头和闪光灯";
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.numberOfLines = 0;
    [self.view addSubview:self.errorLabel];

    self.startBtn.frame = CGRectMake(SCREEN_W/2 - 70, CGRectGetMaxY(self.errorLabel.frame) + 20, 140, 140);
    [self.view addSubview:self.startBtn];
    
//    self.changeLevelSlide.frame = CGRectMake(20, CGRectGetMaxY(self.startBtn.frame) + 20, SCREEN_W - 40, 20);
//    [self.view addSubview:self.changeLevelSlide];
    //开启测心率方法
    [HeartBeat shareManager].delegate = self;
        /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [[HeartBeat shareManager]stop];
     });
     
     */
}
-(void)startBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self startHeat:btn.selected];
}
-(void)startHeat:(BOOL)isstart{
    if (isstart) {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        [self.startBtn setBackgroundImage:[UIImage sd_animatedGIFNamed:@"screenShotTwo"] forState:UIControlStateNormal];
        [self.startBtn setTitle:@"结束" forState:UIControlStateNormal];
         [[HeartBeat shareManager] start];
       
//         [[HeartBeat shareManager] startHeartRatePoint:^(NSDictionary *point) {
//         
//         } Frequency:^(NSInteger fre) {
//         dispatch_async(dispatch_get_main_queue(), ^{
//             if (fre <= 0) {
//                 
//                 self.label.text = [NSString stringWithFormat:@"%ld次/分，心率小于0，别测了，你已经死了",(long)fre];
//             }else if (fre >= 300){
//                 self.label.text = [NSString stringWithFormat:@"%ld次/分，那么快",(long)fre];
//             }else{
//             
//                 self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)fre];
//             }
//         self.errorLabel.text = @"正在安静的测,深呼吸";
//         });
//         
//         } Error:^(NSError *error) {
//         self.errorLabel.text = @"不要移动手指\n 请将手指覆盖住后置摄像头和闪光灯";
//         }];
        

    }else{
         [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.startBtn setBackgroundImage:[ZY_Method imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
         [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [[HeartBeat shareManager] stop];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[HeartBeat shareManager]stop];
//        });

    }

}
#pragma mark - 测心率回调
- (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    
    self.errorLabel.text = @"正在安静的测,深呼吸";
    NSNumber *n = [[point allValues] firstObject];
    //拿到的数据传给心电图View
    [self.live drawRateWithPoint:n];
    NSLog(@" == %@",point);
    
}

- (void)startHeartDelegateRateError:(NSError *)error {
    
    self.errorLabel.text = @"不要移动手指\n 请将手指覆盖住后置摄像头和闪光灯";
    NSLog(@"error == %@",error);
}

- (void)startHeartDelegateRateFrequency:(NSInteger)frequency {
   // NSLog(@"\n瞬时心率：%ld",frequency);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (frequency <= 0) {
            self.label.text = [NSString stringWithFormat:@"%ld次/分，心率小于0，别测了，你已经死了",(long)frequency];
        }else if (frequency >= 300){
            self.label.text = [NSString stringWithFormat:@"%ld次/分，那么快",(long)frequency];
        }else{
            
            self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)frequency];
        }
       
    });

}
-(void)sliderChangeClick:(UISlider *)slider{
    NSLog(@"%f",slider.value);
    [[HeartBeat shareManager] chageLightLevel:slider.value];

}
-(UIButton *)startBtn{
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[ZY_Method imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.layer.masksToBounds = YES;
        _startBtn.layer.cornerRadius  = 70;
        
    }
    return _startBtn;
}
-(UISlider *)changeLevelSlide{
    if (_changeLevelSlide == nil) {
        _changeLevelSlide = [UISlider new];
        _changeLevelSlide.minimumTrackTintColor = [UIColor blueColor];
        _changeLevelSlide.maximumTrackTintColor = [UIColor whiteColor];
        [_changeLevelSlide setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        _changeLevelSlide.minimumValue = 0;
        _changeLevelSlide.maximumValue = 1;
        [_changeLevelSlide addTarget:self action:@selector(sliderChangeClick:) forControlEvents:UIControlEventValueChanged];
       // [_changeLevelSlide addTarget:self action:@selector(sliderLoseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeLevelSlide;
    
}

@end
