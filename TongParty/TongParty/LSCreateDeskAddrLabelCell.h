//
//  LSCreateDeskAddrLabelCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "LSCreatDeskEntity.h"
@interface LSCreateDeskAddrLabelCell : DDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_managerAddr;
@property (weak, nonatomic) IBOutlet UIButton *btn_expandMore;
@property (weak, nonatomic) IBOutlet UIView *view_label_background;
@property (nonatomic, copy) void(^expandMoreBlcok)(void );
@property (nonatomic, copy) void(^managerAddressBlcok)(void );
@property (nonatomic)NSIndexPath  *indexPath;
- (void)updatePhotoWithArray:(NSDictionary *)dict;
@end
