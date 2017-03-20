//
//  ButtonView.m
//  Baisibudejie
//
//  Created by dqong on 2017/3/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ButtonView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define propation [UIScreen mainScreen].bounds.size.width/320
@implementation ButtonView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.loadMoreBtn.frame = CGRectMake(0, 0, ScreenWidth, 40);
        self.consultationBtn.frame = CGRectMake(5, CGRectGetMaxY(self.loadMoreBtn.frame), ScreenWidth/2 - 10, 60 * propation);
        self.jishubangBtn.frame = CGRectMake(ScreenWidth/2 + 5, CGRectGetMaxY(self.loadMoreBtn.frame), ScreenWidth/2 - 10, 60 * propation);
        self.publicClassBtn.frame = CGRectMake(5, CGRectGetMaxY(self.consultationBtn.frame)+ 3, ScreenWidth/2 - 10, 60 * propation);
        self.academicBtn.frame = CGRectMake(ScreenWidth/2 + 5, CGRectGetMaxY(self.jishubangBtn.frame) + 3, ScreenWidth/2 - 10, 60 * propation);
        self.distributionBtn.frame = CGRectMake(ScreenWidth/2 - 40, CGRectGetMaxY(self.jishubangBtn.frame) - 39, 80, 80);
        self.distributionBtn.layer.cornerRadius = 40;
        [self addSubview:self.loadMoreBtn];
        [self addSubview:self.consultationBtn];
        [self addSubview:self.jishubangBtn];
        [self addSubview:self.publicClassBtn];
        [self addSubview:self.academicBtn];
        [self addSubview:self.distributionBtn];
    }
    return self;
}
-(void)loadMoreBtnClicks{

    [self.delegate loadMoreBtnClick];
}
-(void)consultationBtnClicks{
    [self.delegate consultationbtnClick];

}
-(void)jishubangbtnClicks{
    [self.delegate jishubangbtnClick];

}
-(void)publicClassBtnClicks{
    [self.delegate publicClassBtnClick];
}
-(void)academicBtnClicks{
    [self.delegate asademicBtnClick];

}
-(void)distributionClicks{
    [self.delegate distributionBtnClick];

}
-(UIButton *)consultationBtn{
    if (_consultationBtn == nil) {
        _consultationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_consultationBtn setImage:[UIImage imageNamed:@"zanLeftbat"] forState:UIControlStateNormal];
        [_consultationBtn setTitle:@"会议中心" forState:UIControlStateNormal];
        _consultationBtn.backgroundColor = [UIColor whiteColor];
         [_consultationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _consultationBtn.layer.masksToBounds = YES;
        _consultationBtn.layer.cornerRadius  = 8;
        [_consultationBtn addTarget:self action:@selector(consultationBtnClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consultationBtn;
}
-(UIButton *)jishubangBtn{
    if (_jishubangBtn == nil) {
        _jishubangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jishubangBtn setImage:[UIImage imageNamed:@"zanLeftbat"] forState:UIControlStateNormal];
        [_jishubangBtn setTitle:@"技术帮进修" forState:UIControlStateNormal];
        _jishubangBtn.backgroundColor = [UIColor whiteColor];
         [_jishubangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jishubangBtn.layer.masksToBounds = YES;
        _jishubangBtn.layer.cornerRadius  = 8;
        [_jishubangBtn addTarget:self action:@selector(jishubangbtnClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jishubangBtn;
}

-(UIButton *)publicClassBtn{
    if (_publicClassBtn == nil) {
        _publicClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publicClassBtn setImage:[UIImage imageNamed:@"zanLeftbat"] forState:UIControlStateNormal];;
        [_publicClassBtn setTitle:@"公开课" forState:UIControlStateNormal];
        _publicClassBtn.backgroundColor = [UIColor whiteColor];
         [_publicClassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _publicClassBtn.layer.masksToBounds = YES;
        _publicClassBtn.layer.cornerRadius  = 8;
        [_publicClassBtn addTarget:self action:@selector(publicClassBtnClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publicClassBtn;
}

-(UIButton *)academicBtn{
    if (_academicBtn == nil) {
        _academicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_academicBtn setImage:[UIImage imageNamed:@"zanLeftbat"] forState:UIControlStateNormal];
        [_academicBtn setTitle:@"学术会议" forState:UIControlStateNormal];
        _academicBtn.backgroundColor = [UIColor whiteColor];
        [_academicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _academicBtn.layer.masksToBounds = YES;
        _academicBtn.layer.cornerRadius  = 8;
        [_academicBtn addTarget:self action:@selector(academicBtnClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _academicBtn;
}
-(UIButton *)loadMoreBtn{
    if (_loadMoreBtn == nil) {
        _loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadMoreBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loadMoreBtn setTitle:@"查看更多>>" forState:UIControlStateNormal];
        [_loadMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_loadMoreBtn addTarget:self action:@selector(loadMoreBtnClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadMoreBtn;
}
-(UIButton *)distributionBtn{
    if (_distributionBtn == nil) {
        _distributionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_distributionBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_distributionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_distributionBtn setBackgroundColor:[UIColor blueColor]];
        _distributionBtn.layer.masksToBounds = YES;
        [_distributionBtn addTarget:self action:@selector(distributionClicks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _distributionBtn;
}
@end
