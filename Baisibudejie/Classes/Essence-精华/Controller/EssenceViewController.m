//
//  EssenceViewController.m
//  Baisibudejie
//
//  Created by dqong on 16/10/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "EssenceViewController.h"
#import "PrefixHeader.pch"
#import "AllEssenceViewController.h"
#import "VideoVC.h"
#import "picTureVC.h"
#import "CrossVC.h"
#import "SeniorityVC.h"
#import "UIView+UIView_ZYExtension.h"
static CGFloat const titleH = 44;
static CGFloat const navBarH = 64;
static CGFloat const maxTitleScale = 1.5;
#define LOAD_NEXT_ITEM self.childViewControllers.count
#define YCKScreenW [UIScreen mainScreen].bounds.size.width
#define YCKScreenH [UIScreen mainScreen].bounds.size.height
@interface EssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak  ) UIScrollView     * titleScrollView;
@property (nonatomic, weak  ) UIScrollView     * contentScrollView;
// 选中按钮
@property (nonatomic, weak  ) UIView           * lineView;
@property (nonatomic, weak  ) UIButton         * selTitleButton;
@property (nonatomic, weak  ) UILabel          * selTitleLabel;

@property (nonatomic, strong) NSMutableArray  * buttons;

@end

@implementation EssenceViewController

- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"精选";
    
    [self setupTitleScrollView];
    [self setupContentScrollView];
    [self addChildViewController];
    [self setupTitle];
    [self loadNextSubVC];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YCKScreenW, 0);
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
   
}
#pragma mark - 设置头部标题栏
- (void)setupTitleScrollView
{
    // 判断是否存在导航控制器来判断y值
    CGFloat y = self.navigationController ? navBarH : 0;
    CGRect rect = CGRectMake(0, y, YCKScreenW, titleH);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
    
}

#pragma mark - 设置内容
- (void)setupContentScrollView
{
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect = CGRectMake(0, y, YCKScreenW, YCKScreenH - 64 - 44);
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
}

#pragma mark - 添加子控制器
- (void)addChildViewController
{
    
    AllEssenceViewController *Mon     = [[AllEssenceViewController alloc] init];
    Mon.title         = @"全部";
    [self addChildViewController:Mon];
    
    
    VideoVC *Tues   = [[VideoVC alloc] init];
    Tues.title        = @"视频";
    [self addChildViewController:Tues];
    
    
    picTureVC *wed  = [[picTureVC alloc] init];
    wed.title         = @"图片";
    [self addChildViewController:wed];
    
    
    CrossVC *Thur  = [[CrossVC alloc] init];
    Thur.title        = @"段子";
    [self addChildViewController:Thur];
    
    
    SeniorityVC *Fri     = [[SeniorityVC alloc] init];
    Fri.title         = @"排行";
    [self addChildViewController:Fri];
    
}

#pragma mark - 设置标题
- (void)setupTitle
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat w = SCREEN_W/5;
    CGFloat h = titleH;
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        x                    = i * w;
        CGRect rect          = CGRectMake(x, 0, w, h);
        UIButton *btn        = [[UIButton alloc] initWithFrame:rect];
        btn.tag              = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font  = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchDown];
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        if (i == 0)
        {
            
            // 添加下划线
            // 下划线宽度 = 按钮文字宽度
            // 下划线中心点x = 按钮中心点x
            
            CGFloat h = 2;
            CGFloat y = 40 ;
            UIView *lineView =[[UIView alloc] init];
            // 位置和尺寸
            lineView.zy_height = h;
            // 先计算文字尺寸,在给label去赋值
            [btn.titleLabel sizeToFit];
            lineView.zy_width = btn.titleLabel.zy_width * maxTitleScale;
            lineView.zy_centerX = btn.zy_centerX;
            lineView.zy_y = y;
            lineView.backgroundColor = [UIColor blackColor];
            _lineView = lineView;
            
            [self.titleScrollView addSubview:lineView];
            [self chick:btn];
        }
        
    }

    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

// 按钮点击
- (void)chick:(UIButton *)btn
{
    [self selTitleBtn:btn];
    NSUInteger i = btn.tag;
    CGFloat x = i * YCKScreenW;
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}
// 选中按钮
- (void)selTitleBtn:(UIButton *)btn
{
    [self.selTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
    // 移动下划线的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        _lineView.zy_centerX = btn.zy_centerX;
    }];
    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}

- (void)setUpOneChildViewController:(NSUInteger)i
{
    CGFloat x = i * YCKScreenW;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, YCKScreenW, YCKScreenH - self.contentScrollView.frame.origin.y);
    
    [self.contentScrollView addSubview:vc.view];
    
}

- (void)setupTitleCenter:(UIButton *)btn
{
    CGFloat offset = btn.center.x - YCKScreenW * 0.5;
    
    if (offset < 0)
    {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - YCKScreenW;
    if (offset > maxOffset)
    {
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger i = self.contentScrollView.contentOffset.x / YCKScreenW;
    [self selTitleBtn:self.buttons[i]];
    if(i < LOAD_NEXT_ITEM-1){
        
        [self setUpOneChildViewController:i+1];
        
    }
    
}
-(void)loadNextSubVC{
    
    NSUInteger i = self.contentScrollView.contentOffset.x / YCKScreenW;
    [self setUpOneChildViewController:i+1];
//    [self setUpOneChildViewController:0];
//    [self setUpOneChildViewController:1];
//    [self setUpOneChildViewController:2];
//    [self setUpOneChildViewController:3];
//    [self setUpOneChildViewController:4];
//    [self setUpOneChildViewController:5];
//    [self setUpOneChildViewController:6];
    
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / YCKScreenW;
    NSInteger rightIndex = leftIndex + 1;
    UIButton *leftButton = self.buttons[leftIndex];
        [UIView animateWithDuration:0.25 animations:^{
    
            _lineView.zy_centerX = leftButton.zy_centerX;
       }];
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / YCKScreenW - leftIndex;
    CGFloat scaleL = 1 - scaleR;
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    // 移动下划线的位置
//        [UIView animateWithDuration:0.25 animations:^{
//    
//            _lineView.zy_centerX = rightButton.zy_centerX;
//        }];
    
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}

@end
