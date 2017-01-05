//
//  TeamSearchVC.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/28.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "TeamSearchVC.h"
#import "PrefixHeader.pch"
#import "Utils.h"
#import "UserDTO.h"
#import "NSString+pinyin.h"
#import "ZY_Runing_Loding.h"
#import "TeamSearchModel.h"
#import "HHPatientDataViewController.h"
#import "UINavigationController+WXSTransition.h"
#define kscrentWidth ([UIScreen mainScreen].bounds.size.width)
#define kscrentHeight ([UIScreen mainScreen].bounds.size.height)
@interface TeamSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIView      * tableTitleTopView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIImageView * textFieldLeftImage;
@property (nonatomic, strong) UILabel     * NoDataSourceLabel;
@property (nonatomic, strong) UIButton    * searchBtn;
@property (nonatomic, strong) ZY_Runing_Loding * zyLoadingView;
// 存储模型数组
@property (nonatomic, strong) NSMutableArray * storeUserDTOList;

// 搜索数组
@property (nonatomic, strong) NSMutableArray * searchUserDTOList;

//分组总数据
@property (nonatomic, strong) NSMutableArray * arrayData_section;

// 是否在搜索状态
@property (nonatomic, assign) BOOL isSearchState;
@end

@implementation TeamSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    self.navigationItem.title = @"全部队伍";
    [self createUI];
    [self requeatData];
     [self loadData];
}
-(void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableTitleTopView.frame = CGRectMake(0, 64, kscrentWidth, 46);
    [self.view addSubview:self.tableTitleTopView];
    self.textField.frame = CGRectMake(10, 8, kscrentWidth - 60, 30);
    self.textField.leftView = self.textFieldLeftImage;
    [self.tableTitleTopView addSubview:self.textField];
    self.searchBtn.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), 0, kscrentWidth - CGRectGetMaxX(self.textField.frame), 46);
    [self.tableTitleTopView addSubview:self.searchBtn];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.NoDataSourceLabel];
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.zyLoadingView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];


}
-(void)textChange:(NSNotification *)note{
    if (self.textField.text == nil) {
        self.NoDataSourceLabel.hidden = YES;
    }
    [self startSearch:self.textField.text];
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.tableView reloadData];

}
#pragma mark - 搜索按钮点击
-(void)searchBtnClick:(UIButton *)btn{
    NSLog(@"搜索框的值 == %@",self.textField.text);

}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

        if (_isSearchState == YES) {
        
        if (self.searchUserDTOList.count > 0) {
            
            return self.searchUserDTOList.count;
        }else {
            
            return 0;
        }
    }else {
        self.NoDataSourceLabel.hidden = YES;
        return self.storeUserDTOList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UserDTO * dto = nil;
    
    if (_isSearchState) {
        
        dto = self.searchUserDTOList[indexPath.row];
    }else {
        
        dto = self.storeUserDTOList[indexPath.row];
    }
    
    cell.textLabel.text = dto.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHPatientDataViewController * vc = [HHPatientDataViewController new];
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysPushFromRight];
        }
            break;
            case 1:
        {
        [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysPushFromLeft];
        
        }
            break;
        case 2:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysPushFromTop];
            
        }
            break;
        case 3:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysPushFromBottom];
            
        }
            break;
        case 4:
        {
            
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysRevealFromRight];
        }
            break;
        case 5:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysRevealFromLeft];
            
        }
            break;
        case 6:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysRevealFromTop];
            
        }
            break;
        case 7:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysRevealFromBottom];
            
        }
            break;
        case 8:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysMoveInFromRight];
            
        }
            break;
        case 9:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysMoveInFromLeft];
            
        }
            break;
        case 10:
        {
            
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysMoveInFromTop];
        }
            break;
        case 11:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysMoveInFromBottom];
            
        }
            break;
        case 12:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysCubeFromRight];
            
        }
            break;
        case 13:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysCubeFromLeft];
            
        }
            break;
        case 14:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysCubeFromTop];
            
        }
            break;
        case 15:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysCubeFromBottom];
            
        }
            break;
        case 16:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysSuckEffect];
            
        }
            break;
        case 17:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysOglFlipFromRight];
            
        }
            break;
        case 18:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysOglFlipFromLeft];
            
        }
            break;
        case 19:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysOglFlipFromTop];
            
        }
            break;
        case 20:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysOglFlipFromBottom];
            
        }
            break;
        case 21:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeSysRippleEffect];
            
        }
            break;
        case 22:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypePageTransition];
            
        }
            break;
        case 23:
        {
            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeViewMoveToNextVC];
            
        }
            break;
        case 24:
        {
           // [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeFragmentShowFromLeft];
            [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeFragmentShowFromLeft;
                transition.animationTime = 2.0;
            }];
            
        }
            break;
            
        default:
            break;
    }

}
// 开始所搜
- (void)startSearch:(NSString *)string{
    
    if (self.searchUserDTOList.count > 0) {
        
        [self.searchUserDTOList removeAllObjects];
    }
    
    // 开始搜索
    NSString * key = string.lowercaseString;
    NSMutableArray * tempArr = [NSMutableArray array];
    
    if (![key isEqualToString:@"" ] && ![key isEqual:[NSNull null]]) {
        
        [self.storeUserDTOList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UserDTO * dto = self.storeUserDTOList[idx];
            NSString * name = dto.name.lowercaseString;
            NSString * namePinyin = dto.namePinYin.lowercaseString;
            NSString * nameFirstLetter = dto.nameFirstLetter.lowercaseString;
            
            NSRange rang1 = [name rangeOfString:key];
            if (rang1.length > 0) {
                
                [tempArr addObject:dto];
            }else {
                if ([nameFirstLetter containsString:key]) {
                    
                    [tempArr addObject:dto];
                }else { //
                    if ([nameFirstLetter containsString:[key substringToIndex:1]]) {
                        
                        if ([namePinyin containsString:key]) {
                            [tempArr addObject:dto];
                        }
                    }
                }
            }
            
        }];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (![self.searchUserDTOList containsObject:tempArr[idx]]) {
                
                [self.searchUserDTOList addObject:tempArr[idx]];
            }
        }];
        
        self.isSearchState = YES;
        
    }else{
        
        self.isSearchState = NO;
        self.NoDataSourceLabel.hidden = YES;
    }
    
    
        if (self.searchUserDTOList.count == 0) {
            self.NoDataSourceLabel.hidden = NO;
        }else{
            
            self.NoDataSourceLabel.hidden = YES;
        }
    

    
    [self.tableView reloadData];
}
-(void)requeatData{

    [self.zyLoadingView start];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"t"]      = @"1482908589998";
    params[@"auth"]   = @"8ccc9305910a87795168beb94c3e5307";
    params[@"UserID"] = @"21285";
    params[@"Name"]   = @"";
    __weak typeof(self) weakSelf = self;
    [HYBNetworking getWithUrl:@"http://www.iyotv.com:7788/AllTeamInfo.ashx" refreshCache:YES params:params success:^(id response) {
        
        [weakSelf dealWithData:response];
        //有网的时候正常显示，父类图片隐藏
    } fail:^(NSError *error) {
        ZYLog(@"失败 == %@",error);
        ZYLog(@"失败code = %ld",(long)error.code);
        //没网界面显示没网
        [self.zyLoadingView stop];
        [self.view makeToast:@"网络连接出错" duration:2.0 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];
    }];


}
-(void)dealWithData:(NSDictionary *)response{
    [self.zyLoadingView stop];
    NSString * errorId = [NSString stringWithFormat:@"%@",[response objectForKey:@"errorid"]];
    if (![errorId isEqualToString:@"1"]) {
        [self.view makeToast:[NSString stringWithFormat:@" errorid：%@ \n errorinfo:%@",errorId,[response objectForKey:@"errorinfo"]] duration:2.0 position:CSToastPositionBottom style:NSPersonNameComponentsFormatterStyleDefault];
    }else{
      ZYLog(@"成功 == %@",response);
    
    }

}
/**
 *  创建数据
 */
