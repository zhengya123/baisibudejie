//
//  ZY_BottonView.h
//  Baisibudejie
//
//  Created by dqong on 2017/3/20.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZY_BottonView : UIView


+ (ZY_BottonView *)shareView;
@property (nonatomic, strong) UIButton * rebackBtn;
@property ( nonatomic, strong) UILabel * testLabel;

-(void)show;
-(void)remove;
@end
