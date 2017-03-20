//
//  KaidianCompanyInfoController.m
//  Baisibudejie
//
//  Created by dqong on 2016/10/25.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "KaidianCompanyInfoController.h"
#import "PrefixHeader.pch"
@interface KaidianCompanyInfoController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UILabel * topLabelLeft;
@property (nonatomic, strong) UILabel * topLabelRight;
@property (nonatomic, strong) UIView  * baseView1;
@property (nonatomic, strong) UIView  * baseView2;
@property (nonatomic, strong) UIButton* buttomBtn;

@property (nonatomic, strong) UIScrollView * baseScrollView;
@property (nonatomic, strong) UITextField * textFieldCompanyName;   //公司名称
@property (nonatomic, strong) UITextField * textFieldCompanyNature; //公司性质
@property (nonatomic, strong) UITextField * textFieldCompanyAddress;//公司所在地
@property (nonatomic, strong) UITextField * textFieldDetailAddress; //详细地址
@property (nonatomic, strong) UITextField * textFieldCompanyTel;    //公司电话
@property (nonatomic, strong) UITextField * textFieldTitleNumber;   //员工总数

@property (nonatomic, strong) UIPickerView * pickViewCompanyNature; //选择性质
@property (nonatomic, strong) UIPickerView * pickViewCompanyAddress;//选择地区
@property (nonatomic, strong) UIPickerView * pickViewTitleNumber;   //选择人数
@property (nonatomic, strong) UIToolbar    * pickViewToolbar;

@property (nonatomic, strong) NSArray     * arrayOne;
@property (nonatomic, strong) NSArray     * arrayTwo;
@property (nonatomic, strong) NSArray     * arrayThree;
@end

