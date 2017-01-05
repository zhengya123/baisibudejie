//
//  Utils.h
//  Search
//
//  Created by dqong on 2016/12/28.
//  Copyright © 2016年 ZY. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject

/**
 *  汉子转拼音
 */
+ (NSString *)getPinyinWithString:(NSString *)string;

/**
 *  获取字符串首字母, 如果首字母非字母 返回"~"
 */
+ (NSString *)getFirstLetterWithString:(NSString *)string;

@end
