//
//  CoreLocationVC.m
//  Baisibudejie
//
//  Created by dqong on 2016/10/25.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "CoreLocationVC.h"
#import <CoreLocation/CoreLocation.h>
#import "PrefixHeader.pch"
#import "TXScrollLabelView.h"
@interface CoreLocationVC ()<CLLocationManagerDelegate,ZY_alertViewDelegate,TXScrollLabelViewDelegate>

@property (nonatomic, strong) UILabel * longitudeName;//经度
@property (nonatomic, strong) UILabel * longitude;
@property (nonatomic, strong) UILabel * latitudeName;//纬度
@property (nonatomic, strong) UILabel * latitude;
@property (nonatomic, strong) UILabel * altitudeName;//海拔
@property (nonatomic, strong) UILabel * altitude;
@property (nonatomic, strong) UILabel * speedName;//速度
@property (nonatomic, strong) UILabel * myspeed;
@property (nonatomic, strong) UILabel * courseName;//方向
@property (nonatomic, strong) UILabel * myCourse;

@property (nonatomic, strong) UILabel * locationInformation;//城市信息


@property (nonatomic, weak) LoadingViewForOC * loadingVC;
//位置管理器
@property(nonatomic,strong)CLLocationManager *locMgr;
//位置编码
@property(nonatomic, strong)CLGeocoder *coder;


@end

