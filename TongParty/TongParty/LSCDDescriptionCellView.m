//
//  LSCDDescriptionCellView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDDescriptionCellView.h"
#import "LSCDTitleItemView.h"
@interface LSCDDescriptionCellView ()
@property (nonatomic, strong)LSCDTitleItemView *ti_decription;
@property (nonatomic, strong)UITextField       *tf_decription_content;
@property (nonatomic, strong)UIImageView       *iv_photos_show;
@property (nonatomic, strong)UILabel           *lbl_photo_des;
@property (nonatomic, strong)UILabel           *lbl_decription_line;
@end

@implementation LSCDDescriptionCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    
    self.backgroundColor = kWhiteColor;
    // 活动
    _ti_decription = [LSCDTitleItemView new];
    [self addSubview:self.ti_decription];
    [_ti_decription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_decription.image = kImage(@"desk_descri");
    _ti_decription.title = @"描述：";
    
    _tf_decription_content = [UITextField new];
    [self addSubview:self.tf_decription_content];
    [_tf_decription_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_decription.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_decription);
        make.right.equalTo(weakSelf);
    }];
    _tf_decription_content.placeholder = @"关于桌子的描述...";
    _tf_decription_content.font = DDFitFont(14.f);
    
    _iv_photos_show = [UIImageView new];
    [self addSubview:self.iv_photos_show];
    [_iv_photos_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.width.mas_equalTo(DDFitHeight(70.f));
        make.top.equalTo(_tf_decription_content.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _iv_photos_show.image = kImage(@"desk_imgadd_default");
    
    _lbl_photo_des = [UILabel new];
    [self addSubview:self.lbl_photo_des];
    [_lbl_photo_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.equalTo(_ti_decription);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_iv_photos_show.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _lbl_photo_des.text = @"(第一张图默认为桌头像)";
    _lbl_photo_des.textColor = kCommonGrayTextColor;
    _lbl_photo_des.font = DDFitFont(14.f);
    
    _lbl_decription_line = [UILabel new];
    [self addSubview:self.lbl_decription_line];
    [_lbl_decription_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_lbl_photo_des.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _lbl_decription_line.backgroundColor = kLineBgColor;
}

@end
