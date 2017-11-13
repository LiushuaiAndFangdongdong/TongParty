//
//  LSEditAddressTableViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSEditAddressTableViewCell.h"

@interface LSEditAddressTableViewCell ()<UITextFieldDelegate>
@property (nonatomic, strong)UILabel     *lbl_title;
@property (nonatomic, strong)UITextField *tf_address;
@end

@implementation LSEditAddressTableViewCell


- (void)setStyle:(LSEditCellStyle)style {
    _style = style;
    switch (_style) {
        case LSCreateCellSytleAddressLable:{
            _lbl_title = [UILabel new];
            [self.contentView addSubview:self.lbl_title];
            [_lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(DDFitWidth(10.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            _lbl_title.text = @"所在地区：  北京市朝阳区三环到四环之间";
            _lbl_title.font = DDFitFont(15.f);
            _lbl_title.textColor = kBlackColor;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }break;
        case LSCreateCellSytleEditAddress:{
            _lbl_title = [UILabel new];
            [self.contentView addSubview:self.lbl_title];
            [_lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(DDFitWidth(10.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            _lbl_title.text = @"详细地址：";
            _lbl_title.font = DDFitFont(15.f);
            _lbl_title.textColor = kBlackColor;
            _tf_address = [UITextField new];
            [self.contentView addSubview:self.tf_address];
            [_tf_address mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_lbl_title.mas_right).offset(DDFitWidth(5.f));
                make.height.equalTo(self.contentView).multipliedBy(0.7f);
                make.centerY.equalTo(self.contentView);
            }];
            _tf_address.font = DDFitFont(15.f);
            _tf_address.textColor = kBlackColor;
            _tf_address.placeholder = @"北京市朝阳区三环到四环之间";
            
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
