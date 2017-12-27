//
//  LSInviteContactsCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSInviteContactsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_invite;
@property (weak, nonatomic) IBOutlet UILabel *lbl_line;
- (void)updateValueWith:(id)model;
@end
