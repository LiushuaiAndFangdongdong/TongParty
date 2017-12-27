//
//  LSCreateDeskCommonCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskCommonCell.h"
@interface LSCreateDeskCommonCell ()<UITextFieldDelegate>

@end
@implementation LSCreateDeskCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //_tf_action_content.delegate = self;
    [_tf_action_content addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)recommandAddr:(id)sender {
    if (_recommandAddressBlcok) {
        _recommandAddressBlcok();
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (_didEndEdit) {
//        _didEndEdit(textField.text);
//    }
//    return YES;
//}

- (void)textFieldChanged:(UITextField *)textField {
        if (_didEndEdit) {
            _didEndEdit(textField.text);
        }
}


//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (_didEndEdit) {
//        _didEndEdit(textField.text);
//    }
//}

@end
