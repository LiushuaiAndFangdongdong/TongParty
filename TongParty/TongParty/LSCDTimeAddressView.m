//
//  LSCDTimeAddressView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDTimeAddressView.h"
#import "LSCDTitleItemView.h"


@interface LSCDTimeAddressView ()
@property (nonatomic, strong)LSCDTitleItemView *ti_startTime;
@property (nonatomic, strong)UITextField       *tf_startTime_content;
@property (nonatomic, strong)UILabel           *lbl_startTime_line;
@property (nonatomic, strong)LSCDTitleItemView *ti_address;
@property (nonatomic, strong)UITextField       *tf_address_content;
@property (nonatomic, strong)UILabel           *lbl_address_line;
@property (nonatomic, strong)UILabel           *lbl_myAddress_Des;
@property (nonatomic, strong)UIButton          *btn_managerAddress;
@property (nonatomic, strong)UIButton          *btn_recommendAddress;
@property (nonatomic, strong)UIView            *view_bg_expandMore;
@property (nonatomic, strong)UILabel          *lbl_expandMore;
@property (nonatomic, strong)UIImageView       *iv_expandMore;
@property (nonatomic, strong)UIView            *view_tap_expandMore;
@property (nonatomic, strong)UIButton          *btn_temp;
@end
static NSInteger baseTag = 88888;
static NSInteger label_baseTag = 99999;
@implementation LSCDTimeAddressView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    
    self.backgroundColor = kWhiteColor;
    // 开始时间
    _ti_startTime = [LSCDTitleItemView new];
    [self addSubview:self.ti_startTime];
    [_ti_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_startTime.image = kImage(@"desk_starttime");
    _ti_startTime.title = @"开始时间：";
    
    _tf_startTime_content = [UITextField new];
    [self addSubview:self.tf_startTime_content];
    [_tf_startTime_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_startTime.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_startTime);
        make.right.equalTo(weakSelf);
    }];
    _tf_startTime_content.placeholder = @"2017年10月28日 星期二 13:00";
    _tf_startTime_content.font = DDFitFont(14.f);
    
    _lbl_startTime_line = [UILabel new];
    [self addSubview:self.lbl_startTime_line];
    [_lbl_startTime_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_startTime_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_startTime_content.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _lbl_startTime_line.backgroundColor = kLineBgColor;
    
    
    // 所在地点
    _ti_address = [LSCDTitleItemView new];
    [self addSubview:self.ti_address];
    [_ti_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_startTime_line.mas_bottom);
        make.left.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_address.image = kImage(@"desk_address");
    _ti_address.title = @"所在地点：";
    
    _tf_address_content = [UITextField new];
    [self addSubview:self.tf_address_content];
    [_tf_address_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_address.mas_bottom).offset(DDFitHeight(3.f));
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_address);
        make.right.equalTo(weakSelf);
    }];
    _tf_address_content.placeholder = @"请选择活动地点";
    _tf_address_content.font = DDFitFont(14.f);
    
    _btn_recommendAddress = [[UIButton alloc] init];
    [self addSubview:self.btn_recommendAddress];
    [_btn_recommendAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_ti_address).multipliedBy(0.8f);
        make.centerY.equalTo(_tf_address_content);
        make.right.mas_equalTo(-DDFitWidth(10.f));
        make.width.mas_equalTo(80.f);
    }];
    _btn_recommendAddress.tag = 0 + baseTag;
    [_btn_recommendAddress setTitle:@"推荐地点" forState:UIControlStateNormal];
    _btn_recommendAddress.titleLabel.font = DDFitFont(14.f);
    [_btn_recommendAddress setTitleColor:kOrangeColor forState:UIControlStateNormal];
    [_btn_recommendAddress addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _lbl_address_line = [UILabel new];
    [self addSubview:self.lbl_address_line];
    [_lbl_address_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_address_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_address_content.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_address_line.backgroundColor = kLineBgColor;
    
    _lbl_myAddress_Des = [UILabel new];
    [self addSubview:self.lbl_myAddress_Des];
    [_lbl_myAddress_Des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DDFitWidth(10.f));
        make.height.equalTo(_ti_address);
        make.top.equalTo(_lbl_address_line.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_myAddress_Des.textColor = kBlackColor;
    _lbl_myAddress_Des.text = @"我的地点";
    _lbl_myAddress_Des.font = DDFitFont(14.f);
    
    
    _btn_managerAddress = [UIButton new];
    [self addSubview:self.btn_managerAddress];
    [_btn_managerAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_ti_address).multipliedBy(0.75f);
        make.centerY.equalTo(_lbl_myAddress_Des);
        make.right.mas_equalTo(-DDFitWidth(10.f));
        make.width.mas_equalTo(80.f);
    }];
    _btn_managerAddress.tag = 1 + baseTag;
    [_btn_managerAddress setTitle:@"管理地点" forState:UIControlStateNormal];
    _btn_managerAddress.titleLabel.font = DDFitFont(14.f);
    [_btn_managerAddress setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_btn_managerAddress setBackgroundImage:[UIImage imageNamed:@"desk_manage_address"] forState:UIControlStateNormal];
    [_btn_managerAddress addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _view_bg_expandMore = [UIView new];
    [self addSubview:self.view_bg_expandMore];
    [_view_bg_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-DDFitHeight(10.f));
        make.height.mas_equalTo(DDFitHeight(10.f));
        make.width.mas_equalTo(DDFitWidth(65.f));
    }];
    
    _iv_expandMore = [UIImageView new];
    [self.view_bg_expandMore addSubview:self.iv_expandMore];
    [_iv_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_view_bg_expandMore.mas_height).multipliedBy(0.8f);
        make.width.equalTo(_view_bg_expandMore.mas_height).multipliedBy(1.3f);
        make.centerY.right.equalTo(_view_bg_expandMore);
    }];
    _iv_expandMore.image = kImage(@"desk_addr_more");
    
    _lbl_expandMore = [UILabel new];
    [self.view_bg_expandMore addSubview:self.lbl_expandMore];
    [_lbl_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(_view_bg_expandMore);
        make.right.equalTo(_iv_expandMore.mas_left);
    }];
    _lbl_expandMore.text = @"展开更多";
    _lbl_expandMore.textColor = kCommonGrayTextColor;
    _lbl_expandMore.textAlignment = NSTextAlignmentRight;
    _lbl_expandMore.font = DDFitFont(12.f);
    
    _view_tap_expandMore = [UIView new];
    [self addSubview:self.view_tap_expandMore];
    [_view_tap_expandMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_view_bg_expandMore);
    }];
    [_view_tap_expandMore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandMore:)]];
}

