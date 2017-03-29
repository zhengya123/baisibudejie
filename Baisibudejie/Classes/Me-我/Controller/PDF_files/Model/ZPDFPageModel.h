//
//  ZPDFPageModel.h
//  pdfReader
//
//  Created by zy on 17/3/29.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIPageViewController.h>

@class ZPDFPageController;

@interface ZPDFPageModel : NSObject <UIPageViewControllerDataSource>
{
    CGPDFDocumentRef pdfDocument;
}
//@property (assign, nonatomic) CGPDFDocumentRef pdfDocument;
//@property (strong, nonatomic) NSArray *pageContent;
-(id) initWithPDFDocument:(CGPDFDocumentRef) pdfDocument;

- (ZPDFPageController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(ZPDFPageController *)viewController;
@end
