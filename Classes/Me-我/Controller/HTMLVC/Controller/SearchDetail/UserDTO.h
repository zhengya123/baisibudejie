//
//  UserDTO.h
//  Search
//
//  Created by dqong on 2016/12/28.
//  Copyright © 2016年 ZY. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface UserDTO : NSObject
/**
 *  昵称 要搜索的文字
 */
@property (nonatomic, copy) NSString * name;

/**
 *  昵称的pinyin 获取的时候就应该转为拼音了
 */
@property (nonatomic, copy) NSString * namePinYin;

/**
 *  昵称的拼音首字母
 */
@property (nonatomic, copy) NSString * nameFirstLetter;
@end
