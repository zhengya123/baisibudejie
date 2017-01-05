//
//  CollectionTableViewCell.m
//  Baisibudejie
//
//  Created by dqong on 16/10/10.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "PrefixHeader.pch"
#import "Me_tableFootViewCollectionViewCell.h"

#define ImageName @"imageName"
#define TitleName @"titleName"
@interface CollectionTableViewCell ()<
    UICollectionViewDelegate,
    UICollectionViewDataSource>



@end


@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // setup subview UI
        [self setupUI];
    }
    return self;
    
}

#pragma mark - 创建UI
-(void)setupUI{
    
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ZYLog(@"%lu",(unsigned long)self.dataArrays.count);
    return self.dataArrays.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Me_tableFootViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    NSString * imageNames = [self.dataArrays[indexPath.row] objectForKey:ImageName];
    cell.titleimageV.image = [UIImage imageNamed:imageNames];
    cell.titleName.text = [self.dataArrays[indexPath.row]objectForKey:TitleName];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYLog(@"点击了collection的 == %ld",(long)indexPath.row);
    [self.delegate didselection:indexPath];
    
    

}
#pragma mark - layout delegate
//设置每个cell(item)的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_W/4,100);
    
}
//描述的是所有cell最外边组成的视图与collectionView上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0, 0, 0);
    
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;//3D旋转
    //    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋转
    
    rotation = CATransform3DScale(rotation, 0.8, 0.8, 1);
    
    rotation.m34 = 1.0/ 1000;
    
    cell.layer.shadowColor = [[UIColor redColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.6];
    
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

#pragma mark - lan
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, self.dataArrays.count/4 * 100 + 100) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[Me_tableFootViewCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    }
    return _collectionView;
    
}
-(NSArray *)dataArrays{
    if (_dataArrays == nil) {
        _dataArrays = @[@{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine_icon_nearby",TitleName:@"附近"},
                       @{ImageName:@"mine_icon_random",TitleName:@"随机穿越"},
                       @{ImageName:@"mine-icon-activity",TitleName:@"活动"},
                       @{ImageName:@"mine-icon-feedback",TitleName:@"意见反馈"},
                       @{ImageName:@"mine-icon-manhua",TitleName:@"漫画"},
                       @{ImageName:@"mine-icon-search",TitleName:@"搜索"},
                       @{ImageName:@"mine-my-post",TitleName:@"我的帖子"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"结束"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"审帖"},
                       @{ImageName:@"mine-icon-preview",TitleName:@"jiesu"}
                       ];
    }
    return _dataArrays;
}

@end
