//
//  ZY_Runing_Loding.m
//  TYGG
//
//  Created by dqong on 16/9/6.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_Runing_Loding.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface ZY_Runing_Loding ()
{
    UIImageView * imageV;
    
}

@end

@implementation ZY_Runing_Loding

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        imageV = [UIImageView new];
        NSMutableArray * imageArray = [[NSMutableArray alloc]init];
        for (int i = 1; i<8; i++) {
            NSString * imageName =[NSString stringWithFormat:@"Running_Loading_%d",i];
            UIImage * image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }

        imageV.animationImages = imageArray;
        imageV.animationDuration = 1;
        imageV.animationRepeatCount = 1000;
        self.imageGif = imageV;
        self.imageGif.frame = frame;
        self.imageGif.layer.masksToBounds = YES;
        self.imageGif.layer.cornerRadius  = 8;
        [self addSubview:imageV];
        
    }
    return self;
}
-(void) layoutSubviews{

    [super layoutSubviews];
    self.imageGif.frame = CGRectMake(SCREEN_Width/2 - 100, SCREEN_Height/2 - 100, 200, 120);

}

-(void)start{
    [self.delegate Willstart];
    imageV.transform = CGAffineTransformIdentity;
    [imageV startAnimating];
   
}
-(void)stop{
    
//    [UIView beginAnimations:@"imageV" context:nil];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:imageV cache:YES];
//    imageV.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    [UIView commitAnimations];
    [self.delegate WillStop];
    [imageV stopAnimating];
   
}
@end
