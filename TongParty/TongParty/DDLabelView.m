//
//  DDLabelView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLabelView.h"
#import "UIView+Layer.h"

@interface DDLabelView()
@property (nonatomic, strong) UILabel *textLbl;
@end

@implementation DDLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    
//    self.backgroundColor = kLabelBgBlackColor;
    _textLbl = [UILabel new];
    [self addSubview:_textLbl];
    [_textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _textLbl.textColor = kWhiteColor;
    _textLbl.font = kFont(10);
    _textLbl.textAlignment = NSTextAlignmentCenter;
    _textLbl.numberOfLines = 2;
}
-(void)setTextstring:(NSString *)textstring{
    self.textLbl.text = textstring;
}
-(void)setBgColor:(UIColor *)bgColor{
    self.backgroundColor = bgColor;
}
@end









