//
//  ZY_AlertViews.h
//  ZY_AlertView
//
//  Created by dqong on 2016/10/27.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZY_alertViewDelegate <NSObject>
@required
-(void)alertTips:(id)alertTips buttonClickedAtIndex:(int)buttonIndex;

@end

@interface ZY_AlertViews : UIView
@property(nonatomic, strong) UIImage  * tipBgImage;
@property(nonatomic, strong) UIView   *  boxView;
@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSString * msg;
@property(nonatomic, strong) UILabel  * msgLabel;
@property(nonatomic, strong) UIButton * sureButton;
@property(nonatomic, strong) UIButton * cancelButton;
@property(nonatomic, assign)id<ZY_alertViewDelegate>Delegate;

//普通提示
-(id)initWithBackgroundImage:(UIImage* )backgroundImage  andTitle:(NSString* )tips  andMsg:(NSString* )msg;
//富文本提示
-(id)initWithBackgroundImage:(UIImage* )backgroundImage  andTitle:(NSString* )tips  andMsg:(NSString* )msg andFont:(id)font asdRange:(NSRange)range andColor:(id)color;
-(void)setButtonWithName:(NSString* )cancelName backgroundImage:(UIImage* )cancelImage;
-(void)setButtonWithName:(NSString* )cancelName backgroundImage:(UIImage* )cancelImage andSure:(NSString* )sureName backgroundImage:(UIImage* )sureImage;
- (void)setButtonCornerRadius:(CGFloat)value;
- (void)setTitleColor:(UIColor*)color;
- (void)setMsgColor:(UIColor*)color;
- (void)show;
- (void)hidden;
@end
