//
//  CollectionTableViewCell.h
//  Baisibudejie
//
//  Created by dqong on 16/10/10.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol collectionCellDelegate <NSObject>
/**
 *  用代理把点击方法迁出去
 */
-(void)didselection:(NSIndexPath *)indexpath;

@end

@interface CollectionTableViewCell : UITableViewCell
@property (nonatomic, strong) UICollectionView  * collectionView;
@property (nonatomic, strong) NSArray     * dataArrays;

@property (nonatomic, assign) id<collectionCellDelegate>delegate;
@end
