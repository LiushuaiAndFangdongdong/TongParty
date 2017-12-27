//
//  LSAddContactsCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSAddContactsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_description;
@property (weak, nonatomic) IBOutlet UIButton *btn_add;
@property (weak, nonatomic) IBOutlet UILabel *lbl_line;

- (void)updateValueWith:(id)model;
@end
