//
//  NewViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController * searchController;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.937 blue:0.852 alpha:1.000];
    self.navigationItem.titleView = self.searchController.searchBar;
    
    
}
#pragma mark - searchResultUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{


}
#pragma mark - searchController
-(UISearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = false;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"请输入查询条件";
    }
    return _searchController;
}
@end
