
//
//  DDRewardCellView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDRewardCellView.h"
#import "UIView+Layer.h"

#define kIconWidth  15

@interface DDRewardCellView()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *splitLabel;
@property (nonatomic, strong) UILabel *coinLabel;
//@property (nonatomic, strong) UIImageView *accessView;
@property (nonatomic, strong) UIButton *accessBtn;
@end

@implementation DDRewardCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)setupViews{
    
    self.iconView = [UIImageView new];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kIconWidth);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
    }];
    self.iconView.image = [UIImage imageNamed:@"usercenter_gift"];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.width.mas_equalTo(60);
    }];
    self.nameLabel.text = @"打赏明细";
    self.nameLabel.font = kFont(13);
    
    self.splitLabel = [UILabel new];
    [self addSubview:self.splitLabel];
    [self.splitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        make.top.mas_equalTo(18);
        make.bottom.mas_equalTo(-18);
        make.width.mas_equalTo(1);
    }];
    self.splitLabel.backgroundColor = kLightGrayColor;
    
    self.accessBtn = [UIButton new];
    [self addSubview:self.accessBtn];
    
    self.coinLabel = [UILabel new];
    [self addSubview:self.coinLabel];
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.splitLabel.mas_right).offset(8);
        make.right.mas_equalTo(self.accessBtn.mas_left).offset(-15);
        make.centerY.mas_equalTo(self);
    }];
    self.coinLabel.textAlignment = NSTextAlignmentLeft;
    self.coinLabel.text = @"0桐币";
    self.coinLabel.font = kFont(13);
    self.coinLabel.textColor = kGrayColor;
}
- (void)updateWithModel:(DDUserInfoModel *)model{
    if (![DDUserDefault objectForKey:@"token"]){
        self.accessBtn.hidden = YES;
        self.splitLabel.hidden= YES;
        self.coinLabel.hidden = YES;
    }else{
        self.accessBtn.hidden = NO;
        self.splitLabel.hidden= NO;
        self.coinLabel.hidden = NO;
        if (model.be_coin) {
            self.coinLabel.text = model.be_coin;
        }
    }
}

-(void)setType:(DDRewardType)type{
    switch (type) {
        case DDRewardTypeNormal:
        {
            [self.accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(kIconWidth-3);
                make.width.mas_equalTo(kIconWidth-5);
                make.centerY.mas_equalTo(self);
            }];
            [self.accessBtn setBackgroundImage:[UIImage imageNamed:@"usercenter_access"] forState:UIControlStateNormal];
        }
        break;
        case DDRewardTypeHis:
        {
            [self.accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(60);
                make.centerY.mas_equalTo(self);
            }];
            [self.accessBtn setTitle:@"打赏" forState:UIControlStateNormal];
            [self.accessBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            self.accessBtn.titleLabel.font = kFont(13);
            self.accessBtn.layerBorderColor = kBgGreenColor;
            self.accessBtn.layerBorderWidth = 0.5;
        }break;
        default:
            break;
    }
}
@end










