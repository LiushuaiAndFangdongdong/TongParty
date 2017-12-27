//
//  DDPersonInfoTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonInfoTableViewCell.h"
#import "DDBaseImageView.h"
#import "UIView+Layer.h"

@interface DDPersonInfoTableViewCell()
@property (nonatomic, strong) DDBaseImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLbl;
@end

@implementation DDPersonInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(DDBaseImageView *)avatarView{
    if (!_avatarView) {
        _avatarView = [[DDBaseImageView alloc] initWithFrame:CGRectMake(10, 3, 54, 54)];
        _avatarView.layerCornerRadius = 54/2;
    }
    return _avatarView;
}
-(UILabel *)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 50)];
        self.nameLbl.font= kFont(15);
        self.nameLbl.textColor = kBlackColor;
        self.nameLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLbl;
}
-(UILabel *)valueLbl{
    if (!_valueLbl) {
        _valueLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth - 70, 50)];
        self.valueLbl.textAlignment = NSTextAlignmentLeft;
        self.valueLbl.font = kFont(13);
        self.valueLbl.textColor = kGrayColor;
    }
    return _valueLbl;
}
-(void)setNamestring:(NSString *)namestring{
    self.nameLbl.text = namestring;
}
-(void)setValuestring:(NSString *)valuestring{
    self.valueLbl.text = valuestring;
}
- (void)setImageUrl:(NSString *)imageUrl {
    [self.avatarView setImageWithURL:[NSURL URLWithString:imageUrl] placeHolder:kDefaultAvatar];
}
-(void)setStyle:(DDPersonInfoCellStyle)style{
    switch (style) {
        case DDPersonInfoCellStyleNormal:
        {
            [self.contentView addSubview:self.nameLbl];
            [self.contentView addSubview:self.valueLbl];
        }
            break;
        case DDPersonInfoCellStyleAvatar:
        {
            [self.contentView addSubview:self.avatarView];
        }
            break;
        case DDPersonInfoCellStyleLabel:
        {
        }
            break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end












