//
//  DDSettingTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSettingTableViewCell.h"
@interface DDSettingTableViewCell()<DDRadioButtonDelegate>
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *valueLbl;
@property (nonatomic, strong) UILabel *centerLbl; //字在中间的
//开关的宽80，高40固定的。
@property (nonatomic, strong) UISwitch *myswith;  //右边开关

@end

@implementation DDSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(UILabel *)centerLbl{
    if (!_centerLbl) {
        //        _centerLbl = [UILabel new];
        //        [self.contentView addSubview:_centerLbl];
        //        [_centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.mas_equalTo((kScreenWidth - 100)/2);
        //            make.top.and.bottom.mas_equalTo(0);
        //            make.width.mas_equalTo(100);
        //        }];
        _centerLbl = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, 0, 100, 50)];
        _centerLbl.font = kFont(15);
        _centerLbl.textColor = kBlackColor;
        _centerLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLbl;
}
-(UILabel *)nameLbl{
    if (!_nameLbl) {
        //        self.nameLbl = [UILabel new];
        //        [self.contentView addSubview:self.nameLbl];
        //        [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.mas_equalTo(10);
        //            make.top.mas_equalTo(0);
        //            make.bottom.mas_equalTo(0);
        //        }];
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, 50)];
        self.nameLbl.font= kFont(15);
        self.nameLbl.textColor = kBlackColor;
        self.nameLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLbl;
}
-(UILabel *)valueLbl{
    if (!_valueLbl) {
        //        self.valueLbl = [UILabel new];
        //        [self.contentView addSubview:self.valueLbl];
        //        [self.valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(-10);
        //            make.top.and.bottom.mas_equalTo(0);
        //        }];
        _valueLbl =[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 160, 0, 130, 50)];
        self.valueLbl.textAlignment = NSTextAlignmentRight;
        self.valueLbl.font = kFont(14);
        self.valueLbl.textColor = kGrayColor;
    }
    return _valueLbl;
}
-(UISwitch *)myswith{
    if (!_myswith) {
        _myswith = [[UISwitch alloc] init];
        _myswith.on = NO;
        //        //设置开启状态的风格颜色
        //        [_myswith setOnTintColor:[UIColor orangeColor]];
        //        //设置开关圆按钮的风格颜色
        //        [_myswith setThumbTintColor:[UIColor blueColor]];
        //        //设置整体风格颜色,按钮的白色是整个父布局的背景颜色
        //        [_myswith setTintColor:[UIColor greenColor]];
        [_myswith addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _myswith;
}
//参数传入开关对象本身
- (void)swChange:(UISwitch*) sw{
    
    if(sw.on==YES){
        NSLog(@"开关被打开");
    }else{
        NSLog(@"开关被关闭");
    }
}
-(void)setNamestring:(NSString *)namestring{
    self.nameLbl.text = namestring;
    if (_style == DDSingleSelectStyleSelectImg) {
        _ra_btn.nameString = namestring;
    }
}
-(void)setValuestring:(NSString *)valuestring{
    self.valueLbl.text = valuestring;
}
-(void)setCenterText:(NSString *)centerText{
    self.centerLbl.text = centerText;
}
-(void)setValueColor:(UIColor *)valueColor{
    self.valueLbl.textColor = valueColor;
}

-(void)setStyle:(DDSettingCellStyle)style{
    switch (style) {
        case DDSettingCellStyleNormal: {
            [self.ra_btn removeFromSuperview];
            [self.centerLbl removeFromSuperview];
            [self.myswith removeFromSuperview];
            [self.contentView addSubview:self.nameLbl];
            [self.contentView addSubview:self.valueLbl];
        }
            break;
        case DDSettingCellStyleCentertext: {
            [self.ra_btn removeFromSuperview];
            [self.nameLbl removeFromSuperview];
            [self.valueLbl removeFromSuperview];
            [self.myswith removeFromSuperview];
            [self.contentView addSubview:self.centerLbl];
        }
            break;
        case DDSettingCellStyleSwitch: {
            [self.ra_btn removeFromSuperview];
            [self.centerLbl removeFromSuperview];
            [self.valueLbl removeFromSuperview];
            [self.contentView addSubview:self.nameLbl];
            [self.contentView addSubview:self.myswith];
            [_myswith mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(self.contentView);
            }];
        }break;
        case DDSettingCellStyleSelectImg:{
            
        }break;
        case DDSingleSelectStyleSelectImg:{
            [self.valueLbl removeFromSuperview];
            [self.myswith removeFromSuperview];
            [self.centerLbl removeFromSuperview];
            _ra_btn = [[DDRadioButton alloc] initWithDelegate:self groupId:@"selected"];
            [self.contentView addSubview:self.ra_btn];
            [_ra_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-DDFitWidth(10.f));
                make.height.width.mas_equalTo(DDFitWidth(25.f));
            }];
            [self.contentView addSubview:self.nameLbl];
        }break;
        default:
            break;
    }
}

- (void)didSelectedRadioButton:(DDRadioButton *)radio groupId:(NSString *)groupId {
    NSString *statu = [NSString string];
    if ([_nameLbl.text isEqualToString:@"公开所有人"]) {
        statu = @"0";
    }
    if ([_nameLbl.text isEqualToString:@"仅好友可见"]) {
        statu = @"1";
    }
    if ([_nameLbl.text isEqualToString:@"所有人都不可见"]) {
        statu = @"2";
    }
    if (_setPrivacy) {
        _setPrivacy(statu);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
















