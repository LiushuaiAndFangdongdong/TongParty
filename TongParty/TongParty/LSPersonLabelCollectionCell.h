//
//  LSPersonLabelCollectionCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPersonLabelModel.h"
@class LSPersonLabelCollectionCell;
@protocol LSPersonLabelCollectionCellDelegate <NSObject>
- (void)rightUpperButtonDidTappedWithItemCell:(LSPersonLabelCollectionCell *)selectedItemCell;
@end
@interface LSPersonLabelCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_label;
@property (nonatomic, strong) LSPersonLabelModel *itemModel;
@property (nonatomic, weak) id <LSPersonLabelCollectionCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isEditing;
@end
