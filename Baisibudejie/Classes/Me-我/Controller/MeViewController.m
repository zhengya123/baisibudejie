//
//  MeViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "MeViewController.h"
#import "PrefixHeader.pch"
#import "Me_tableFootViewCollectionViewCell.h"
#import "CollectionTableViewCell.h"
#import "CoreLocationVC.h"
#import "KaidianCompanyInfoController.h"
#import "PersonalViewController.h"
#import "ZY_RootNavigationController.h"
#import "ZY_BottonView.h"
#import "ZY_ErrorView.h"
#define ImageName @"imageName"
#define TitleName @"titleName"
@interface MeViewController ()<
     UITableViewDelegate,
     UITableViewDataSource,
collectionCellDelegate>

@property (nonatomic, strong) UITableView * tableView;


@end

@implementation MeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBar.hidden = NO;
    [[ZY_BottonView shareView] remove];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"我的";
    [self createUI];
}
-(void)createUI{
    [self.view addSubview:self.tableView];
   
   // self.tableView.tableFooterView = self.collectionView;


}

#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 22/4 * 100 + 110;
    }else{
        return 44;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
        cell.delegate = self;
//        cell.dataArrays = self.dataArray;
//        [cell.collectionView reloadData];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        switch (indexPath.section) {
            case 0:
            {
                cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
                cell.textLabel.text  = @"登陆/注册";
                
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"个人信息";
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            LoginViewController * LoginVC = [LoginViewController new];
            [self presentViewController:LoginVC animated:YES completion:nil];
        
        }
            break;
            case 1:
        {
        //个人信息
            PersonalViewController * personalVC = [PersonalViewController new];
            [self.navigationController pushViewController:personalVC animated:YES];
        }
            break;
           
        default:
            break;
    }

}
#pragma marl - collectionCellDelegate
-(void)didselection:(NSIndexPath *)indexpath{
    switch (indexpath.row) {
        case 0:
        {
         ZYLog(@"1");
            KaidianCompanyInfoController * kai = [KaidianCompanyInfoController new];
            [self.navigationController pushViewController:kai animated:YES];
        }
            break;
            case 1:
        {
            [[ZY_BottonView shareView] show];
        }
            break;
            case 2:
        {
            [[ZY_ErrorView shareError] showWithStr:@"密码错误,请稍后重试"
                                              Font:18
                                              Time:4
             ];
            ZYLog(@"3");
        }
            break;
            case 3:
        {
        
            [[ZY_ErrorView shareError] showWithStr:@"这个正常" Font:18 Time:3];
        }
            break;
            case 4:
        {
        
            [[ZY_ErrorView shareError] showWithStr:@"反正这是一个很长的字符串,我想让他换行看看行不行" Font:18 Time:3];
        }
            break;
            case 5:
        {
        
         [[ZY_ErrorView shareError] showWithStr:@"反正这是一个很长的字符串,我想让他换行看看行不行,反正这是一个很长的字符串,我想让他换行看看行不行,反正这是一个很长的字符串,我想让他换行看看行不行" Font:18 Time:3];
        }
            break;
        default:
            break;
    }

}
#pragma mark - lan
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 44 - 64 - 5) style:UITableViewStylePlain];
       // _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView registerClass:[CollectionTableViewCell class] forCellReuseIdentifier:@"CollectionCell"];
        
    }
    return _tableView;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[ZY_BottonView shareView]remove];

}

@end
