//
//  ALLEssenceModel.h
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALLEssenceModel : NSObject
/**
 *  用户头像
 */
@property (nonatomic, strong) NSString * profile_image;
/**
 *  用户姓名
 */
@property (nonatomic, strong) NSString * name;
/**
 *  创建时间
 */
@property (nonatomic, strong) NSString * create_time;
/**
 *  标题
 */
@property (nonatomic, strong) NSString * text;
/**
 *  是否是Gif
 */
@property (nonatomic, strong) NSString * is_gif;
/**
 *  Gif 预览图片
 */
@property (nonatomic, strong) NSString * gifFistFrame;

/**
 *  图片的高度
 */
@property (nonatomic, strong) NSString * height;

@property (nonatomic, strong) NSString * weight;
/**
 *  主题图片URL
 */
@property (nonatomic, strong) NSString * cdn_img;

/**
 * 动态图有没有点击
 */
@property (nonatomic, strong) NSString * gifisClick;

@property (nonatomic, strong) NSString * ding;
@property (nonatomic, strong) NSString * hate;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * repost;

+(instancetype)setModelWithDic:(NSDictionary *)dateDic;
@end
