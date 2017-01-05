//
//  NSString+pinyin.h
//  Search
//
//  Created by dqong on 2016/12/28.
//  Copyright © 2016年 ZY. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (pinyin)

/**
 *  拼音 -> pinyin
 */
- (NSString *)transformToPinyin;

/**
 *  拼音首字母 -> py
 */
- (NSString *)transformToPinyinFirstLetter;
@end
