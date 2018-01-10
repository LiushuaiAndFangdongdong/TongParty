
//
//  DDShopDescTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShopDescTableViewCell.h"
#import "LSShopDetailEntity.h"
@interface DDShopDescTableViewCell()
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *introduceLbl;
@end

@implementation DDShopDescTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
    _titleLbl = [UILabel new];
    [self.contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    _titleLbl.text = @"地点介绍";
    
    _introduceLbl = [UILabel new];
    [self.contentView addSubview:_introduceLbl];
    [_introduceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLbl.mas_bottom).offset(20);
        make.left.mas_equalTo(_titleLbl.mas_left);
        make.right.mas_equalTo(-20);
    }];
    
    _introduceLbl.textColor = kBlackColor;
    _introduceLbl.textAlignment = NSTextAlignmentLeft;
    _introduceLbl.numberOfLines = 0;
    _introduceLbl.font = kFont(15);
}

//重新设置的UITableViewCellframe,---->改变row之间的间距。
- (void)setFrame:(CGRect)frame{
    //    frame.origin.x += 5;
    frame.origin.y += 5;
    frame.size.height -= 5;
    //    frame.size.width -= 10;
    [super setFrame:frame];
}

- (void)updateValueWithModel:(id)model {
    if (!model) {
        return;
    }
    LSShopDetailEntity *shop = (LSShopDetailEntity *)model;
    _introduceLbl.text  = shop.introduction;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
