//
//  AllEssenceListCell.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "AllEssenceListCell.h"
#import "PrefixHeader.pch"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
@implementation AllEssenceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ALLEssenceModel *)model{
    _model = model;
    [self createData];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // setup subview UI
        [self setupUI];
    }
    return self;
    
}
-(void)setupUI{

    self.userImgV.frame = CGRectMake(10, 5, 30, 30);
    self.userNameLabel.frame = CGRectMake(CGRectGetMaxX(self.userImgV.frame)+ 5, 5, SCREEN_W - CGRectGetMaxX(self.userImgV.frame) - 5, 15);
    self.userCreateTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.userImgV.frame) + 5, CGRectGetMaxY(self.userNameLabel.frame), SCREEN_W - CGRectGetMaxX(self.userImgV.frame), 15);
    self.text_Label.frame = CGRectMake(10, CGRectGetMaxY(self.userCreateTimeLabel.frame) + 5, SCREEN_W - 20, 30);
    
    [self.contentView addSubview:self.userImgV];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.userCreateTimeLabel];
    [self.contentView addSubview:self.text_Label];
   
}
-(void)createData{
    CGFloat textFloat = [ZY_Method heightWithString:self.model.text fontSize:15 width:SCREEN_W - 20];
    [self.userImgV sd_setImageWithURL:[NSURL URLWithString:self.model.profile_image] placeholderImage:[ZY_Method imageWithColor:[UIColor redColor]]];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",self.model.name];
    self.userCreateTimeLabel.text = [NSString stringWithFormat:@"%@",self.model.create_time];
    self.text_Label.text = [NSString stringWithFormat:@"%@",self.model.text];
    self.text_Label.frame = self.text_Label.frame = CGRectMake(10, CGRectGetMaxY(self.userCreateTimeLabel.frame) + 5, SCREEN_W - 20, textFloat);
    
    if ([self.model.is_gif isEqualToString:@"0"]) {
        self.playBtn.hidden = YES;
        if ([self.model.height integerValue] >= 360) {
           // CGFloat imageHeight = [self.model.height integerValue]/[self.model.weight integerValue];
//            CGRect  mainImageFrame;
//            mainImageFrame.size.height = (SCREEN_W - 20)* imageHeight;
//            mainImageFrame.size.width  = (SCREEN_W - 20);
//            mainImageFrame.origin.x = 10;
//            mainImageFrame.origin.y = 0;
            self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.text_Label.frame) + 2, SCREEN_W - 20, 360);
            self.fullscreenBtn.frame = CGRectMake(10, CGRectGetMaxY(self.mainImageView.frame) - 40, SCREEN_W - 20, 40);
        }else{
            self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.text_Label.frame) + 2, SCREEN_W - 20, [self.model.height  integerValue]);
           self.fullscreenBtn.frame = CGRectMake(0, 0, 0, 0);
        }
        
        
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.model.cdn_img] placeholderImage:[UIImage imageNamed:@"my_cover620.9"]];
        
    }else{
        self.playBtn.hidden = NO;
        self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.text_Label.frame) + 2, SCREEN_W - 20, [self.model.height integerValue]);
            self.playBtn.frame = CGRectMake(SCREEN_W/2 - 20, CGRectGetMaxY(self.text_Label.frame) + 2 + [self.model.height  integerValue]/2 - 20, 40, 40);
        
            [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.model.gifFistFrame] placeholderImage:[UIImage imageNamed:@"my_cover620.9"]];
        self.fullscreenBtn.frame = CGRectMake(0, 0, 0, 0);
    }
    
    
    
    self.praiseBtn.frame = CGRectMake(10, CGRectGetMaxY(self.mainImageView.frame) + 10, (SCREEN_W - 20)/4, 30);
    self.NoPraiseBtn.frame = CGRectMake(CGRectGetMaxX(self.praiseBtn.frame), CGRectGetMaxY(self.mainImageView.frame) + 10, (SCREEN_W - 20)/4, 30);
    self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.NoPraiseBtn.frame), CGRectGetMaxY(self.mainImageView.frame) + 10, (SCREEN_W - 20)/4, 30);
    self.MessageBtn.frame = CGRectMake(CGRectGetMaxX(self.shareBtn.frame), CGRectGetMaxY(self.mainImageView.frame) + 10, (SCREEN_W - 20)/4, 30);
    
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%@",self.model.ding] forState:UIControlStateNormal];
    [self.NoPraiseBtn setTitle:[NSString stringWithFormat:@"%@",self.model.hate] forState:UIControlStateNormal];
    [self.shareBtn setTitle:self.model.repost forState:UIControlStateNormal];
    [self.MessageBtn setTitle:[NSString stringWithFormat:@"%@",self.model.content] forState:UIControlStateNormal];
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.MessageBtn.frame) + 10, SCREEN_W, 10);
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.praiseBtn];
    [self.contentView addSubview:self.NoPraiseBtn];
    [self.contentView addSubview:self.shareBtn];
    [self.contentView addSubview:self.MessageBtn];
    [self.contentView addSubview:self.playBtn];
    [self.contentView addSubview:self.fullscreenBtn];
    self.playBtn.enabled = YES;
    if ([self.model.gifisClick isEqualToString:@"1"]) {
        self.playBtn.hidden = YES;
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.model.cdn_img] placeholderImage:[UIImage imageNamed:@"my_cover620.9"]];
    }
}
#pragma mark - Gif动画的点击方法
-(void)playBtnClick{
    self.playBtn.enabled = NO;
    [self.playBtn setBackgroundImage:[UIImage sd_animatedGIFNamed:@"screenShotone"] forState:UIControlStateNormal];
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.model.cdn_img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil) {
                [self.model setValue:@"1" forKey:@"gifisClick"];
                [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play_small"] forState:UIControlStateNormal];
                self.playBtn.hidden = YES;
                self.playBtn.enabled = YES;
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }else{
                self.playBtn.enabled = YES;
            }
        }];
}
-(void)fullScreenClick:(UIButton *)btn{
    
    CGFloat imageHeight = [self.model.height integerValue]/[self.model.weight integerValue];
    [self.delegate fullScreenLook:self.model.cdn_img andHeight:imageHeight];
    
}
#pragma mark - 点赞按钮
-(void)praiseBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self praseBtnC:btn.selected];

}
-(void)praseBtnC:(BOOL)btn{
    if (btn) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        
        animation.values = @[@1.4, @1.0];
        
        animation.duration = 0.7;
        
        animation.calculationMode = kCAAnimationCubic;
        
        [self.praiseBtn.layer addAnimation:animation forKey:@"transform.scale"];
        [self.praiseBtn setImage:[UIImage imageNamed:@"zanLeftbat"] forState:UIControlStateNormal];
    }else{
        [self.praiseBtn setImage:[UIImage imageNamed:@"zanLeftbatH"] forState:UIControlStateNormal];
    
    }

}
#pragma mark - 不赞按钮
-(void)NoPraseBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self NoprasebtnC:btn.selected];

}
-(void)NoprasebtnC:(BOOL)btn{
    if (btn) {
        [self.NoPraiseBtn setImage:[UIImage imageNamed:@"NozanLeftbat"] forState:UIControlStateNormal];
    }else{
    
        [self.NoPraiseBtn setImage:[UIImage imageNamed:@"NozanLeftbatH"] forState:UIControlStateNormal];
    }

}
#pragma mark - 懒加载
-(UIImageView *)userImgV{
    if (_userImgV == nil) {
        _userImgV = [UIImageView new];
        _userImgV.layer.masksToBounds = YES;
        _userImgV.layer.cornerRadius  = 13;
        
    }
    return _userImgV;
}
-(UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        _userNameLabel = [UILabel new];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _userNameLabel;
}
-(UILabel *)userCreateTimeLabel{
    if (_userCreateTimeLabel == nil) {
        _userCreateTimeLabel = [UILabel new];
        _userCreateTimeLabel.textColor = [UIColor lightGrayColor];
        _userCreateTimeLabel.textAlignment = NSTextAlignmentLeft;
        _userCreateTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _userCreateTimeLabel;
}
-(UILabel *)text_Label{
    if (_text_Label == nil) {
        _text_Label = [UILabel new];
        _text_Label.textColor = [UIColor blackColor];
        _text_Label.textAlignment = NSTextAlignmentLeft;
        _text_Label.font = [UIFont systemFontOfSize:15];
        _text_Label.numberOfLines = 0;
    }
    return _text_Label;
}
-(UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [UIImageView new];
        _mainImageView.clipsToBounds = YES;
        _mainImageView.contentMode = UIViewContentModeTop;
    }
    return _mainImageView;
}
-(UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"play_small"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
//全屏按钮
-(UIButton *)fullscreenBtn{
    if (_fullscreenBtn == nil) {
        _fullscreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullscreenBtn setBackgroundColor:[UIColor colorWithWhite:0.563 alpha:0.6]];
        [_fullscreenBtn setTitle:@"点击全屏" forState:UIControlStateNormal];
        [_fullscreenBtn setImage:[UIImage imageNamed:@"video_fullscreen"] forState:UIControlStateNormal];
        _fullscreenBtn.layer.masksToBounds = YES;
        _fullscreenBtn.layer.cornerRadius  = 8;
        [_fullscreenBtn addTarget:self action:@selector(fullScreenClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _fullscreenBtn;
}
-(UIButton *)praiseBtn{
    if (_praiseBtn == nil) {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"zanLeftbatH"] forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}
-(UIButton *)NoPraiseBtn{
    if (_NoPraiseBtn == nil) {
        _NoPraiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_NoPraiseBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_NoPraiseBtn setImage:[UIImage imageNamed:@"NozanLeftbatH"] forState:UIControlStateNormal];
        [_NoPraiseBtn addTarget:self action:@selector(NoPraseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NoPraiseBtn;

}
-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"BtnShareLive"] forState:UIControlStateNormal];
    }
    return _shareBtn;
    
}
-(UIButton *)MessageBtn{
    if (_MessageBtn == nil) {
        _MessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MessageBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_MessageBtn setImage:[UIImage imageNamed:@"btnLiveChat"] forState:UIControlStateNormal];
    }
    return _MessageBtn;
    
}
-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
    }
    return _bottomView;
}
@end
