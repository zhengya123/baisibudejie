//
//  LoadingViewForOC.h
//  LoadingAnimation
//
//  Created by dqong on 2016/10/24.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewForOC : UIView

+ (LoadingViewForOC *)showLoadingWith:(UIView *)view;
+ (LoadingViewForOC *)showLoadingWithWindow;
- (void)hideLoadingView;


@end
