//
//  ZYTextField.h
//  mobileinspect
//
//  Created by dqong on 16/7/20.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTextField : UITextField

@property (nonatomic,strong) CAShapeLayer *alertLayer;

-(void)showAlert;
@end
