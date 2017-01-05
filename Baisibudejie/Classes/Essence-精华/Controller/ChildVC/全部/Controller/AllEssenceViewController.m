//
//  AllEssenceViewController.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "AllEssenceViewController.h"
#import "PrefixHeader.pch"
#import "ALLEssenceModel.h"
#import "ALLEssenceListCell.h"
#import "ImageLookVC.h"

@interface AllEssenceViewController ()<UITableViewDelegate,UITableViewDataSource,ALLEssenceClickDelegate>

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation AllEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self createUI];
    [self requestData];
}
-(void)requestData{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    __weak typeof(self) weakSelf = self;
    [HYBNetworking getWithUrl:@"http://api.budejie.com/api/api_open.php" refreshCache:YES params:params success:^(id response) {
        
        [weakSelf dealWithData:response];
        //有网的时候正常显示，父类图片隐藏
        weakSelf.NoNetImage.hidden = YES;
    } fail:^(NSError *error) {
        ZYLog(@"失败 == %@",error);
        ZYLog(@"失败code = %ld",(long)error.code);
        //没网界面显示没网
        weakSelf.NoNetImage.hidden = NO;
    }];
    
}

-(void)dealWithData:(NSDictionary *)response{
    ZYLog(@"成功 = %@",response);
    NSArray * listArray = [response objectForKey:@"list"];
    for (NSDictionary * dic in listArray) {
        ALLEssenceModel * model = [ALLEssenceModel setModelWithDic:dic];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - createUI
-(void)createUI{
    [self.view addSubview:self.tableView];


}
#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    AllEssenceListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    ALLEssenceModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ALLEssenceModel * model = self.dataArray[indexPath.row];
    CGFloat labelH = [ZY_Method heightWithString:model.text fontSize:15 width:SCREEN_W - 20];
    if ([model.is_gif isEqualToString:@"1"]) {
        return [model.height integerValue] + labelH + 100;
    }else{
    
        if ([model.height integerValue] >= 360) {
            return 360 + labelH + 100;
        }else{
            return [model.height integerValue] + labelH + 100;
        }
    }
    
}
#pragma mark - 全屏图片点击代理
-(void)fullScreenLook:(NSString *)imageUrls andHeight:(CGFloat)height{
    ImageLookVC * lookImage = [ImageLookVC new];
    lookImage.imageUrl      = imageUrls;
    lookImage.imageHeight   = height;
    [self presentViewController:lookImage animated:NO completion:nil];

}
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 - 44 - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AllEssenceListCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
