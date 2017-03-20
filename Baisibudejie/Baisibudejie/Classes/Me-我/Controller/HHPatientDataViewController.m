//
//  HHPatientDataViewController.m
//  Baisibudejie
//
//  Created by dqong on 2016/11/25.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "HHPatientDataViewController.h"
#import "textField_AtViewWithImage.h"
#import "FTPrettyRulerView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface HHPatientDataViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,FTPrettyRulerViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView       * topTitleBaseView;
@property (nonatomic, strong) UILabel      * topPerDetailLabel;
@property (nonatomic, strong) UILabel      * topInformationLabel;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UIToolbar    * textToolBar;
@property (nonatomic, strong) UIButton     * beginButton;
@property (nonatomic, strong) UIPickerView * pickView;
@property (nonatomic, strong) textField_AtViewWithImage * treatment;//治疗方式
@property (nonatomic, strong) textField_AtViewWithImage * maindiagnostic;//主要诊断
@property (nonatomic, strong) textField_AtViewWithImage * diseases;//并存疾病
@property (nonatomic, strong) textField_AtViewWithImage * surgeryDate;//手术日期
@property (nonatomic, strong) textField_AtViewWithImage * prosthesisName;//假体名称
@property (nonatomic, strong) textField_AtViewWithImage * prosthesisSystem;//假体系统
@property (nonatomic, strong) textField_AtViewWithImage * patellaReplace;//髌骨置换

@property (nonatomic, strong) FTPrettyRulerView * heightRulerView;

@end

@implementation HHPatientDataViewController

