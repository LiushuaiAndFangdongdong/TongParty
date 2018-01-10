

//
//  DDUserCircleView.m
//  TongParty
//
//  Created by 方冬冬 on 2018/1/8.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDUserCircleView.h"

@interface DDUserCircleView()
@property (nonatomic, strong) UIImageView *watermelonView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UIImageView *cardView;
@property (nonatomic, strong) UILabel *titleLbl;
@end

@implementation DDUserCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}
-(void)customUI{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    int x = arc4random() % 6;
    NSString *wa = [NSString stringWithFormat:@"watermelon%d",x];
    _watermelonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height/2)];
    _watermelonView.image = kImage(wa);
    [self addSubview:_watermelonView];
    
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((width -(height/2 - 20 +20))/2, -20, height/2 - 20 +20 , height/2 - 20 +20)];
    _avatarView.layerCornerRadius = (height/2 - 20 +20)/2;
    [_watermelonView addSubview:_avatarView];
    
    _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, height/2 - 20, width, 20)];
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _nameLbl.font = kFont(13);
    _nameLbl.textColor = kWhiteColor;
    [_watermelonView addSubview:_nameLbl];
    
    _sexView = [[UIImageView alloc ]initWithFrame:CGRectMake(_avatarView.width - 10, _avatarView.height - 10, 10, 10)];
    [_avatarView addSubview:_sexView];
    
    NSString *dropstr = [NSString stringWithFormat:@"drop_card%d",arc4random() % 4];
    _cardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height/2, width, height/2)];
    _cardView.image = kImage(dropstr);
    [self addSubview:_cardView];
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _cardView.height - 20, width, 20)];
    _titleLbl.font = kFont(13);
    _titleLbl.textColor = kBlackColor;
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [_cardView addSubview:_titleLbl];
    
}

- (void)updateCircleUserWithModel:(DDNearUserModel *)model{
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kDefaultAvatar];
    _nameLbl.text = model.name;
    if ([model.sex intValue] == 1) {
        _sexView.image = kImage(@"info_male");
    }else if ([model.sex intValue] == 2){
        _sexView.image = kImage(@"info_female");
    }else{}
    _titleLbl.text  =model.custom;
}
@end















