//
//  MyInformationController.m
//  Baisibudejie
//
//  Created by dqong on 2016/11/1.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "MyInformationController.h"
#import "MyHeaderView.h"
#import "PrefixHeader.pch"
@interface MyInformationController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) MyHeaderView *headerView;     // 上面蓝色的 view，可以自定义
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat headerViewHeight;     // headerView 高度
@end

@implementation MyInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人信息";
    self.headerViewHeight = 180;
    [self.navigationController.navigationBar setBackgroundImage:[ZY_Method imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.view addSubview:self.tableView];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_W, self.headerViewHeight);
    [self.view addSubview:self.headerView];
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.sectionHeaderHeight = 20;
        _tableView.showsVerticalScrollIndicator = false;
        
        // 占位用的 view，高度 180
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.headerViewHeight)];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}

// 蓝色的 headerView
- (MyHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[MyHeaderView alloc] init];
    }
    return _headerView;
}

// 监听 tableView.contentOffset，也可以用 kvo 监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect frame = self.headerView.frame;
    if (offsetY < 0) {
        frame.size.height = self.headerViewHeight - offsetY;
        frame.origin.y = 0;             // 及时归零
    } else {
        frame.size.height = self.headerViewHeight;
        frame.origin.y = -offsetY;
    }
    self.headerView.frame = frame;
}

// --------------------------- 以下代码不是实验重点 ---------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
        cell.textLabel.text = @"hello world";
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterViewID"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterViewID"];
        view.contentView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];;
    }
    return view;
}

@end
