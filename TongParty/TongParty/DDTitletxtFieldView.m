//
//  DDTitletxtFieldView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTitletxtFieldView.h"


@interface DDTitletxtFieldView()
@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DDTitletxtFieldView
//图标 宽高比25/40 = 0.625
-(void)setTitlestring:(NSString *)titlestring{
    self.titleLabel.text =titlestring;
}
-(void)setTitleImagestr:(NSString *)titleImagestr{
    self.titleView.image = kImage(titleImagestr);
}
-(void)setPloceholderstr:(NSString *)ploceholderstr{
    self.textView.placehoder = ploceholderstr;
}
-(void)setStyle:(DDTextFieldStyle)style {
    switch (style) {
        case DDTextFieldStyleNormal:
        {
            [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(0);
            }];
        }
            break;
        case DDTextFieldStyleText:
        {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
            }];
            
            [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
                make.right.mas_equalTo(0);
            }];
        }
            break;
        case  DDTextFieldStyleImage:
        {
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(20);
                make.width.mas_equalTo(20*0.625);
            }];
            
            [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(self.titleView.mas_right).offset(10);
                make.right.mas_equalTo(0);
            }];
            
        }break;
        default:
            break;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    self.backgroundColor = kWhiteColor;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = kBlackColor;
    self.titleLabel.font = kFont(13);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.titleView = [[UIImageView alloc] init];
    [self addSubview:self.titleView];
    
    self.textView = [[DDCustomPlaceHolderTextView alloc] init];
    self.textView.placeholderTopMargin = 18;
    self.textView.placeholderFont = kFont(13);
    [self addSubview:self.textView];
    
}
@end









