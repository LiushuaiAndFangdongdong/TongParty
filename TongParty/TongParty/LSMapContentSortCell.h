//
//  LSMapContentSortCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSContentSortModel.h"
@interface LSMapContentSortCell : UITableViewCell
@property(nonatomic, strong)LSContentSortModel *entity;
@property(nonatomic, copy) void (^showMoreBlock)(UITableViewCell  *currentCell);
+ (CGFloat)cellDefaultHeight:(LSContentSortModel *)entity;
+(CGFloat)cellMoreHeight:(LSContentSortModel *)entity;
@end
