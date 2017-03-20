//
//  ZY_AlertViews.m
//  ZY_AlertView
//
//  Created by dqong on 2016/10/27.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZY_AlertViews.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define TOPMAGIN 20.0
#define LEFTMAGIN 30.0
#define FIXMAGIN 10.0
#define LEFTBTN  20.0
@implementation ZY_AlertViews

//正常的
-(id)initWithBackgroundImage:(UIImage *)backgroundImage andTitle:(NSString *)tips andMsg:(NSString *)msg{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.title = tips;
        self.msg = msg;
        self.tag = 19911008;
        self.tipBgImage= backgroundImage;
        self.boxView = [[UIView alloc] init];
        if (self.tipBgImage!=nil) {
            self.boxView.backgroundColor = [UIColor colorWithPatternImage:self.tipBgImage];
        }else{
            self.boxView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        }
        
        self.boxView.layer.cornerRadius = 5;
        self.boxView.layer.masksToBounds = YES;
        self.boxView.layer.borderWidth = 2;
        self.boxView.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self initItemForTips];
    }
    return self;
}
//富文本
-(id)initWithBackgroundImage:(UIImage *)backgroundImage andTitle:(NSString *)tips andMsg:(NSString *)msg andFont:(id)font asdRange:(NSRange)range andColor:(id)color{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.title = tips;
        self.msg = msg;
        self.tag = 19911008;
        self.tipBgImage= backgroundImage;
        self.boxView = [[UIView alloc] init];
        if (self.tipBgImage!=nil) {
            self.boxView.backgroundColor = [UIColor colorWithPatternImage:self.tipBgImage];
        }else{
            self.boxView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        }
        
        self.boxView.layer.cornerRadius = 5;
        self.boxView.layer.masksToBounds = YES;
        self.boxView.layer.borderWidth = 2;
        self.boxView.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self initItemForTips:msg andFont:font asdRange:range andColor:color];
    }
    return self;




}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect endRect = self.boxView.frame;
    self.boxView.frame = CGRectMake(0, 0, 0, 0);
    self.boxView.center = self.center;
    for (UIView *view in self.boxView.subviews) {
        view.alpha = 0;
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.boxView.layer addAnimation:animation forKey:nil];
    self.boxView.frame = endRect;
    for (UIView *view in self.boxView.subviews) {
        view.alpha = 1;
    }
    [window addSubview:self];
}
-(void)hidden{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZY_AlertViews *view = (ZY_AlertViews*)[window viewWithTag:19911008];
    view.hidden = YES;
    [view removeFromSuperview];
}
- (void)setButtonCornerRadius:(CGFloat)value{
    for (UIView *view in self.boxView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)view;
            button.layer.cornerRadius = value;
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor clearColor].CGColor;
            button.clipsToBounds = YES;
        }
    }
}

-(void)setButtonWithName:(NSString *)cancelName backgroundImage:(UIImage *)cancelImage{
    return [self setButtonWithName:cancelName backgroundImage:cancelImage andSure:nil backgroundImage:nil];
}
-(void)setButtonWithName:(NSString *)cancelName backgroundImage:(UIImage *)cancelImage andSure:(NSString *)sureName backgroundImage:(UIImage *)sureImage{
    
    CGRect msgFrame = ((UILabel*)[self viewWithTag:1008612]).frame;
    // 添加取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(sureName == nil ? (SCREENWIDTH/2 - 30)/2:0 , FIXMAGIN+CGRectGetMaxY(msgFrame), SCREENWIDTH/2 - 30, 40);
    [self.cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.tag = 0;
    [self.cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [self.cancelButton setTitle:cancelName forState:UIControlStateNormal];
    [self.boxView addSubview:self.cancelButton];
    self.boxView.bounds = CGRectMake(0,0,SCREENWIDTH-60,CGRectGetMaxY(msgFrame)+30+FIXMAGIN*2);
    
    // 添加确定按钮
    if (cancelName !=nil) {
        self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame), FIXMAGIN+CGRectGetMaxY(msgFrame), SCREENWIDTH/2 - 30, 40);
        [self.sureButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton.tag = 1;
        [self.sureButton setBackgroundImage:sureImage forState:UIControlStateNormal];
        [self.sureButton setTitle:sureName forState:UIControlStateNormal];
        [self.boxView addSubview:self.sureButton];
        
    }
}
-(void)setTitleColor:(UIColor *)color{
    UILabel* label = (UILabel* )[self.boxView viewWithTag:1008611];
    label.textColor = color;
}
- (void)setMsgColor:(UIColor*)color{
    UILabel* label = (UILabel* )[self.boxView viewWithTag:1008612];
    label.textColor = color;
}
-(void)initItemForTips{
    
    CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-LEFTMAGIN*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    UILabel* titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMAGIN, TOPMAGIN, SCREENWIDTH-60-LEFTMAGIN*2, titleSize.height)];
    titleLable.text = self.title;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.numberOfLines = 0;
    titleLable.tag = 1008611;
    [self.boxView addSubview:titleLable];
    
    
    CGSize msgSize =[self.msg boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-LEFTMAGIN*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMAGIN, titleLable.frame.origin.y+titleSize.height+FIXMAGIN, SCREENWIDTH-60-LEFTMAGIN*2, msgSize.height)];
    self.msgLabel.backgroundColor = [UIColor clearColor];
    self.msgLabel.text = self.msg;
    self.msgLabel.numberOfLines = 0;
    self.msgLabel.tag = 1008612;
    //self.msgLabel.textAlignment = NSTextAlignmentCenter;
    [self.boxView addSubview:self.msgLabel];
    
    self.boxView.bounds = CGRectMake(0,0,SCREENWIDTH-60, self.msgLabel.frame.origin.y+msgSize.height+FIXMAGIN);
    self.boxView.center = self.center;
    [self addSubview:self.boxView];
    
}

-(void)initItemForTips:(NSString *)msg andFont:(id)font asdRange:(NSRange)range andColor:(id)color{
    CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-LEFTMAGIN*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    UILabel* titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMAGIN, TOPMAGIN, SCREENWIDTH-60-LEFTMAGIN*2, titleSize.height)];
    titleLable.text = self.title;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.numberOfLines = 0;
    titleLable.tag = 1008611;
    [self.boxView addSubview:titleLable];
    
    CGSize msgSize =[self.msg boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-LEFTMAGIN*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMAGIN, titleLable.frame.origin.y+titleSize.height+FIXMAGIN, SCREENWIDTH-60-LEFTMAGIN*2, msgSize.height)];
    self.msgLabel.backgroundColor = [UIColor clearColor];
    self.msgLabel.text = self.msg;
    self.msgLabel.numberOfLines = 0;
    self.msgLabel.tag = 1008612;
    NSMutableAttributedString * attributedstr = [[NSMutableAttributedString alloc]initWithString:msg];
    [attributedstr addAttribute:NSFontAttributeName
                          value:font
                          range:range];
    [attributedstr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    self.msgLabel.attributedText = attributedstr;
    //self.msgLabel.textAlignment = NSTextAlignmentCenter;
    [self.boxView addSubview:self.msgLabel];
    
    self.boxView.bounds = CGRectMake(0,0,SCREENWIDTH-60, self.msgLabel.frame.origin.y+msgSize.height+FIXMAGIN);
    self.boxView.center = self.center;
    [self addSubview:self.boxView];

}
- (void)buttonClicked:(UIButton*)button{
    if (self.Delegate) {
        [self.Delegate alertTips:self buttonClickedAtIndex:(int)button.tag];
        [self hidden];
    }else{
        [self hidden];
    }
}



@end
