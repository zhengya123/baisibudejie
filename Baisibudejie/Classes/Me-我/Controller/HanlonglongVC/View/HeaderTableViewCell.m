//
//  HeaderTableViewCell.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "HeaderTableViewCell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation HeaderTableViewCell

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
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.titleImage.frame = CGRectMake(0, 0, ScreenWidth, 90);
    [self.contentView addSubview:self.titleImage];
}
#pragma mark - 懒加载
-(UIImageView *)titleImage{
    if (_titleImage == nil) {
        _titleImage = [UIImageView new];
    }
    return _titleImage;
}
@end