- (void)loadData{
    
    NSArray * nameArr = @[@"中国",@"联想",@"格力",@"苹果电脑",@"Iphone6s",@"中关村",@"东方明珠",@"美莲广场",@"火车站",@"MicroSoft",@"Oracle",@"凯迪拉克",@"甲骨文",@"MSUNSOFT",@"数据",@"中关村",@"东方明珠",@"美莲广场",@"火车站",@"MicroSoft",@"Oracle",@"凯迪拉克",@"甲骨文",@"MSUNSOFT",@"数据"];
    
    for (int i = 0; i < nameArr.count; i++) {
        
        UserDTO * dto = [[UserDTO alloc] init];
        NSString * PinYin = [nameArr[i] transformToPinyin];
        NSString * FirstLetter = [nameArr[i] transformToPinyinFirstLetter];
        dto.name = nameArr[i];
        dto.namePinYin = PinYin;
        dto.nameFirstLetter = FirstLetter;
        [self.storeUserDTOList addObject:dto];
        
        
    }
   // self.arrayData_section = [self sortObjectsAccordingToInitialWith:nameArr];
    NSLog(@"分好后的数组 == %@",self.arrayData_section);
    [self.tableView reloadData];
}

#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)storeUserDTOList{
    if (_storeUserDTOList == nil) {
        _storeUserDTOList = [[NSMutableArray alloc] init];
    }
    return _storeUserDTOList;
}