- (void)onClicked:(UIButton *)sender {
    if (_onClickBlcok) {
        _onClickBlcok(sender.tag - baseTag);
    }
}

- (void)expandMore:(UITapGestureRecognizer *)tap {
    if (_expandMoreBlcok) {
        _expandMoreBlcok(1);
    }
}


- (void)putDataToViewWith:(id)obj returnHeight:(void (^)(CGFloat))height{
    
    CGFloat btn_lableH = DDFitHeight(25.f);
    CGFloat btn_lableW = (kScreenWidth - DDFitWidth(70.f))/4.f;
    NSArray *lableArr = (NSArray *)obj;
    if (lableArr.count > 0) {
        for (int btn_count = 0; btn_count < lableArr.count; btn_count++) {
            UIButton *btn_label = [UIButton new];
            if (btn_count < 4) {
                btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * btn_count, DDFitHeight(170.f), btn_lableW, btn_lableH);
            }else {
                int page = btn_count/4;
                int index = btn_count%4;
                btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * index, DDFitHeight(170.f) + (btn_lableH +  DDFitWidth(10.f)) * page, btn_lableW, btn_lableH);
            }
            btn_label.layer.borderColor = kCommonGrayTextColor.CGColor;
            btn_label.layer.borderWidth = kLineHeight;
            btn_label.layer.cornerRadius = 3.f;
            [btn_label setTitle:lableArr[btn_count] forState:UIControlStateNormal];
            [btn_label setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            btn_label.titleLabel.font = DDFitFont(12.f);
            btn_label.tag = label_baseTag + btn_count;
            [btn_label addTarget:self action:@selector(chooseLabel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn_label];
            if (btn_count == lableArr.count - 1) {
                height(self.height = btn_label.bottom + DDFitWidth(10.f));
                
            }
        }
    }
    
}

- (void)chooseLabel:(UIButton *)sender {
    
    if (_btn_temp) {
        [_btn_temp setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        _btn_temp.backgroundColor = kWhiteColor;
    }
    _tf_address_content.text = sender.titleLabel.text;
    sender.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    [sender setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _btn_temp = sender;
    
    
}

@end
