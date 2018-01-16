
//
//  DDInterestTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/3.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestTableViewCell.h"
#import "DDStatusAvatar.h"
#import "UIButton+DDImagePosition.h"

@interface DDInterestTableViewCell()
@property (nonatomic, strong) DDStatusAvatar *sAvatar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *numPerople;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *horizontalLine;
@property (nonatomic, strong) UIButton*storeBtn;
@property (nonatomic, strong) UIButton *addressBtn;

@end

@implementation DDInterestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _sAvatar = [DDStatusAvatar new];
    [self.contentView addSubview:_sAvatar];
    [_sAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(80);
    }];
//    _sAvatar.avatarstring  = @"avatar_default";
//    _sAvatar.statusstring  = @"desklist_status_host";
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sAvatar);
        make.left.mas_equalTo(_sAvatar.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-5);
    }];
//    _titleLabel.text = @"狼人杀";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = kFont(15);
    
    _subjectLabel = [UILabel new];
    [self.contentView addSubview:_subjectLabel];
    [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
//    _subjectLabel.text = @"主题：大家一起嗨，祖居懒跟啥";
    _subjectLabel.textColor = kGrayColor;
    _subjectLabel.font = kFont(13);
    
    _timeBtn = [UIButton new];
    [self.contentView addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_subjectLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_subjectLabel);
//        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
//    [_timeBtn setTitle:@"09:00" forState:UIControlStateNormal];
    [_timeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = kFont(12);
    [_timeBtn setImage:kImage(@"desklist_clock") forState:UIControlStateNormal];
    [_timeBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    _numPerople = [UIButton new];
    [self.contentView addSubview:_numPerople];
    [_numPerople mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(_timeBtn);
        make.left.mas_equalTo(_timeBtn.mas_right).offset(10.f);
//        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
//    [_numPerople setTitle:@"10人" forState:UIControlStateNormal];
    [_numPerople setTitleColor:kGrayColor forState:UIControlStateNormal];
    _numPerople.titleLabel.font = kFont(12);
    [_numPerople setImage:kImage(@"desklist_people") forState:UIControlStateNormal];
    [_numPerople layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    
    
    _distanceLabel = [UILabel new];
    [self.contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_numPerople.mas_top);
        make.left.mas_equalTo(_numPerople.mas_right).offset(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.font = kFont(12);
    _distanceLabel.textColor = kGrayColor;
//    _distanceLabel.text = @"198m | 10人已参加";
    
    _horizontalLine = [UILabel new];
    [self.contentView addSubview:_horizontalLine];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_numPerople.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(1);
    }];
    _horizontalLine.backgroundColor = kSeperatorColor;

    _storeBtn = [UIButton new];
    [self.contentView addSubview:_storeBtn];
    [_storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horizontalLine.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
//    [_storeBtn setTitle:@"望京咖啡厅" forState:UIControlStateNormal];
    [_storeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    _storeBtn.titleLabel.font = kFont(13);
    [_storeBtn setImage:kImage(@"merchant_store") forState:UIControlStateNormal];
    [_storeBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    _storeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _storeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    _addressBtn = [UIButton new];
    [self.contentView addSubview:_addressBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_storeBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
//    [_addressBtn setTitle:@"北京市海淀区中关村" forState:UIControlStateNormal];
    [_addressBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = kFont(13);
    [_addressBtn setImage:kImage(@"desklist_address") forState:UIControlStateNormal];
    [_addressBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _joinedBtn = [UIButton new];
    [self.contentView addSubview:_joinedBtn];
    [_joinedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    _joinedBtn.layerCornerRadius = 5;
    _joinedBtn.layerBorderWidth = 1;
    _joinedBtn.layerBorderColor = kBgGreenColor;
//    [_joinedBtn setTitle:@"加入" forState:UIControlStateNormal];
    [_joinedBtn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
    _joinedBtn.titleLabel.font = kFont(13);
    [_joinedBtn setImage:kImage(@"finger_join") forState:UIControlStateNormal];
    _joinedBtn.hidden = YES;
    [_joinedBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:2];
}


- (void)updateWithModel:(DDTableModel *)model{
    if (!model) {
        return;
    }
    _sAvatar.avatarstring  = model.image;
    _titleLabel.text = model.title;
    _subjectLabel.text = [NSString stringWithFormat:@"主题：%@",model.custom];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *begion_timeDate = [formatter dateFromString:model.begin_time];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *beginStr = [formatter1 stringFromDate:begion_timeDate];
    [_timeBtn setTitle:beginStr forState:UIControlStateNormal];
    [_numPerople setTitle:model.person_num forState:UIControlStateNormal];
    double distance = model.distance.doubleValue;
    NSString *dstanceStr;
    if (distance >= 100) {
        dstanceStr = [NSString stringWithFormat:@"%.f%@",distance/1000.f,@"km"];
    } else {
        dstanceStr = [NSString stringWithFormat:@"%d%@",(int)distance,@"m"];
    }
    
    _distanceLabel.text = [NSString stringWithFormat:@"%@ | %@人已参加",dstanceStr,model.num];
     [_storeBtn setTitle:model.shop_name forState:UIControlStateNormal];
    [_addressBtn setTitle:model.place forState:UIControlStateNormal];
    if ([model.type intValue] == 1) {
        _sAvatar.statusstring  = @"desklist_status_host";
    }else if ([model.type intValue] == 2){
        _sAvatar.statusstring  = @"desklist_status_join";
    }else if ([model.type intValue] == 3){
        _sAvatar.statusstring  = @"desklist_status_apply";
    }else{
    }
    
    if (model.status) {
        switch (model.status.integerValue) {
            case 0:{
                // 不可以
                [_joinedBtn setImage:kImage(@"supplied") forState:UIControlStateNormal];
                }break;
            case 1:{
                // 可以加入
                [_joinedBtn setImage:kImage(@"finger_join") forState:UIControlStateNormal];
            }break;
            default:
                break;
        }
    }
}

//重新设置的UITableViewCellframe,---->改变row之间的间距。
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 5;
    frame.size.height -= 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end