- (NSMutableArray *)searchUserDTOList{
    if (_searchUserDTOList == nil) {
        _searchUserDTOList = [[NSMutableArray alloc] init];
    }
    return _searchUserDTOList;
}
-(UIView *)tableTitleTopView{
    if (_tableTitleTopView == nil) {
        _tableTitleTopView = [UIView new];
        _tableTitleTopView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    }
    return _tableTitleTopView;
}
-(UITextField *)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.delegate = self;
        //_textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchImage"]];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.placeholder = @"请输入队伍名称";
        _textField.background  = [UIImage imageNamed:@"textFieldBodyImage"];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius  = 4;
    }
    return _textField;
}
-(UIImageView *)textFieldLeftImage{
    if (_textFieldLeftImage == nil) {
        _textFieldLeftImage = [UIImageView new];
        _textFieldLeftImage.frame = CGRectMake(0, 0, 46, 46);
        _textFieldLeftImage.image = [UIImage imageNamed:@"searchImage"];
    }
    return _textFieldLeftImage;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, kscrentWidth, kscrentHeight - 110) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;

}
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_searchBtn setBackgroundColor:[UIColor clearColor]];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _searchBtn;
}
-(UILabel *)NoDataSourceLabel{
    if (_NoDataSourceLabel == nil) {
        _NoDataSourceLabel = [UILabel new];
        _NoDataSourceLabel.frame = CGRectMake(0, 100, kscrentWidth, 40);
        _NoDataSourceLabel.text = @"没有搜索到相关数据!";
        _NoDataSourceLabel.textColor = [UIColor lightGrayColor];
        _NoDataSourceLabel.font = [UIFont systemFontOfSize:20];
        _NoDataSourceLabel.textAlignment = NSTextAlignmentCenter;
        _NoDataSourceLabel.hidden = YES;
    }
    return _NoDataSourceLabel;
}
-(ZY_Runing_Loding *)zyLoadingView{
    if (_zyLoadingView == nil) {
        _zyLoadingView = [[ZY_Runing_Loding alloc]init];
        //_zyLoadingView.delegate = self;
    }
    return _zyLoadingView;
}
-(NSMutableArray *)arrayData_section{
    if (_arrayData_section == nil) {
        _arrayData_section = [NSMutableArray new];
    }
    return _arrayData_section;

}

@end
