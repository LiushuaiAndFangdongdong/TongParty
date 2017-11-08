//
//  LSCDTitleItemView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDTitleItemView.h"

@interface LSCDTitleItemView ()
@property (nonatomic, strong)UIImageView *iv_header;
@property (nonatomic, strong)UILabel     *lbl_title;
@end

@implementation LSCDTitleItemView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    _iv_header = [UIImageView new];
    [self addSubview:self.iv_header];
    [_iv_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.mas_equalTo(DDFitWidth(10.f));
        make.height.width.mas_equalTo(DDFitHeight(18.f));
    }];
    
    _lbl_title = [UILabel new];
    [self addSubview:self.lbl_title];
    [_lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(_iv_header);
        make.left.equalTo(_iv_header.mas_right).offset(DDFitWidth(10.f));
    }];
    
    _lbl_title.textColor = kBlackColor;
    _lbl_title.font = DDFitFont(14.f);
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _iv_header.image = _image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _lbl_title.text = _title;
}
@end
