//
//  ZY_verification_Button.h
//  ZYHandMade
//
//  Created by dqong on 16/8/31.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZY_verification_Button : UIButton

- (void)buttonClickWithTimer:(NSTimeInterval)second callBack:(void(^)(ZY_verification_Button *button))block;

@end