@implementation KaidianCompanyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"注册信息";
    [self createData];
    [self createUIFrame];
    
}
-(void)createData{
    self.arrayOne = @[@"外贸",@"电商",@"乱七八糟"];
    self.arrayTwo = @[@"北京",@"上海",@"广州",@"深圳",@"杭州"];
    self.arrayThree = @[@"20-99",@"100-499",@"500-999",@"1000-2000"];
}
#pragma mark - 控件坐标
-(void)createUIFrame{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.baseScrollView];
    //上面一部分
    self.topLabelLeft.frame = CGRectMake(10, 70, SCREEN_W/2 - 10, 40);
    [self.baseScrollView addSubview:self.topLabelLeft];
    self.topLabelRight.frame = CGRectMake(CGRectGetMaxX(self.topLabelLeft.frame), 70, SCREEN_W/2 - 10, 40);
    [self.baseScrollView addSubview:self.topLabelRight];
    self.baseView1.frame = CGRectMake(0, CGRectGetMaxY(self.topLabelLeft.frame), SCREEN_W, 299);
    [self.baseScrollView addSubview:self.baseView1];
    
    NSArray * leftNameOne = @[@"公司名称",@"公司性质",@"公司所在地",@"详细地址",@"公司电话",@"员工总数"];
    for (int i = 0; i<6; i++) {
        UILabel * leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, i * 50, 100, 50)];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = leftNameOne[i];
        leftLabel.font = [UIFont systemFontOfSize:15];
        [self.baseView1 addSubview:leftLabel];
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(20, i*50 + 49, SCREEN_W - 20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.baseView1 addSubview:lineView];
    }
    //上面的textField
    self.textFieldCompanyName.frame = CGRectMake(120, 0, SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldCompanyName];
    
    self.textFieldCompanyNature.frame = CGRectMake(120, CGRectGetMaxY(self.textFieldCompanyName.frame), SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldCompanyNature];
    self.textFieldCompanyNature.inputView = self.pickViewCompanyNature;
    self.textFieldCompanyNature.inputAccessoryView = self.pickViewToolbar;
    
    self.textFieldCompanyAddress.frame = CGRectMake(120, CGRectGetMaxY(self.textFieldCompanyNature.frame), SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldCompanyAddress];
    self.textFieldCompanyAddress.inputView = self.pickViewCompanyAddress;
    self.textFieldCompanyAddress.inputAccessoryView = self.pickViewToolbar;
    
    self.textFieldDetailAddress.frame = CGRectMake(120, CGRectGetMaxY(self.textFieldCompanyAddress.frame), SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldDetailAddress];
    
    self.textFieldCompanyTel.frame = CGRectMake(120, CGRectGetMaxY(self.textFieldDetailAddress.frame), SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldCompanyTel];
    
    self.textFieldTitleNumber.frame = CGRectMake(120, CGRectGetMaxY(self.textFieldCompanyTel.frame), SCREEN_W - 120, 50);
    [self.baseView1 addSubview:self.textFieldTitleNumber];
    self.textFieldTitleNumber.inputView = self.pickViewTitleNumber;
    self.textFieldTitleNumber.inputAccessoryView = self.pickViewToolbar;

    //下面一部分
    self.baseView2.frame = CGRectMake(0, CGRectGetMaxY(self.baseView1.frame) + 10, SCREEN_W, 149);
    [self.baseScrollView addSubview:self.baseView2];
    NSArray * leftNameTwo = @[@"联系人姓名",@"联系人电话",@"电子邮箱"];
    for (int j = 0; j<3; j++) {
        UILabel * leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, j * 50, 120, 50)];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = leftNameTwo[j];
        leftLabel.font = [UIFont systemFontOfSize:15];
        [self.baseView2 addSubview:leftLabel];
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(20, j*50 + 49, SCREEN_W - 20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.baseView2 addSubview:lineView];
    }
    
    self.buttomBtn.frame = CGRectMake(10, CGRectGetMaxY(self.baseView2.frame) + 20, SCREEN_W - 20, 50);
    [self.baseScrollView addSubview:self.buttomBtn];
    
    self.baseScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.buttomBtn.frame));
}
#pragma mark - pickViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.pickViewCompanyNature) {
        return self.arrayOne.count;
    }else if(pickerView == self.pickViewCompanyAddress){
        return self.arrayTwo.count;
    }else{
        return self.arrayThree.count;
    }
    
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.pickViewCompanyNature) {
        return [self.arrayOne objectAtIndex:row];
    }else if (pickerView == self.pickViewCompanyAddress){
        return [self.arrayTwo objectAtIndex:row];
    }else{
        return [self.arrayThree objectAtIndex:row];
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.pickViewCompanyNature) {
        self.textFieldCompanyNature.text = self.arrayOne[row];
    }else if (pickerView == self.pickViewCompanyAddress){
        self.textFieldCompanyAddress.text = self.arrayTwo[row];
    }else{
        self.textFieldTitleNumber.text = self.arrayThree[row];
    }
    
    
}
#pragma mark - textField代理时间
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    
    [self.pickViewCompanyNature reloadAllComponents];
    [self.pickViewCompanyAddress reloadAllComponents];
    [self.pickViewTitleNumber reloadAllComponents];
    
}
#pragma mark - toolBar点击事件
-(void)clicks{
    [self.textFieldCompanyNature endEditing:YES];
    [self.textFieldCompanyAddress endEditing:YES];
    [self.textFieldTitleNumber endEditing:YES];
    
}
#pragma mark - 下一步点击事件
-(void)btnClick:(UIButton *)btn{
    NSLog(@"点击了按钮");

}
#pragma mark - lan
-(UILabel *)topLabelLeft{
    if (_topLabelLeft == nil) {
        _topLabelLeft = [UILabel new];
        _topLabelLeft.textAlignment = NSTextAlignmentLeft;
        _topLabelLeft.font = [UIFont systemFontOfSize:15];
        _topLabelLeft.text = @"公司及联系人信息";
    }
    return _topLabelLeft;
}
-(UILabel *)topLabelRight{
    if (_topLabelRight == nil) {
        _topLabelRight = [UILabel new];
        _topLabelRight.textAlignment = NSTextAlignmentRight;
        _topLabelRight.font = [UIFont systemFontOfSize:15];
        _topLabelRight.text = @"为必填项目";
    }
    return _topLabelRight;
}
-(UIView *)baseView1{
    if (_baseView1 == nil) {
        _baseView1 = [UIView new];
        _baseView1.backgroundColor = [UIColor whiteColor];
    }
    return _baseView1;
}
-(UIView *)baseView2{
    if (_baseView2 == nil) {
        _baseView2 = [UIView new];
        _baseView2.backgroundColor = [UIColor whiteColor];
    }
    return _baseView2;
}
-(UIButton *)buttomBtn{
    if (_buttomBtn == nil) {
        _buttomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttomBtn.backgroundColor = [UIColor redColor];
        [_buttomBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_buttomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttomBtn.layer.masksToBounds = YES;
        _buttomBtn.layer.cornerRadius  = 8;
    }
    return _buttomBtn;
}
-(UITextField *)textFieldCompanyName{
    if (_textFieldCompanyName == nil) {
        _textFieldCompanyName = [UITextField new];
        _textFieldCompanyName.delegate = self;
        
    }
    return _textFieldCompanyName;
}
-(UITextField *)textFieldCompanyNature{
    if (_textFieldCompanyNature == nil) {
        _textFieldCompanyNature = [UITextField new];
        _textFieldCompanyNature.delegate = self;
        _textFieldCompanyNature.placeholder = @"选择性质";
        
    }
    return _textFieldCompanyNature;
}
-(UITextField *)textFieldCompanyAddress{
    if (_textFieldCompanyAddress == nil) {
        _textFieldCompanyAddress = [UITextField new];
        _textFieldCompanyAddress.delegate = self;
        _textFieldCompanyAddress.placeholder = @"选择地区";
        
    }
    return _textFieldCompanyAddress;
}
-(UITextField *)textFieldDetailAddress{
    if (_textFieldDetailAddress == nil) {
        _textFieldDetailAddress = [UITextField new];
        _textFieldDetailAddress.delegate = self;
        
    }
    return _textFieldDetailAddress;
}
-(UITextField *)textFieldCompanyTel{
    if (_textFieldCompanyTel == nil) {
        _textFieldCompanyTel = [UITextField new];
        _textFieldCompanyTel.delegate = self;
        
    }
    return _textFieldCompanyTel;
}
-(UITextField *)textFieldTitleNumber{
    if (_textFieldTitleNumber == nil) {
        _textFieldTitleNumber = [UITextField new];
        _textFieldTitleNumber.delegate = self;
        _textFieldTitleNumber.placeholder = @"选择人数";
        
    }
    return _textFieldTitleNumber;
}
-(UIPickerView *)pickViewCompanyNature{
    if (_pickViewCompanyNature == nil) {
        _pickViewCompanyNature = [UIPickerView new];
        _pickViewCompanyNature.delegate = self;
        _pickViewCompanyNature.dataSource = self;
    }
    return _pickViewCompanyNature;
}
-(UIPickerView *)pickViewCompanyAddress{
    if (_pickViewCompanyAddress == nil) {
        _pickViewCompanyAddress = [UIPickerView new];
        _pickViewCompanyAddress.delegate = self;
        _pickViewCompanyAddress.dataSource = self;
    }
    return _pickViewCompanyAddress;
}

-(UIPickerView *)pickViewTitleNumber{
    if (_pickViewTitleNumber == nil) {
        _pickViewTitleNumber = [UIPickerView new];
        _pickViewTitleNumber.delegate = self;
        _pickViewTitleNumber.dataSource = self;
    }
    return _pickViewTitleNumber;
}
-(UIToolbar *)pickViewToolbar{
    if (_pickViewToolbar == nil) {
        _pickViewToolbar = [UIToolbar new];
        _pickViewToolbar.frame = CGRectMake(0, 0, SCREEN_W, 40);
        _pickViewToolbar.barTintColor = [UIColor yellowColor];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clicks)];
        NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        [item3 setTitleTextAttributes:attributes forState:UIControlStateNormal];
        [_pickViewToolbar setTintColor:[UIColor blackColor]];
        _pickViewToolbar.items = @[item2, item3];

    }
    return _pickViewToolbar;
}
-(UIScrollView *)baseScrollView{
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _baseScrollView.backgroundColor = [UIColor clearColor];
        _baseScrollView.userInteractionEnabled = YES;
    }
    return _baseScrollView;
}
@end
