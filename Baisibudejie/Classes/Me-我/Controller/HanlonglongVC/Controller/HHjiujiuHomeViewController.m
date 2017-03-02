//
//  HHjiujiuHomeViewController.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "HHjiujiuHomeViewController.h"
#import "HeaderTableViewCell.h"
#import "ButtonView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define headerTableViewCellHeight 90
#define propation [UIScreen mainScreen].bounds.size.width/320
@interface HHjiujiuHomeViewController ()<UITableViewDelegate,UITableViewDataSource,buttonViewDelegate>

@property (nonatomic, strong) UITableView * MainTableView;
@property (nonatomic, strong) UIView      * MainTableViewHeaderView;
@property (nonatomic, strong) UITableView * HeaderTableView;
@property (nonatomic, strong) UILabel     * travelLabel;
@property (nonatomic, strong) UIView      * HeaderLineView;
@property (nonatomic, strong) ButtonView  * titleButtonView;

@end

@implementation HHjiujiuHomeViewController
{
    CGFloat titleTableViewNum;
    BOOL  isSelectLoadMoreBtn;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0];
    titleTableViewNum = 2;
    [self createUI];
}
#pragma mark - 加载UI
-(void)createUI{
    
    [self.view addSubview:self.MainTableView];
    self.MainTableView.tableHeaderView = self.MainTableViewHeaderView;
    
    self.HeaderTableView.frame = CGRectMake(0, 0, ScreenWidth, headerTableViewCellHeight * titleTableViewNum);
    self.titleButtonView.frame = CGRectMake(0, CGRectGetMaxY(self.HeaderTableView.frame), ScreenWidth, 163 * propation);
    self.travelLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleButtonView.frame) + 20, ScreenWidth, 30);
    self.HeaderLineView.frame = CGRectMake(5, CGRectGetMaxY(self.travelLabel.frame), ScreenWidth - 10, 1);
    self.MainTableViewHeaderView.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(self.HeaderLineView.frame));
    [self.MainTableViewHeaderView addSubview:self.HeaderTableView];
    [self.MainTableViewHeaderView addSubview:self.travelLabel];
    [self.MainTableViewHeaderView addSubview:self.HeaderLineView];
    [self.MainTableViewHeaderView addSubview:self.titleButtonView];
    
}
#pragma mark - buttonViewDelegate
-(void)consultationbtnClick{

}
-(void)jishubangbtnClick{

}
-(void)publicClassBtnClick{

}
-(void)asademicBtnClick{

}
-(void)loadMoreBtnClick{
    if (isSelectLoadMoreBtn == NO) {
        titleTableViewNum = 10;
        isSelectLoadMoreBtn = YES;
        [self.titleButtonView.loadMoreBtn setTitle:@"<<收起" forState:UIControlStateNormal];
    }else{
        titleTableViewNum = 2;
        isSelectLoadMoreBtn = NO;
         [self.titleButtonView.loadMoreBtn setTitle:@"查看更多>>" forState:UIControlStateNormal];
    }
    [self createUI];
    [self.HeaderTableView reloadData];
    [self.MainTableView reloadData];

}
-(void)distributionBtnClick{


}
#pragma mark - MaintableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.HeaderTableView) {
        return titleTableViewNum;
    }else{
        return 10;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.MainTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"];
        cell.textLabel.text = @"这也是图片cell";
        return cell;
    }else{
        HeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell"];
        cell.titleImage.image = [UIImage imageNamed:@"my_cover620.9"];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.HeaderTableView) {
        return headerTableViewCellHeight;
    }else{
        return 44;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark - 懒加载
-(UITableView *)MainTableView{
    if (_MainTableView == nil) {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"];
    }
    return _MainTableView;
}
-(UITableView *)HeaderTableView{
    if (_HeaderTableView == nil) {
        _HeaderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headerTableViewCellHeight * titleTableViewNum) style:UITableViewStylePlain];
        _HeaderTableView.delegate = self;
        _HeaderTableView.dataSource = self;
        [_HeaderTableView registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:@"HeaderTableViewCell"];
    }
    return _HeaderTableView;
}
-(UIView *)MainTableViewHeaderView{
    if (_MainTableViewHeaderView == nil) {
        _MainTableViewHeaderView = [UIView new];
        _MainTableViewHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _MainTableViewHeaderView;
}
-(ButtonView *)titleButtonView{
    if (_titleButtonView == nil) {
        _titleButtonView = [[ButtonView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 163 * propation)];
        _titleButtonView.delegate = self;
        _titleButtonView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0];
    }
    return _titleButtonView;
}
-(UILabel *)travelLabel{
    if (_travelLabel == nil) {
        _travelLabel = [UILabel new];
        _travelLabel.textColor = [UIColor blackColor];
        _travelLabel.textAlignment = NSTextAlignmentLeft;
        _travelLabel.text = @"我的行程";
    }
    return _travelLabel;
}
-(UIView *)HeaderLineView{
    if (_HeaderLineView == nil) {
        _HeaderLineView = [UIView new];
        _HeaderLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _HeaderLineView;
}
@end
