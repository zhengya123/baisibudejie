//
//  PersonalViewController.m
//  Baisibudejie
//
//  Created by dqong on 2016/10/31.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "PersonalViewController.h"
#import "PrefixHeader.pch"
#import "CoreLocationVC.h"
#import "ZY_RootNavigationController.h"
#import "HHPatientDataViewController.h"
#import "HHjiujiuHomeViewController.h"
#import "MY_MapVC.h"
#import "FirstHTMLVC.h"
#import "TeamSearchVC.h"
#import "UINavigationController+WXSTransition.h"
#import "TXScrollLabelView.h"
#define zytitle @"cities"
#define zytitleName @"titleName"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,TXScrollLabelViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray     * titles;
@property (nonatomic, strong) UIView      * titleView;
@property (nonatomic, strong) UIView      * footView;
@property (nonatomic, strong) UIImageView * titleTopView;
@property (nonatomic, strong) UIView      * buttonLine;
@property (nonatomic, strong) UIView      * titleButtonView;
@property (nonatomic, strong) UIButton    * outPatientTime_button;
@property (nonatomic, strong) UIButton    * articleManage_button;
@property (nonatomic, strong) UIButton    * titleImageView;
@property (nonatomic, strong) UILabel     * titlename_Label;
@property (nonatomic, strong) UILabel     * zhicheng_Label;
@property (nonatomic, strong) UILabel     * area_Label;
@property (nonatomic, strong) UILabel     * State_Label;
@property (nonatomic, strong) TXScrollLabelView * scrollViewTitleView;
@end

@implementation PersonalViewController

-(void)viewWillAppear:(BOOL)animated{
   // [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
   // [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setBackgroundImage:[ZY_Method imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.title = @"个人信息";
    [self createUI];
}
-(void)createUI{
    
    self.titleView.frame = CGRectMake(0, 0, SCREEN_W, 325);
    self.titleTopView.frame = CGRectMake(0, 0, SCREEN_W, 225);
    self.titleImageView.frame = CGRectMake(SCREEN_W/2 - 25, 74, 50, 50);
    self.titlename_Label.frame = CGRectMake(0, self.titleImageView.frame.size.height + self.titleImageView.frame.origin.y + 10, SCREEN_W/2-20, 30);
    self.zhicheng_Label.frame = CGRectMake(SCREEN_W/2, self.titleImageView.frame.size.height + self.titleImageView.frame.origin.y + 10, SCREEN_W/2, 30);
    self.area_Label.frame = CGRectMake(0, self.zhicheng_Label.frame.size.height + self.zhicheng_Label.frame.origin.y - 10, SCREEN_W, 30);
    self.State_Label.frame = CGRectMake(0, self.area_Label.frame.size.height + self.area_Label.frame.origin.y + 5, SCREEN_W, 30);
    
    [self.titleTopView addSubview:self.State_Label];
    [self.titleTopView addSubview:self.area_Label];
    [self.titleTopView addSubview:self.titlename_Label];
    [self.titleTopView addSubview:self.zhicheng_Label];
    [self.titleTopView addSubview:self.titleImageView];
    
    self.titleButtonView.frame = CGRectMake(0, CGRectGetMaxY(self.titleTopView.frame), SCREEN_W, 50);
    self.outPatientTime_button.frame = CGRectMake(0, 0, SCREEN_W/2 - 1, 50);
    self.buttonLine.frame = CGRectMake(SCREEN_W/2, 10, 1, 30);
    self.articleManage_button.frame = CGRectMake(SCREEN_W/2 + 1, 0, SCREEN_W/2-1, 50);
    
    [self.titleButtonView addSubview:self.buttonLine];
    [self.titleButtonView addSubview:self.outPatientTime_button];
    [self.titleButtonView addSubview:self.articleManage_button];
    
    
    self.scrollViewTitleView = [TXScrollLabelView scrollWithTitle:@"这是一个广告屏，你可以看，也可以不看，it's or you" type:TXScrollLabelViewTypeLeftRight velocity:1];
    self.scrollViewTitleView.frame = CGRectMake(0, CGRectGetMaxY(self.titleButtonView.frame) + 10, SCREEN_W, 40);
    self.scrollViewTitleView.backgroundColor = [UIColor whiteColor];
    self.scrollViewTitleView.scrollTitleColor = [UIColor blackColor];
    self.scrollViewTitleView.scrollLabelViewDelegate = self;
    
    [self.titleView addSubview:self.titleButtonView];
    [self.titleView addSubview:self.titleTopView];
    [self.titleView addSubview:self.scrollViewTitleView];
    
    [self.scrollViewTitleView beginScrolling];
    self.tableView.tableHeaderView = self.titleView;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.area_Label.text = [NSString stringWithFormat:@"手机型号 ：%@",[ZY_Method iphoneType]];
    
}