@implementation CoreLocationVC

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.locMgr stopUpdatingLocation];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的位置";
    
    
    //经度
    self.longitudeName.frame = CGRectMake(20, 100, 80, 40);
    [self.view addSubview:self.longitudeName];
    self.longitude.frame = CGRectMake(CGRectGetMaxX(self.longitudeName.frame) + 20, 100, SCREEN_W - CGRectGetMaxX(self.longitudeName.frame) - 40, 40);
    [self.view addSubview:self.longitude];
    
    //纬度
    self.latitudeName.frame = CGRectMake(20, CGRectGetMaxY(self.longitude.frame) + 20, 80, 40);
    [self.view addSubview:self.latitudeName];
    
    self.latitude.frame = CGRectMake(CGRectGetMaxX(self.latitudeName.frame) + 20, CGRectGetMaxY(self.longitudeName.frame) +20, SCREEN_W - CGRectGetMaxX(self.latitudeName.frame) - 40, 40);
    [self.view addSubview:self.latitude];
    
    //海拔
    self.altitudeName.frame = CGRectMake(20, CGRectGetMaxY(self.latitudeName.frame) + 20, 80, 40);
    [self.view addSubview:self.altitudeName];
    
    self.altitude.frame = CGRectMake(CGRectGetMaxX(self.altitudeName.frame) + 20, CGRectGetMaxY(self.latitudeName.frame)+20, SCREEN_W - CGRectGetMaxX(self.altitudeName.frame) - 40, 40);
    [self.view addSubview:self.altitude];
    
    //速度
    self.speedName.frame = CGRectMake(20, CGRectGetMaxY(self.altitudeName.frame) + 20, 80, 40);
    [self.view addSubview:self.speedName];
    
    self.myspeed.frame = CGRectMake(CGRectGetMaxX(self.speedName.frame) + 20, CGRectGetMaxY(self.altitudeName.frame) + 20, SCREEN_W - CGRectGetMaxX(self.speedName.frame) - 40, 40);
    [self.view addSubview:self.myspeed];
    
    //方向
    self.courseName.frame = CGRectMake(20, CGRectGetMaxY(self.myspeed.frame) + 20, 80, 40);
    [self.view addSubview:self.courseName];
    
    self.myCourse.frame = CGRectMake(CGRectGetMaxX(self.courseName.frame) + 20, CGRectGetMaxY(self.myspeed.frame) + 20, SCREEN_W - CGRectGetMaxX(self.courseName.frame) - 40, 40);
    [self.view addSubview:self.myCourse];
    
    //位置信息
    self.locationInformation.frame = CGRectMake(20, CGRectGetMaxY(self.courseName.frame) + 20, SCREEN_W - 40, 40);
    [self.view addSubview:self.locationInformation];
    //创建位置管理
    [self createLocationManager];
    //测试方法，计算两个位置之间的距离
    [self countDistance];
}
- (void)createLocationManager{
    
    
    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
       self.loadingVC = [LoadingViewForOC showLoadingWith:self.view];
        // iOS 8 之后添加 始终允许访问位置信息，请求允许在前后台都能获取用户位置的授权, 并在Info.Plist文件中配置Key ( Nslocationwheninuseusagedescription )
        [self.locMgr requestAlwaysAuthorization];
//        if ([[UIDevice currentDevice].systemVersion floatValue] > 9)
//        {
//            /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
//            [self.locMgr setAllowsBackgroundLocationUpdates:YES];
//        }

        //开始定位用户的位置
        [self.locMgr startUpdatingLocation];
        
        //每隔多少米定位一次（这里的设置为任何的移动）
        self.locMgr.distanceFilter = kCLDistanceFilterNone;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        self.locMgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        
    }else
    {//不能定位用户的位置
        //1.提醒用户检查当前的网络状况
        //2.提醒用户打开定位开关
        NSString * message = @"请在‘设置’->'通用'->'隐私'中将手机定位打开，并允许‘百思不得姐’获取位置信息！";
        ZY_AlertViews * zy_alertView = [[ZY_AlertViews alloc]initWithBackgroundImage:[ZY_Method imageWithColor:[UIColor colorWithRed:1.000 green:0.031 blue:0.020 alpha:0.689]] andTitle:@"提醒" andMsg:message andFont:[UIFont systemFontOfSize:18] asdRange:NSMakeRange(15, 2) andColor:[UIColor blackColor]];
        zy_alertView.Delegate = self;
        zy_alertView.msgLabel.textAlignment = NSTextAlignmentLeft;
        zy_alertView.msgLabel.font = [UIFont systemFontOfSize:15];
        zy_alertView.msgLabel.textColor = [UIColor whiteColor];
        [zy_alertView.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [zy_alertView.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [zy_alertView setButtonWithName:@"设置" backgroundImage:[ZY_Method imageWithColor:[UIColor colorWithRed:0.119 green:0.612 blue:0.801 alpha:1.000]] andSure:@"暂不" backgroundImage:[ZY_Method imageWithColor:[UIColor colorWithRed:0.819 green:0.812 blue:0.823 alpha:1.000]]];
        [zy_alertView show];
    }
    
}

//计算两个位置之间的距离
-(void)countDistance
{
    //根据经纬度创建两个位置对象
    CLLocation *loc1=[[CLLocation alloc]initWithLatitude:40 longitude:116];
    CLLocation *loc2=[[CLLocation alloc]initWithLatitude:41 longitude:116];
    //计算两个位置之间的距离
    CLLocationDistance distance=[loc1 distanceFromLocation:loc2];
    ZYLog(@"(%@)和(%@)的距离=%fM",loc1,loc2,distance);
}
#pragma mark-CLLocationManagerDelegate
/**
 *  当定位到用户的位置时，就会调用（调用的频率比较频繁）
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置，取出第一个位置
    CLLocation *loc =[locations firstObject];
    ZYLog(@"%@",loc.timestamp);
    
    //位置坐标
    CLLocationCoordinate2D coordinate=loc.coordinate;
    ZYLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",coordinate.longitude,coordinate.latitude,loc.altitude,loc.course,loc.speed);
    ZYLog(@"定位到了");
    self.longitude.text = [NSString stringWithFormat:@"%f",coordinate.longitude];
    self.latitude.text  = [NSString stringWithFormat:@"%f",coordinate.latitude];
    self.altitude.text  = [NSString stringWithFormat:@"%f",loc.altitude];
    self.myspeed.text   = [NSString stringWithFormat:@"%f",loc.speed];
    // 反编码
    [self.coder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        
        // 包含区，街道等信息的地标对象
        CLPlacemark *placemark = [placemarks firstObject];
        // 城市名称
        NSString *city = placemark.locality;
        // 街道名称
        NSString *street = placemark.thoroughfare;
        // 全称
        NSString *name = placemark.name;
        NSString *str = [NSString stringWithFormat:@"%@， %@， %@", name,city,street];
        ZYLog(@"城市信息%@", str);
        [self.loadingVC hideLoadingView];
        
        self.locationInformation.text = [NSString stringWithFormat:@"%@-%@",city,name];
        if ([ZY_Method heightWithString:str fontSize:15 width:SCREEN_W - 40] > 40) {
            
            self.locationInformation.frame = CGRectMake(20, CGRectGetMaxY(self.myCourse.frame) + 20, SCREEN_W - 40, [ZY_Method heightWithString:str fontSize:15 width:SCREEN_W - 40]);
        }else{
            self.locationInformation.frame = CGRectMake(20, CGRectGetMaxY(self.myCourse.frame) + 20, SCREEN_W - 40, 40);
        }
        
    }];
    
    //停止更新位置（如果定位服务不需要实时更新的话，那么应该停止位置的更新）
   // [self.locMgr stopUpdatingLocation];
    
}
#pragma mark - 定位错误的代理方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.loadingVC hideLoadingView];
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        ZYLog(@"访问被拒绝");
        [self.view makeToast:@"访问被拒绝" duration:2.0 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        ZYLog(@"无法获取位置信息");
        [self.view makeToast:@"无法获取位置信息" duration:2.0 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];
    }
}
#pragma mark - 弹框代理
-(void)alertTips:(id)alertTips buttonClickedAtIndex:(int)buttonIndex{
    if (buttonIndex == 0) {
        ZYLog(@"设置");
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
    }else{
        ZYLog(@"暂不");
    }

}
#pragma mark-懒加载
- (CLLocationManager *)locMgr{
    if (!_locMgr ) {
        
        //1.创建位置管理器（定位用户的位置）
        self.locMgr=[[CLLocationManager alloc]init];
        //2.设置代理
        self.locMgr.delegate=self;
    }
    return _locMgr;
}

// 位置编码
- (CLGeocoder *)coder{
    
    // _coder == nil
    if (!_coder) {
        
        self.coder = [[CLGeocoder alloc] init];
    }
    return _coder;
}
//经度
-(UILabel *)longitudeName{
    if (_longitudeName == nil) {
        _longitudeName = [UILabel new];
        _longitudeName.textAlignment = NSTextAlignmentCenter;
        _longitudeName.textColor = [UIColor blackColor];
        _longitudeName.backgroundColor = [UIColor yellowColor];
        _longitudeName.font = [UIFont systemFontOfSize:15];
        _longitudeName.layer.masksToBounds = YES;
        _longitudeName.layer.cornerRadius  = 8;
        _longitudeName.text = @"经度";
    }
    return _longitudeName;
}
-(UILabel *)longitude{
    if (_longitude == nil) {
        _longitude = [UILabel new];
        _longitude.textColor = [UIColor blackColor];
        _longitude.textAlignment = NSTextAlignmentCenter;
        _longitude.backgroundColor = [UIColor colorWithRed:119/255.0 green:171/255.0 blue:255/155.0 alpha:1.0];
        _longitude.font = [UIFont systemFontOfSize:15];
        _longitude.layer.masksToBounds = YES;
        _longitude.layer.cornerRadius  = 8;
    }
    return _longitude;
}
//纬度
-(UILabel *)latitudeName{
    if (_latitudeName == nil) {
        _latitudeName = [UILabel new];
        _latitudeName.textAlignment = NSTextAlignmentCenter;
        _latitudeName.textColor = [UIColor blackColor];
        _latitudeName.backgroundColor = [UIColor colorWithRed:168/255.0 green:255/255.0 blue:163/255.0 alpha:1.0];
        _latitudeName.font = [UIFont systemFontOfSize:15];
        _latitudeName.layer.masksToBounds = YES;
        _latitudeName.layer.cornerRadius  = 8;
        _latitudeName.text = @"纬度";
    }
    return _latitudeName;
}
-(UILabel *)latitude{
    if (_latitude == nil) {
        _latitude = [UILabel new];
        _latitude.textColor = [UIColor blackColor];
        _latitude.textAlignment = NSTextAlignmentCenter;
        _latitude.backgroundColor = [UIColor colorWithRed:121/255.0 green:244/255.0 blue:255/255.0 alpha:1.0];
        _latitude.font = [UIFont systemFontOfSize:15];
        _latitude.layer.masksToBounds = YES;
        _latitude.layer.cornerRadius  = 8;
    }
    return _latitude;
}
//纬度
-(UILabel *)altitudeName{
    if (_altitudeName == nil) {
        _altitudeName = [UILabel new];
        _altitudeName.textAlignment = NSTextAlignmentCenter;
        _altitudeName.textColor = [UIColor blackColor];
        _altitudeName.backgroundColor = [UIColor colorWithRed:168/255.0 green:255/255.0 blue:227/255.0 alpha:1.0];
        _altitudeName.font = [UIFont systemFontOfSize:15];
        _altitudeName.layer.masksToBounds = YES;
        _altitudeName.layer.cornerRadius  = 8;
        _altitudeName.text = @"海拔";
    }
    return _altitudeName;
}
//海拔
-(UILabel *)altitude{
    if (_altitude == nil) {
        _altitude = [UILabel new];
        _altitude.textColor = [UIColor blackColor];
        _altitude.textAlignment = NSTextAlignmentCenter;
        _altitude.backgroundColor = [UIColor colorWithRed:227/255.0 green:181/255.0 blue:240/255.0 alpha:1.0];
        _altitude.font = [UIFont systemFontOfSize:15];
        _altitude.layer.masksToBounds = YES;
        _altitude.layer.cornerRadius  = 8;
    }
    return _altitude;
}
-(UILabel *)speedName{
    if (_speedName == nil) {
        _speedName = [UILabel new];
        _speedName.textAlignment = NSTextAlignmentCenter;
        _speedName.textColor = [UIColor blackColor];
        _speedName.backgroundColor = [UIColor colorWithRed:0.830 green:1.000 blue:0.493 alpha:1.000];
        _speedName.font = [UIFont systemFontOfSize:15];
        _speedName.layer.masksToBounds = YES;
        _speedName.layer.cornerRadius  = 8;
        _speedName.text = @"速度";
    }
    return _speedName;
}
-(UILabel *)myspeed{
    if (_myspeed == nil) {
        _myspeed = [UILabel new];
        _myspeed.textColor = [UIColor blackColor];
        _myspeed.textAlignment = NSTextAlignmentCenter;
        _myspeed.backgroundColor = [UIColor colorWithRed:0.000 green:0.834 blue:0.943 alpha:1.000];
        _myspeed.font = [UIFont systemFontOfSize:15];
        _myspeed.layer.masksToBounds = YES;
        _myspeed.layer.cornerRadius  = 8;
    }
    return _myspeed;
}
-(UILabel *)courseName{
    if (_courseName == nil) {
        _courseName = [UILabel new];
        _courseName.textAlignment = NSTextAlignmentCenter;
        _courseName.textColor = [UIColor blackColor];
        _courseName.backgroundColor = [UIColor colorWithRed:1.000 green:0.520 blue:0.000 alpha:1.000];
        _courseName.font = [UIFont systemFontOfSize:15];
        _courseName.layer.masksToBounds = YES;
        _courseName.layer.cornerRadius  = 8;
        _courseName.text = @"方向";
    }
    return _courseName;
}
-(UILabel *)myCourse{
    if (_myCourse == nil) {
        _myCourse = [UILabel new];
        _myCourse.textColor = [UIColor blackColor];
        _myCourse.textAlignment = NSTextAlignmentCenter;
        _myCourse.backgroundColor = [UIColor colorWithRed:0.936 green:0.872 blue:0.859 alpha:1.000];
        _myCourse.font = [UIFont systemFontOfSize:15];
        _myCourse.layer.masksToBounds = YES;
        _myCourse.layer.cornerRadius  = 8;
    }
    return _myCourse;
}

//地理位置信息
-(UILabel *)locationInformation{
    if (_locationInformation == nil) {
        _locationInformation = [UILabel new];
        _locationInformation.backgroundColor = [UIColor colorWithRed:179/255.0 green:214/255.0 blue:255/255.0 alpha:1.0];
        _locationInformation.textAlignment = NSTextAlignmentCenter;
        _locationInformation.textColor = [UIColor blackColor];
        _locationInformation.font = [UIFont systemFontOfSize:15];
        _locationInformation.layer.masksToBounds = YES;
        _locationInformation.layer.cornerRadius  = 8;
        _locationInformation.numberOfLines = 0;
    }
    return _locationInformation;
}

@end
