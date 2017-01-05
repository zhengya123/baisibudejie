//
//  AllEssenceListCell.h
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALLEssenceModel.h"

@protocol ALLEssenceClickDelegate <NSObject>

-(void)fullScreenLook:(NSString *)imageUrls andHeight:(CGFloat)height;

@end

@interface AllEssenceListCell : UITableViewCell


/**
 *  数据源
 */
@property (nonatomic, strong) ALLEssenceModel * model;
/**
 *  用户头像
 */
@property (nonatomic, strong) UIImageView     * userImgV;
/**
 *  用户名
 */
@property (nonatomic, strong) UILabel         * userNameLabel;
/**
 *  用户时间
 */
@property (nonatomic, strong) UILabel         * userCreateTimeLabel;
/**
 *  标题名称
 */
@property (nonatomic, strong) UILabel         * text_Label;
/**
 *  Gif图开始播放按钮
 */
@property (nonatomic, strong) UIButton        * playBtn;
/**
 *  图片或者GIF动画
 */
@property (nonatomic, strong) UIImageView     * mainImageView;
/**
 *  全屏按钮
 */
@property (nonatomic, strong) UIButton        * fullscreenBtn;
/**
 *  最下面的View
 */
@property (nonatomic, strong) UIView          * bottomView;

/**
 *  点赞按钮
 */
@property (nonatomic, strong) UIButton        * praiseBtn;//👍
@property (nonatomic, strong) UIButton        * NoPraiseBtn;//不赞
@property (nonatomic, strong) UIButton        * shareBtn;//分享
@property (nonatomic, strong) UIButton        * MessageBtn;//吐槽

@property (nonatomic, assign) id<ALLEssenceClickDelegate>delegate;
@end