#pragma mark - 我的地图按钮点击方法
-(void)outPatientTime_buttonClick:(UIButton *)sender{
    ZYLog(@"进入了我的地图");
    MY_MapVC * my_map = [MY_MapVC new];
    [self.navigationController pushViewController:my_map animated:YES];
   
}
-(void)articleManage_buttonClick:(UIButton *)sender{
   ZYLog(@"地理位置");
   CoreLocationVC  * locationVC = [CoreLocationVC new];
   // ZY_RootNavigationController * nav = [[ZY_RootNavigationController alloc]initWithRootViewController:locationVC];
   [self.navigationController pushViewController:locationVC animated:YES];
}
#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary * province = self.titles[section];
    NSArray * citice = province[zytitle];
    return citice.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    NSDictionary * provice = self.titles[indexPath.section];
    NSArray * citys = provice[zytitle];
    cell.textLabel.text = [citys[indexPath.row]objectForKey:zytitleName];
    cell.textLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                FirstHTMLVC * firstHTML = [FirstHTMLVC new];
                [self.navigationController pushViewController:firstHTML animated:YES];
                
            }
                break;
            case 1:
            {
                HHPatientDataViewController * vc = [HHPatientDataViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                case 2:
            {
                HHjiujiuHomeViewController * jiujiuVC = [HHjiujiuHomeViewController new];
                [self.navigationController pushViewController:jiujiuVC animated:YES];
                
            }
                break;
                case 3:
            {
                TeamSearchVC * vc = [TeamSearchVC new];
                // [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysCameraIrisHollowOpen];
                [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
                    transition.animationType = WXSTransitionAnimationTypeSysCameraIrisHollowOpen;
                    transition.animationTime = 2.0;
                }];
                // [self.navigationController pushViewController:vc animated:YES];
            
            }
            default:
                break;
        }

    }
    
    
}
#pragma mark - lan
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, SCREEN_W, SCREEN_H + 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    }
    
    return _tableView;
}
-(UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [UIView new];
        _titleView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.000];
    }
    return _titleView;
    
}
-(UIView *)titleButtonView{
    if (_titleButtonView == nil) {
        _titleButtonView = [UIView new];
        _titleButtonView.backgroundColor = [UIColor whiteColor];
    }
    return _titleButtonView;
}
-(UIButton *)outPatientTime_button{
    if (_outPatientTime_button == nil) {
        _outPatientTime_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_outPatientTime_button setTitle:@"我的地图" forState:UIControlStateNormal];
        [_outPatientTime_button setTitleColor:[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:1.0] forState:UIControlStateNormal];
        _outPatientTime_button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_outPatientTime_button addTarget:self action:@selector(outPatientTime_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _outPatientTime_button;
}
-(UIButton *)articleManage_button{
    if (_articleManage_button == nil) {
        _articleManage_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_articleManage_button setTitle:@"地理信息" forState:UIControlStateNormal];
        [_articleManage_button setTitleColor:[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:1.0] forState:UIControlStateNormal];
        _articleManage_button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_articleManage_button addTarget:self action:@selector(articleManage_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _articleManage_button;
}
-(UIView *)buttonLine{
    if (_buttonLine == nil) {
        _buttonLine = [UIView new];
        _buttonLine.backgroundColor = [UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:1.0];
        
    }
    return _buttonLine;
    
}
-(UIImageView *)titleTopView{
    if (_titleTopView == nil) {
        _titleTopView = [UIImageView new];
        _titleTopView.image = [ZY_Method imageWithColor:[UIColor colorWithRed:1.000 green:0.158 blue:0.176 alpha:1.000]];
    }
    return _titleTopView;
    
}
//图片的button，点击方法没加
-(UIButton *)titleImageView{
    if (_titleImageView == nil) {
        _titleImageView = [UIButton new];
        _titleImageView.backgroundColor = [UIColor lightGrayColor];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.layer.cornerRadius  = 8;
    }
    return _titleImageView;
}
-(UILabel *)titlename_Label{
    if (_titlename_Label == nil) {
        _titlename_Label = [UILabel new];
        _titlename_Label.text = @"霍勇";
        _titlename_Label.textColor = [UIColor whiteColor];
        _titlename_Label.textAlignment = NSTextAlignmentRight;
        _titlename_Label.font = [UIFont systemFontOfSize:17];
    }
    return _titlename_Label;
}
-(UILabel *)zhicheng_Label{
    if (_zhicheng_Label == nil) {
        _zhicheng_Label = [UILabel new];
        _zhicheng_Label.text = @"超级VIP";
        _zhicheng_Label.textAlignment = NSTextAlignmentLeft;
        _zhicheng_Label.font = [UIFont systemFontOfSize:15];
        _zhicheng_Label.textColor = [UIColor whiteColor];
        
    }
    return _zhicheng_Label;
    
}
-(UILabel *)area_Label{
    if (_area_Label == nil) {
        _area_Label = [UILabel new];
        _area_Label.text = @"手机型号";
        _area_Label.textAlignment = NSTextAlignmentCenter;
        _area_Label.font = [UIFont systemFontOfSize:13];
        _area_Label.textColor = [UIColor whiteColor];
        
    }
    return _area_Label;
    
}
-(UILabel *)State_Label{
    if (_State_Label == nil) {
        _State_Label = [UILabel new];
        _State_Label.text = @"未认证";
        _State_Label.textAlignment = NSTextAlignmentCenter;
        _State_Label.font = [UIFont systemFontOfSize:15];
        _State_Label.textColor = [UIColor whiteColor];
    }
    return _State_Label;
}

-(UIView *)footView{
    if (_footView == nil) {
        _footView = [UIView new];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
/**
 *  多个section的数据结构应该是
 */
-(NSArray *)titles{
    if (_titles == nil) {
        _titles = @[
                    @{ zytitle:@[
                               @{zytitleName:@"我的HTML"},
                               @{zytitleName:@"泡泡页面"},
                               @{zytitleName:@"泡泡首页"},
                               @{zytitleName:@"唐永刚界面"},
                               @{zytitleName:@"隐私设置"}
                               ]
                       },
                    @{zytitle:@[
                              @{zytitleName:@"意见反馈"},
                              @{zytitleName:@"关于我们"}
                              ]
                      }
                    ];
    }
    return _titles;
}

@end
