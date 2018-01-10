//
//  LSGiftCollectionViewCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSGiftCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_image;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_coin;
@property (weak, nonatomic) IBOutlet UILabel *lbl_count;

- (void)updateValueWith:(id)entity;

@end
