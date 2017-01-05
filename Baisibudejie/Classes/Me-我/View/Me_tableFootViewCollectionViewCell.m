//
//  Me_tableFootViewCollectionViewCell.m
//  Baisibudejie
//
//  Created by dqong on 16/10/10.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "Me_tableFootViewCollectionViewCell.h"
#import "PrefixHeader.pch"

@implementation Me_tableFootViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{

    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/4-1, 0, 1, 100)];
    rightView.backgroundColor = [UIColor colorWithWhite:0.920 alpha:1.000];
    [self.contentView addSubview:rightView];
    UIView * buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, 99, SCREEN_W/4, 1)];
    buttomView.backgroundColor = [UIColor colorWithWhite:0.920 alpha:1.000];
    [self.contentView addSubview:buttomView];
    
    
    self.titleimageV.frame = CGRectMake(SCREEN_W/8-30, 10, 60, 60);
    [self.contentView addSubview:self.titleimageV];
    
    self.titleName.frame = CGRectMake(0, self.titleimageV.frame.size.height + self.titleimageV.frame.origin.y, SCREEN_W/4, 30);
    [self.contentView addSubview:self.titleName];


}
-(UIImageView *)titleimageV{
    if (_titleimageV == nil) {
        _titleimageV = [UIImageView new];
        
    }
    return _titleimageV;
}
-(UILabel *)titleName{
    if (_titleName == nil) {
        _titleName = [UILabel new];
        _titleName.textColor = [UIColor blackColor];
        _titleName.textAlignment = NSTextAlignmentCenter;
        _titleName.font = [UIFont systemFontOfSize:15];
    }
    return _titleName;
}
@end
