//
//  LSEditAddressTableViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSEditAddressTableViewCell.h"

@interface LSEditAddressTableViewCell ()<UITextFieldDelegate>


@end

@implementation LSEditAddressTableViewCell


- (void)setStyle:(LSEditCellStyle)style {
    _style = style;
    switch (_style) {
        case LSCreateCellSytleAddressLable:{
            UILabel *lbl_title = [UILabel new];
            [self.contentView addSubview:lbl_title];
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(DDFitWidth(10.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            lbl_title.text = @"所在地区：  北京市朝阳区三环到四环之间";
            lbl_title.font = DDFitFont(15.f);
            lbl_title.textColor = kBlackColor;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }break;
        case LSCreateCellSytleEditAddress:{
            UILabel *lbl_title = [UILabel new];
            [self.contentView addSubview:lbl_title];
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(DDFitWidth(10.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            lbl_title.text = @"详细地址：";
            lbl_title.font = DDFitFont(15.f);
            lbl_title.textColor = kBlackColor;
            UITextField *tf_address = [UITextField new];
            [self.contentView addSubview:tf_address];
            [tf_address mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lbl_title.mas_right).offset(DDFitWidth(5.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            tf_address.font = DDFitFont(15.f);
            tf_address.textColor = kBlackColor;
            tf_address.placeholder = @"北京市朝阳区三环到四环之间";
            
        }break;
        case LSCreateCellSytleLableManager:{
            UILabel *lbl_lable = [UILabel new];
            [self.contentView addSubview:lbl_lable];
            [lbl_lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(DDFitWidth(10.f));
                make.height.mas_equalTo(DDFitHeight(20.f));
                make.top.mas_equalTo(DDFitHeight(15.f));
            }];
            lbl_lable.textColor = kBlackColor;
            lbl_lable.text = @"标签：";
            lbl_lable.font = DDFitFont(15.f);
            
            UIButton *btn_lable = [UIButton new];
            [self.contentView addSubview:btn_lable];
            [btn_lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lbl_lable.mas_right).offset(DDFitWidth(5.f));
                make.height.mas_equalTo(DDFitHeight(26.f));
                make.centerY.equalTo(lbl_lable);
                make.width.equalTo(self).multipliedBy(0.18f);
            }];
            btn_lable.layer.borderWidth = kLineHeight;
            btn_lable.layer.borderColor = kCommonGrayTextColor.CGColor;
            [btn_lable setTitle:@"+" forState:UIControlStateNormal];
            btn_lable.titleLabel.font = DDFitFont(16.f);
            [btn_lable setTitleColor:kBlackColor forState:normal];
            
        }break;
        default:
            break;
    }
    
}




- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
