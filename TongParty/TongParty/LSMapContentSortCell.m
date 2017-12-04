//
//  LSMapContentSortCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSMapContentSortCell.h"
@interface LSMapContentSortCell ()
@property (nonatomic, strong)UILabel           *lbl_title;
@property (nonatomic, strong)UIView            *view_bg_expandMore;
@property (nonatomic, strong)UILabel           *lbl_expandMore;
@property (nonatomic, strong)UIImageView       *iv_expandMore;
@property (nonatomic, strong)UIView            *view_tap_expandMore;
@property (nonatomic, assign)CGFloat           min_height;
@property (nonatomic, strong)NSMutableArray    *array_btns; // 标签按钮容器

@end

static NSInteger label_baseTag = 199999;
@implementation LSMapContentSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kBgWhiteGrayColor;
        [self prepareForReuse];
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.array_btns = [NSMutableArray array];
    [self.contentView addSubview:self.lbl_title];
    [_lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(DDFitHeight(10.f));
        make.height.mas_equalTo(DDFitHeight(15.f));
    }];
    _lbl_title.text = @"狼人杀";
    _lbl_title.textColor = kBlackColor;
    _lbl_title.font = DDFitFont(14.f);
    
    [self.contentView addSubview:self.view_bg_expandMore];
    [_view_bg_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-DDFitHeight(10.f));
        make.height.mas_equalTo(DDFitHeight(10.f));
        make.width.mas_equalTo(DDFitWidth(65.f));
    }];
    
    [self.view_bg_expandMore addSubview:self.iv_expandMore];
    [_iv_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_view_bg_expandMore.mas_height).multipliedBy(0.8f);
        make.width.equalTo(_view_bg_expandMore.mas_height).multipliedBy(1.3f);
        make.centerY.right.equalTo(_view_bg_expandMore);
    }];
    
    [self.view_bg_expandMore addSubview:self.lbl_expandMore];
    [_lbl_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(_view_bg_expandMore);
        make.right.equalTo(_iv_expandMore.mas_left);
    }];
    
    _lbl_expandMore.textColor = kCommonGrayTextColor;
    _lbl_expandMore.textAlignment = NSTextAlignmentRight;
    _lbl_expandMore.font = DDFitFont(12.f);
    
    [self.contentView addSubview:self.view_tap_expandMore];
    [_view_tap_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_view_bg_expandMore);
        make.top.equalTo(_view_bg_expandMore).offset(-DDFitHeight(10.f));
        make.bottom.equalTo(_view_bg_expandMore).offset(DDFitHeight(10.f));
    }];
    [_view_tap_expandMore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMore)]];
    
    _lbl_expandMore.hidden = YES;
    _view_tap_expandMore.hidden = YES;
    _iv_expandMore.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.entity.isShowMore) {
        [self putDataToViewWith:self.entity];
        _lbl_expandMore.text = @"收起部分";
        _iv_expandMore.image = kImage(@"desk_addr_less");
    } else {
        [self putDataToViewWith:self.entity];
        _lbl_expandMore.text = @"展开全部";
        _iv_expandMore.image = kImage(@"desk_addr_more");
    }
}

- (void)putDataToViewWith:(id)obj{
    LSContentSortModel *model = (LSContentSortModel *)obj;
    if (model.label_array.count > 8) {
        _lbl_expandMore.hidden = NO;
        _view_tap_expandMore.hidden = NO;
        _iv_expandMore.hidden = NO;
    }
    if (_array_btns) {
        for (UIButton *btn in _array_btns) {
            [btn removeFromSuperview];
        }
        [_array_btns removeAllObjects];
    }
    CGFloat btn_lableH = DDFitHeight(25.f);
    CGFloat btn_lableW = (kScreenWidth - DDFitWidth(70.f))/4.f;
    NSArray *lableArr = model.label_array;
    if (lableArr.count > 0) {
        for (int btn_count = 0; btn_count < lableArr.count; btn_count++) {
            UIButton *btn_label = [UIButton new];
            int page = btn_count/4;
            int index = btn_count%4;
            btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * index, DDFitHeight(40.f) + (btn_lableH +  DDFitWidth(10.f)) * page, btn_lableW, btn_lableH);
            btn_label.backgroundColor = kWhiteColor;
            btn_label.layer.cornerRadius = 3.f;
            [btn_label setTitle:lableArr[btn_count] forState:UIControlStateNormal];
            [btn_label setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            btn_label.titleLabel.font = DDFitFont(12.f);
            btn_label.tag = label_baseTag + btn_count;
            [_array_btns addObject:btn_label];
            //[btn_label addTarget:self action:@selector(chooseLabel:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn_label];
        }
    }
    
    [self showBtn_label];
}

- (void)showBtn_label {
    if (self.entity.isShowMore) {
        for (UIButton *btn in _array_btns) {
            btn.hidden = NO;
        }
    } else {
        if ( _array_btns.count > 4) {
            for (UIButton *btn in _array_btns) {
                if (btn.tag - label_baseTag >= 8) {
                    btn.hidden = YES;
                }
            }
        }
    }
}

- (UILabel *)lbl_title {
    if (!_lbl_title) {
        _lbl_title = [UILabel new];
    }
    return _lbl_title;
}

- (UIView *)view_bg_expandMore {
    if (!_view_bg_expandMore) {
        _view_bg_expandMore = [UIView new];
    }
    return _view_bg_expandMore;
}

- (UILabel *)lbl_expandMore {
    if (!_lbl_expandMore) {
        _lbl_expandMore = [UILabel new];
    }
    return _lbl_expandMore;
}

- (UIImageView *)iv_expandMore {
    if (!_iv_expandMore) {
        _iv_expandMore = [UIImageView new];
    }
    return _iv_expandMore;
}

- (UIView *)view_tap_expandMore {
    if (!_view_tap_expandMore) {
        _view_tap_expandMore = [UIView new];
    }
    return _view_tap_expandMore;
}


- (void)prepareForReuse {
    [super prepareForReuse];
}

///未展开时的高度
+ (CGFloat)cellDefaultHeight:(LSContentSortModel *)entity {
    if (entity.label_array.count <= 4) {
        return DDFitHeight(70.f);
    }
    if (entity.label_array.count > 4) {
        return DDFitHeight(130.f);
    }
    return 0;
}
///展开后的高度
+(CGFloat)cellMoreHeight:(LSContentSortModel *)entity {
    NSInteger page = entity.label_array.count/4;
    return DDFitHeight(105.f) + DDFitWidth(30.f) * page;
}

- (void)showMore {
    self.entity.isShowMore = !self.entity.isShowMore;
    if (self.showMoreBlock) {
        self.showMoreBlock(self);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
