//
//  ZPDFView.h
//  pdfReader
//
//  Created by zy on 17/3/29.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPDFView : UIView {
    CGPDFDocumentRef pdfDocument;
    int pageNO;
}

-(id)initWithFrame:(CGRect)frame atPage:(int)index withPDFDoc:(CGPDFDocumentRef) pdfDoc;

@end
