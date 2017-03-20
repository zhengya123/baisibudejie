//
//  ZY_Runing_Loding.h
//  TYGG
//
//  Created by dqong on 16/9/6.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYRunningDelegate <NSObject>

-(void)Willstart;
-(void)WillStop;

@end

@interface ZY_Runing_Loding : UIView
@property (nonatomic, strong) UIImageView * imageGif;


/**
 *  开始动画
 */
-(void)start;


/**
 *  停止动画
 */
-(void)stop;

@property (nonatomic, assign) id<ZYRunningDelegate>delegate;
@end