{
    NSArray * array1;
    NSArray * array2;
    NSArray * array3;
    NSArray * array4;
    NSArray * array5;
    NSArray * array6;
    NSInteger indexNum;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.960 green:0.952 blue:0.965 alpha:1.000];
    self.navigationItem.title = @"患者资料";
    [self createUI];
    [self createData];
}
-(void)createData{
    array1 = @[@"1",@"2",@"3",@"4"];
    array2 = @[@"一",@"二",@"三",@"四",@"五"];
    array3 = @[@"11",@"22",@"23",@"44",@"55",@"66"];
    array4 = @[@"111",@"222",@"333",@"444",@"555",@"666",@"777"];
    array5 = @[@"1111",@"2222",@"3333",@"4444",@"5555",@"6666",@"7777",@"8888"];
    array6 = @[@"11111",@"22222",@"33333",@"44444",@"55555",@"66666",@"77777",@"88888",@"99999"];

}
-(void)createUI{

    self.topTitleBaseView.frame = CGRectMake(0, 64, ScreenWidth, 80);
    [self.scrollView addSubview:self.topTitleBaseView];
    
    self.topPerDetailLabel.text = @"a    男    34";
    self.topPerDetailLabel.frame = CGRectMake(10, 10, ScreenWidth - 20, 30);
    [self.topTitleBaseView addSubview:self.topPerDetailLabel];
    
    self.topInformationLabel.text = @"膝关节置换";
    self.topInformationLabel.frame = CGRectMake(10, CGRectGetMaxY(self.topPerDetailLabel.frame), ScreenWidth - 20, 30);
    [self.topTitleBaseView addSubview:self.topInformationLabel];
    
    self.treatment.leftStr = @"治疗方式:";
    self.treatment.frame = CGRectMake(0, CGRectGetMaxY(self.topTitleBaseView.frame) +20, ScreenWidth, 40);
    [self.scrollView addSubview:self.treatment];
    self.maindiagnostic.leftStr = @"主要诊断:";
    self.maindiagnostic.frame = CGRectMake(0, CGRectGetMaxY(self.treatment.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.maindiagnostic];
    self.diseases.leftStr = @"并存疾病:";
    self.diseases.frame = CGRectMake(0, CGRectGetMaxY(self.maindiagnostic.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.diseases];
    self.surgeryDate.leftStr = @"手术日期";
    self.surgeryDate.frame = CGRectMake(0, CGRectGetMaxY(self.diseases.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.surgeryDate];
    self.prosthesisName.leftStr = @"假体品牌";
    self.prosthesisName.frame = CGRectMake(0, CGRectGetMaxY(self.surgeryDate.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.prosthesisName];
    self.prosthesisSystem.leftStr = @"假体系统";
    self.prosthesisSystem.frame = CGRectMake(0, CGRectGetMaxY(self.prosthesisName.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.prosthesisSystem];
    self.patellaReplace.leftStr = @"髌骨置换";
    self.patellaReplace.frame = CGRectMake(0, CGRectGetMaxY(self.prosthesisSystem.frame), ScreenWidth, 40);
    [self.scrollView addSubview:self.patellaReplace];
    
    self.beginButton.frame = CGRectMake(20, CGRectGetMaxY(self.patellaReplace.frame) + 20, ScreenWidth - 40, 40);
    [self.scrollView addSubview:self.beginButton];
    
    self.surgeryDate.zy_textField.inputView = self.datePicker;
    self.surgeryDate.zy_textField.inputAccessoryView=self.textToolBar;
    
    
    self.treatment.zy_textField.inputView = self.pickView;
    self.treatment.zy_textField.inputAccessoryView = self.textToolBar;
    self.maindiagnostic.zy_textField.inputView = self.pickView;
    self.diseases.zy_textField.inputView = self.pickView;
    self.prosthesisName.zy_textField.inputView = self.pickView;
    self.prosthesisSystem.zy_textField.inputView = self.pickView;
    self.patellaReplace.zy_textField.inputView = self.pickView;
    
    self.heightRulerView.frame = CGRectMake(0, CGRectGetMaxY(self.beginButton.frame) + 20, ScreenWidth, 50);
    [self.heightRulerView showRulerScrollViewWithCount:200
                                                average:[NSNumber numberWithFloat:1]
                                           currentValue:175
                                              smallMode:YES];
    [self.scrollView addSubview:self.heightRulerView];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.heightRulerView.frame)+50);
    [self.view addSubview:self.scrollView];
    
    
}
#pragma mark - 尺子的代理
-(void)ftRrettyRuler:(FTPrettyRulerView *)rulerView rulerValue:(CGFloat)rulerValue{

    self.topInformationLabel.text = [NSString stringWithFormat:@"当前身高: %.1fCM",rulerValue];

}
#pragma mark - 开始随访按钮
-(void)beginBtnClick:(UIButton *)btn{
    NSLog(@"点击了随访");

}
-(void)clickssss:(UIToolbar *)toobar{
    if (self.surgeryDate.zy_textField.isFirstResponder) {
        NSDate *date = self.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        self.surgeryDate.zy_textField.text =  [NSString stringWithFormat:@"%@",[formatter  stringFromDate:date]];
        [self.surgeryDate resignFirstResponder];
        [self.surgeryDate.zy_textField endEditing:YES];
    }else{
        [self.treatment.zy_textField resignFirstResponder];
        [self.maindiagnostic.zy_textField resignFirstResponder];
        [self.diseases.zy_textField resignFirstResponder];
        [self.surgeryDate.zy_textField resignFirstResponder];
        [self.prosthesisName.zy_textField resignFirstResponder];
        [self.prosthesisSystem.zy_textField resignFirstResponder];
        [self.patellaReplace.zy_textField resignFirstResponder];
    
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.treatment.zy_textField resignFirstResponder];
    [self.maindiagnostic.zy_textField resignFirstResponder];
    [self.diseases.zy_textField resignFirstResponder];
    [self.surgeryDate.zy_textField resignFirstResponder];
    [self.prosthesisName.zy_textField resignFirstResponder];
    [self.prosthesisSystem.zy_textField resignFirstResponder];
    [self.patellaReplace.zy_textField resignFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.treatment.zy_textField) {
        
        indexNum = 1;
        [self.pickView selectRow:2 inComponent:0 animated:YES];
    }else if (textField == self.maindiagnostic.zy_textField){
    
        indexNum = 2;
    }else if (textField == self.diseases.zy_textField){
        indexNum = 3;
    
    }else if (textField == self.prosthesisName.zy_textField){
    
        indexNum = 4;
    }else if (textField == self.prosthesisSystem.zy_textField){
        
        indexNum = 5;
    }else if (textField == self.patellaReplace.zy_textField){
        
        indexNum = 6;
    }
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField == self.surgeryDate.zy_textField) {
//        NSDate *date = self.datePicker.date;
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
//        self.surgeryDate.zy_textField.text =  [NSString stringWithFormat:@"%@",[formatter  stringFromDate:date]];
//        [self.surgeryDate resignFirstResponder];
//        [self.surgeryDate.zy_textField endEditing:YES];
//    }
//
//}
#pragma mark - pickView代理方法
#pragma mark - UIPickViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (indexNum == 1) {
        return array1.count;
    }else if(indexNum == 2){
    
        return array2.count;
    }else if(indexNum == 3){
        
        return array3.count;
    }else if(indexNum == 4){
        
        return array4.count;
    }else if(indexNum == 5){
        
        return array5.count;
    }else if(indexNum == 6){
        
        return array6.count;
    }else {
        
        return 0;
    }
    
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (indexNum == 1) {
        return array1[row];
    }else if(indexNum == 2){
        
        return array2[row];
    }else if(indexNum == 3){
        
        return array3[row];
    }else if(indexNum == 4){
        
        return array4[row];
    }else if(indexNum == 5){
        
        return array5[row];
    }else if(indexNum == 6){
        
        return array6[row];
    }else {
        
        return 0;
    }

    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (indexNum == 1) {
        self.treatment.zy_textField.text = array1[row];
    }else if(indexNum == 2){
        
        self.maindiagnostic.zy_textField.text = array2[row];
    }else if(indexNum == 3){
        
        self.diseases.zy_textField.text = array3[row];
    }else if(indexNum == 4){
        
        self.prosthesisName.zy_textField.text = array4[row];
    }else if(indexNum == 5){
        
        self.prosthesisSystem.zy_textField.text = array5[row];
    }else if(indexNum == 6){
        
        self.patellaReplace.zy_textField.text = array6[row];
    }
    
}

#pragma mark - 懒
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

-(UIView *)topTitleBaseView{
    if (_topTitleBaseView == nil) {
        _topTitleBaseView = [UIView new];
        _topTitleBaseView.backgroundColor = [UIColor whiteColor];
    }
    return _topTitleBaseView;
}
-(UILabel *)topPerDetailLabel{
    if (_topPerDetailLabel == nil) {
        _topPerDetailLabel = [UILabel new];
        _topPerDetailLabel.textAlignment = NSTextAlignmentLeft;
        _topPerDetailLabel.textColor = [UIColor blackColor];
        _topPerDetailLabel.font = [UIFont systemFontOfSize:15];
    }
    return _topPerDetailLabel;
}
-(UILabel *)topInformationLabel{
    if (_topInformationLabel == nil) {
        _topInformationLabel = [UILabel new];
        _topInformationLabel.textAlignment = NSTextAlignmentLeft;
        _topInformationLabel.textColor = [UIColor blackColor];
        _topInformationLabel.font = [UIFont systemFontOfSize:15];
    }
    return _topInformationLabel;
}
-(textField_AtViewWithImage *)treatment{
    if (_treatment == nil) {
        _treatment = [textField_AtViewWithImage new];
        _treatment.zy_textField.placeholder = @"治疗方式";
        _treatment.zy_textField.delegate = self;
        
    }
    return _treatment;
}
-(textField_AtViewWithImage *)maindiagnostic{
    if (_maindiagnostic == nil) {
        _maindiagnostic = [textField_AtViewWithImage new];
        _maindiagnostic.zy_textField.placeholder = @"选择诊断";
        _maindiagnostic.zy_textField.delegate = self;
    }
    return _maindiagnostic;
}
-(textField_AtViewWithImage *)diseases{
    if (_diseases == nil) {
        _diseases = [textField_AtViewWithImage new];
        _diseases.zy_textField.placeholder = @"选择并存疾病";
        _diseases.zy_textField.delegate = self;
    }
    return _diseases;
}
-(textField_AtViewWithImage *)prosthesisName{
    if (_prosthesisName == nil) {
        _prosthesisName = [textField_AtViewWithImage new];
        _prosthesisName.zy_textField.placeholder = @"假体品牌";
        _prosthesisName.zy_textField.delegate = self;
    }
    return _prosthesisName;
}
-(textField_AtViewWithImage *)surgeryDate{
    if (_surgeryDate == nil) {
        _surgeryDate = [textField_AtViewWithImage new];
        _surgeryDate.zy_textField.placeholder = @"手术日期";
        _surgeryDate.zy_textField.delegate = self;
    }
    return _surgeryDate;
}
-(textField_AtViewWithImage *)prosthesisSystem{
    if (_prosthesisSystem == nil) {
        _prosthesisSystem = [textField_AtViewWithImage new];
        _prosthesisSystem.zy_textField.placeholder = @"假体系统";
        _prosthesisSystem.zy_textField.delegate = self;
    }
    return _prosthesisSystem;
}
-(textField_AtViewWithImage *)patellaReplace{
    if (_patellaReplace == nil) {
        _patellaReplace = [textField_AtViewWithImage new];
        _patellaReplace.zy_textField.placeholder = @"髌骨置换";
        _patellaReplace.zy_textField.delegate = self;
    }
    return _patellaReplace;
}
-(UIButton *)beginButton{
    if (_beginButton == nil) {
        _beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beginButton setTitle:@"开始随访" forState:UIControlStateNormal];
        [_beginButton setBackgroundColor:[UIColor colorWithRed:0.000 green:0.849 blue:0.313 alpha:1.000]];
        [_beginButton addTarget:self action:@selector(beginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _beginButton.layer.masksToBounds = YES;
        _beginButton.layer.cornerRadius  = 8;
    }
    return _beginButton;
}
-(UIDatePicker *)datePicker{
    if (_datePicker == nil) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        [_datePicker setMaximumDate:[NSDate date]];
    }
    return _datePicker;
}
-(UIToolbar *)textToolBar{
    if (_textToolBar == nil) {
        _textToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _textToolBar.backgroundColor = [UIColor blackColor];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickssss:)];
        _textToolBar.items = @[item2, item3];
        
    }
    return _textToolBar;
}
-(UIPickerView *)pickView{
    if (_pickView == nil) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 250)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
    }
    return _pickView;
}

-(FTPrettyRulerView *)heightRulerView{
    if (_heightRulerView == nil) {
        _heightRulerView = [FTPrettyRulerView new];
        _heightRulerView.delegate = self;
        _heightRulerView.backgroundColor = [UIColor clearColor];
    }
    return _heightRulerView;
}
@end
