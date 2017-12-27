//
//  LSCreateDeskCommonCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

@interface LSCreateDeskCommonCell : DDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_action;
@property (weak, nonatomic) IBOutlet UILabel *lbl_action_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_action_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_recomand;
@property (weak, nonatomic) IBOutlet UILabel *lbl_line;
@property (nonatomic, copy) void(^recommandAddressBlcok)(void);
@property (nonatomic, copy) void(^didEndEdit)(NSString *content);
@end
