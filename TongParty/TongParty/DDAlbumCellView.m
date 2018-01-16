//
//  DDAlbumCellView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDAlbumCellView.h"
#import "LSAlbumEtity.h"
#define kIconWidth  15
#define kMarginWidth 10
#define kPicWidth  (kScreenWidth - kMarginWidth*5)/4

@interface DDAlbumCellView()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIImageView *accessView;
@end

@implementation DDAlbumCellView

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
        make.top.mas_equalTo((60-kIconWidth)/2);
        make.left.mas_equalTo(10);
    }];
    self.iconView.image = [UIImage imageNamed:@"usercenter_album"];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(12.5);
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    self.nameLabel.text = @"我的相册";
    self.nameLabel.font = kFont(13);
    
    self.accessView = [UIImageView new];
    [self addSubview:self.accessView];
    [self.accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(kIconWidth-3);
        make.width.mas_equalTo(kIconWidth-5);
        //        make.top.mas_equalTo(15);
        make.centerY.mas_equalTo(self.iconView);
    }];
    self.accessView.image = [UIImage imageNamed:@"usercenter_access"];
}
- (void)updateWithHisUserModel:(LSHisUserInfoModel *)model{
    //表示未登录
    if (![DDUserDefault objectForKey:@"token"]){
        self.accessView.hidden = YES;
    }else{
        self.accessView.hidden = NO;
        if (model.photo) {
            //相册图片
            for (int i = 0; i<4; i++) {
                UIImageView *picView = [[UIImageView alloc] init];
                [self addSubview:picView];
                [picView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
                    make.width.mas_equalTo(kPicWidth);
                    make.bottom.mas_equalTo(-5);
                    make.left.mas_equalTo(kMarginWidth * (i+1) + kPicWidth * i);
                }];
                LSAlbumEtity *entity = [LSAlbumEtity mj_objectWithKeyValues:model.photo[i]];
                [picView sd_setImageWithURL:[NSURL URLWithString:entity.image]];
            }
        }
    }
}
static NSInteger baseTag = 171;
- (void)updateWithUserModel:(LSHisUserInfoModel *)model{
    //表示未登录
    if (![DDUserDefault objectForKey:@"token"]){
        self.accessView.hidden = YES;
        // 清空
        for (int j =0; j < 4; j++) {
            UIImageView *iv = [self viewWithTag:baseTag + j];
            if (iv) {
                [iv removeFromSuperview];
            }
        }
        
    }else{
        self.accessView.hidden = NO;
        if (model.photo) {
            //相册图片
            for (int i = 0; i<4; i++) {
                UIImageView *picView = [[UIImageView alloc] init];
                picView.tag = baseTag + i;
                [self addSubview:picView];
                [picView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
                    make.width.mas_equalTo(kPicWidth);
                    make.bottom.mas_equalTo(-5);
                    make.left.mas_equalTo(kMarginWidth * (i+1) + kPicWidth * i);
                }];
                LSAlbumEtity *entity = [LSAlbumEtity mj_objectWithKeyValues:model.photo[i]];
                [picView sd_setImageWithURL:[NSURL URLWithString:entity.image]];
            }
        }
    }
}
@end








