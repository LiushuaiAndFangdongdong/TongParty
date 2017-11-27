//
//  DDHomeListTableCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeListTableCell.h"
#import "NHDiscoverModel.h"         //model
#import "UIView+Layer.h"            //view的边角
#import "NSString+Size.h"           //计算字符串的size
#import "NSAttributedString+Size.h" //计算字符串的size

//文字的颜色
#define kDiscoverTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]

@interface DDHomeListTableCell()
/** 头像*/
@property (nonatomic, weak) UIImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 主题*/
@property (nonatomic, weak) UILabel *contentL;
/** 参加人数*/
@property (nonatomic, weak) UILabel *joinPeoplesL;
/** 距离*/
@property (nonatomic, weak) UILabel *distanceL;

/** 分割线*/
@property (nonatomic, weak) CALayer *lineLayer;
/** 关键字*/
@property (nonatomic, copy) NSString *keyWord;
@end

@implementation DDHomeListTableCell

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel {
    _elementModel = elementModel;
    if (elementModel.intro) {
        self.contentL.attributedText = [DDUtils attStringWithString:elementModel.intro keyWord:self.keyWord font:kFont(12) highlightedColor:kCommonHighLightRedColor textColor:kDiscoverTextColor];
    }
    if (elementModel.name) {
        self.nameL.attributedText = [DDUtils attStringWithString:elementModel.name keyWord:self.keyWord font:kFont(15) highlightedColor:kCommonHighLightRedColor textColor:kBlackColor];
    }
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:elementModel.icon_url]];
    self.joinPeoplesL.text = [NSString stringWithFormat:@"%ld 订阅", (long)elementModel.subscribe_count];
    NSString *totalText =  [NSString stringWithFormat:@"总贴数 %ld", (long)elementModel.today_updates];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:totalText];
    NSRange range = [totalText rangeOfString:@"总贴数 "];
    if (range.location != NSNotFound) {
        NSRange countRange = NSMakeRange(range.length, totalText.length - range.length);
        [string addAttribute:NSFontAttributeName value:kFont(12) range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:kDiscoverTextColor range:range];
        [string addAttribute:NSForegroundColorAttributeName value:kCommonHighLightRedColor range:countRange];
        self.distanceL.attributedText = string;
    }
}

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel keyWord:(NSString *)keyWord {
    _keyWord = keyWord;
    self.elementModel = elementModel;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
    }
    return _nameL;
}

- (UILabel *)joinPeoplesL {
    if (!_joinPeoplesL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _joinPeoplesL = label;
        label.font = kFont(12);
        label.textColor = kDiscoverTextColor;
    }
    return _joinPeoplesL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
    }
    return _contentL;
}

- (UILabel *)distanceL {
    if (!_distanceL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _distanceL = label;
        label.font = kFont(12);
    }
    return _distanceL;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
//        img.layerCornerRadius = 20;
    }
    return _iconImg;
}


- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.contentView.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = kDiscoverTextColor.CGColor;
    }
    return _lineLayer;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconH = self.contentView.height - iconY * 2;
    CGFloat iconW = iconH;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImg.layerCornerRadius = iconW/2;
    
    CGFloat nameW = self.contentView.width - self.iconImg.right - 15  - 15 - 10;
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat contentX = nameX;
    CGFloat contentY = self.nameL.bottom + 8;
    CGFloat contentW = nameW;
    CGFloat contentH = nameH;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat orderX = nameX;
    CGFloat orderY = self.contentL.bottom + 5;
    CGFloat orderH = nameH;
    CGFloat orderW = [self.joinPeoplesL.text widthWithFont:self.joinPeoplesL.font constrainedToHeight:orderH];
    self.joinPeoplesL.frame = CGRectMake(orderX, orderY, orderW, orderH);
    
    CGFloat lineX = self.joinPeoplesL.right + 5;
    CGFloat lineY = orderY + 3;
    CGFloat lineW = 1;
    CGFloat lineH = orderH - 6;
    self.lineLayer.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat totalX = self.joinPeoplesL.right + 11;
    CGFloat totalY = orderY;
    CGFloat totalH = nameH;
    CGFloat totalW = self.contentView.width - totalX;
    self.distanceL.frame = CGRectMake(totalX, totalY, totalW, totalH);
}
@end









