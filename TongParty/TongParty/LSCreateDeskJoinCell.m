//
//  LSCreateDeskJoinCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskJoinCell.h"
#import "DDRadioButton.h"
#import "LSCDTitleItemView.h"
@interface LSCreateDeskJoinCell ()<DDRadioButtonDelegate>
@property (nonatomic, strong)LSCDTitleItemView *ti_isJoinDesk;
@property (nonatomic, strong)UIImageView       *iv_isJoinDesk;
@property (nonatomic, strong)UILabel           *lbl_yes;
@property (nonatomic, strong)DDRadioButton     *ra_JoinDesk_yes;
@property (nonatomic, strong)UILabel           *lbl_no;
@property (nonatomic, strong)DDRadioButton     *ra_JoinDesk_no;
@end
@implementation LSCreateDeskJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    WeakSelf(weakSelf);
    
    self.backgroundColor = kWhiteColor;
    // 是否加入心跳
    _ti_isJoinDesk = [LSCDTitleItemView new];
    [self addSubview:self.ti_isJoinDesk];
    [_ti_isJoinDesk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
        make.width.mas_equalTo(DDFitWidth(130.f));
    }];
    _ti_isJoinDesk.image = kImage(@"desk_love");
    _ti_isJoinDesk.title = @"是否加入心跳桌";
    
    _iv_isJoinDesk = [UIImageView new];
    [self addSubview:self.iv_isJoinDesk];
    [_iv_isJoinDesk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ti_isJoinDesk.mas_right).offset(DDFitWidth(10.f));
        make.centerY.equalTo(_ti_isJoinDesk);
        make.height.width.mas_equalTo(DDFitHeight(17.f));
    }];
    _iv_isJoinDesk.image = kImage(@"desk_info");
    
    _lbl_yes = [UILabel new];
    [self addSubview:self.lbl_yes];
    [_lbl_yes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_isJoinDesk.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_isJoinDesk);
        make.width.mas_equalTo(DDFitWidth(15.f));
    }];
    _lbl_yes.textColor = kBlackColor;
    _lbl_yes.text = @"是";
    _lbl_yes.font = DDFitFont(14.f);
    
    _ra_JoinDesk_yes = [[DDRadioButton alloc] initWithDelegate:self groupId:@"join"];
    _ra_JoinDesk_yes.nameString = @"yes";
    [self addSubview:self.ra_JoinDesk_yes];
    [_ra_JoinDesk_yes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lbl_yes);
        make.left.equalTo(_lbl_yes.mas_right).offset(DDFitWidth(5.f));
        make.height.width.mas_equalTo(DDFitWidth(25.f));
    }];
    _ra_JoinDesk_yes.checked = YES;
    
    _lbl_no = [UILabel new];
    [self addSubview:self.lbl_no];
    [_lbl_no mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_isJoinDesk.mas_bottom);
        make.left.equalTo(_ra_JoinDesk_yes.mas_right).offset(DDFitWidth(10.f));
        make.height.equalTo(_ti_isJoinDesk);
        make.width.mas_equalTo(DDFitWidth(15.f));
    }];
    _lbl_no.textColor = kBlackColor;
    _lbl_no.text = @"否";
    _lbl_no.font = DDFitFont(14.f);
    
    _ra_JoinDesk_no = [[DDRadioButton alloc] initWithDelegate:self groupId:@"join"];
    _ra_JoinDesk_no.nameString = @"no";
    [self addSubview:self.ra_JoinDesk_no];
    [_ra_JoinDesk_no mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lbl_yes);
        make.left.equalTo(_lbl_no.mas_right).offset(DDFitWidth(5.f));
        make.height.width.mas_equalTo(DDFitWidth(25.f));
    }];
    
}


- (void)didSelectedRadioButton:(DDRadioButton *)radio groupId:(NSString *)groupId {

    if ([radio.nameString isEqualToString:@"no"]) {
        self.isHeart = @"0";
    }
    if ([radio.nameString isEqualToString:@"yes"]) {
        self.isHeart = @"1";
    }
    
    if (_selectIsHeart) {
        _selectIsHeart(self.isHeart);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
