//
//  DDTongCoinView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTongCoinView.h"

#define kCoinWidth  (kScreenWidth - 40 - 30*4)/3
#define kCoinHight  kCoinWidth/1.17

@interface DDTongCoinView()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *tongLabel;
@property (nonatomic, strong) UILabel *rmbLabel;
@end
//分割线上下比例65/46 =1.4
@implementation DDTongCoinView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    self.bgView = [UIImageView new];
    [self addSubview:self.bgView];
     [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(0);
     }];
    self.bgView.image = kImage(@"person_tongcoincharge_default");
    
    self.tongLabel = [UILabel new];
    [self.bgView addSubview:self.tongLabel];
     [self.tongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.and.right.mas_equalTo(0);
         make.top.mas_equalTo(0);
         make.height.mas_equalTo(kCoinHight/2.4*1.4);
     }];
    self.tongLabel.textAlignment = NSTextAlignmentCenter;
    self.tongLabel.font = kFont(12);
    
    self.rmbLabel = [UILabel new];
    [self.bgView addSubview:self.rmbLabel];
    [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kCoinHight/2.4);
    }];
    self.rmbLabel.textAlignment = NSTextAlignmentCenter;
    self.rmbLabel.font = kFont(12);
}
-(void)setRmbstring:(NSString *)rmbstring{
    self.rmbLabel.text = rmbstring;
}
-(void)setTongstring:(NSString *)tongstring{
    self.tongLabel.text = tongstring;
}
@end













