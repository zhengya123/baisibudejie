//
//  ZPDFReaderController.h
//  pdfReader
//
//  Created by zy on 17/3/29.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPDFPageModel.h"

@interface ZPDFReaderController : UIViewController
{
     UIPageViewController *pageViewCtrl;
     ZPDFPageModel *pdfPageModel;
}
@property(nonatomic,copy)NSString *titleText, *fileName;
@end
