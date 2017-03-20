//
//  ALLEssenceModel.m
//  Baisibudejie
//
//  Created by dqong on 2016/12/14.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ALLEssenceModel.h"
#import "ZY_Method.h"
@implementation ALLEssenceModel

+(instancetype)setModelWithDic:(NSDictionary *)dateDic{
    ALLEssenceModel * model = [ALLEssenceModel new];
    model.profile_image     = [ZY_Method isEmpty:dateDic[@"profile_image"]];
    model.name              = [ZY_Method isEmpty:dateDic[@"name"]];
    model.create_time       = [ZY_Method isEmpty:dateDic[@"create_time"]];
    model.text              = [ZY_Method isEmpty:dateDic[@"text"]];
    model.is_gif            = [ZY_Method isEmpty:dateDic[@"is_gif"]];
    model.height            = [ZY_Method isEmpty:dateDic[@"height"]];
    model.weight            = [ZY_Method isEmpty:dateDic[@"width"]];
    model.cdn_img           = [ZY_Method isEmpty:dateDic[@"cdn_img"]];
    model.gifFistFrame      = [ZY_Method isEmpty:dateDic[@"gifFistFrame"]];
    model.ding              = [ZY_Method isEmpty:dateDic[@"ding"]];
    model.hate              = [ZY_Method isEmpty:dateDic[@"hate"]];
    model.content           = dateDic[@"comment"];
    model.repost            = [ZY_Method isEmpty:dateDic[@"repost"]];
    return model;
}
@end
