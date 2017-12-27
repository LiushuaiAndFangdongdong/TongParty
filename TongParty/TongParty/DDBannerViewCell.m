//
//  DDBannerViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBannerViewCell.h"

@interface DDBannerViewCell()
/** 轮播图*/
@property (weak, nonatomic) UIImageView *imgView;
/** 标题*/
@property (nonatomic, weak) UILabel *titleL;
@end

@implementation DDBannerViewCell
- (UILabel *)titleL {
    if (!_titleL) {
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        _titleL = title;
        title.font = kFont(14);
        title.textColor = kWhiteColor;
        WeakSelf(weakSelf);
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).mas_offset(10);
            make.bottom.equalTo(weakSelf.contentView).mas_offset(-5);
            make.height.mas_equalTo(15);
        }];
    }
    return _titleL;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        _imgView = img;
        WeakSelf(weakSelf);
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.contentView);
        }];
    }
    return _imgView;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    if (url.length) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"banner_default")];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (title.length) {
        self.titleL.text = title;
    }
}

@end
