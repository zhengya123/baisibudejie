//
//  ButtonView.h
//  Baisibudejie
//
//  Created by dqong on 2017/3/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol buttonViewDelegate <NSObject>

-(void)loadMoreBtnClick;
-(void)consultationbtnClick;
-(void)jishubangbtnClick;
-(void)publicClassBtnClick;
-(void)asademicBtnClick;
-(void)distributionBtnClick;
@end

@interface ButtonView : UIView

@property (nonatomic, strong) UIButton * loadMoreBtn;//加载更多
@property (nonatomic, strong) UIButton * consultationBtn;//会诊中心
@property (nonatomic, strong) UIButton * jishubangBtn;//技术帮进修
@property (nonatomic, strong) UIButton * publicClassBtn;//公开课
@property (nonatomic, strong) UIButton * academicBtn;//学术会议
@property (nonatomic, strong) UIButton * distributionBtn;//发布按钮
@property (nonatomic, assign) id<buttonViewDelegate>delegate;
@end
