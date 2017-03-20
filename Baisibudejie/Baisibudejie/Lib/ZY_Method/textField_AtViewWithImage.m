//
//  textField_AtViewWithImage.m
//  Baisibudejie
//
//  Created by dqong on 2016/11/25.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "textField_AtViewWithImage.h"

@implementation textField_AtViewWithImage

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _leftImageV = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_leftImageV];
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_leftLabel];
        
        _zy_textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _zy_textField.font = [UIFont systemFontOfSize:15];
        [self addSubview:_zy_textField];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.913 alpha:1.000];
        [self addSubview:_lineView];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _leftLabel.text = _leftStr;
    _leftImageV.image = self.leftImag;
    _leftImageV.frame = CGRectMake(0, 0, 20, CGRectGetHeight(self.frame));
    _leftLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageV.frame), 0, [self stringWithSize:self.leftStr fontOfSize:15], CGRectGetHeight(self.frame));
    _zy_textField.frame = CGRectMake(CGRectGetMaxX(_leftLabel.frame)+ 5, 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(_leftLabel.frame) - 5, CGRectGetHeight(self.frame));
    _lineView.frame = CGRectMake(5, CGRectGetMaxY(self.zy_textField.frame)-1, CGRectGetWidth(self.frame) - 5, 1);
    
}



- (CGFloat)stringWithSize:(NSString*)string fontOfSize:(CGFloat)font
{
    CGRect rect =[string boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}
@end
