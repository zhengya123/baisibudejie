//
//  ZPDFPageController.h
//  pdfReader
//
//  Created by zy on 17/3/29.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPDFPageController : UIViewController
// CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) long pageNO;

@end
