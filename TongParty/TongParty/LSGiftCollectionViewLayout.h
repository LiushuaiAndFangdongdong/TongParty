//
//  LSGiftCollectionViewLayout.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSGiftCollectionViewLayout : UICollectionViewFlowLayout
/**
 一行中 cell 的个数
 */
@property (nonatomic,assign) NSUInteger itemCountPerRow;

/**
 一页显示多少行
 */
@property (nonatomic,assign) NSUInteger rowCount;
@end
