//
//  ZPDFPageController.m
//  pdfReader
//
//  Created by zy on 17/3/29.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import "ZPDFPageController.h"
#import "ZPDFView.h"

@interface ZPDFPageController ()

@end

@implementation ZPDFPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    ZPDFView *pdfView = [[ZPDFView alloc] initWithFrame:frame atPage:self.pageNO withPDFDoc:self.pdfDocument];
    pdfView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pdfView];
    
}


@end
