//
//  LSCDDescriptionCellView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDDescriptionCellView.h"
#import "LSCDTitleItemView.h"
#import "LSCreatDeskEntity.h"

@interface LSCDDescriptionCellView ()
@property (nonatomic, strong)LSCDTitleItemView *ti_decription;
@property (nonatomic, strong)UITextField       *tf_decription_content;
@property (nonatomic, strong)UILabel           *lbl_photo_des;
@property (nonatomic, strong)UILabel           *lbl_decription_line;
@property (nonatomic, strong)LSCDPhotoIV       *iv_photos_show;
@property (nonatomic, strong)LSCDPhotoIV       *iv_photos_show1;
@property (nonatomic, strong)LSCDPhotoIV       *iv_photos_show2;
@property (nonatomic, strong)LSCDPhotoIV       *iv_photos_show3;
@property (nonatomic, strong)LSCDPhotoIV       *iv_photos_show4;
@property (nonatomic, strong)LSCreatDeskEntity *entity;
@end
static NSInteger baseTag = 363398279;
@implementation LSCDDescriptionCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    CGFloat margion = -(self.frame.size.width - DDFitWidth(74.f))/8.f;
    self.backgroundColor = kWhiteColor;
    // 活动
    _ti_decription = [LSCDTitleItemView new];
    [self addSubview:self.ti_decription];
    [_ti_decription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_decription.image = kImage(@"desk_descri");
    _ti_decription.title = @"描述：";
    
    _tf_decription_content = [UITextField new];
    [self addSubview:self.tf_decription_content];
    [_tf_decription_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_decription.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_decription);
        make.right.equalTo(weakSelf);
    }];
    _tf_decription_content.placeholder = @"关于桌子的描述...";
    _tf_decription_content.font = DDFitFont(14.f);
    
    _iv_photos_show = [LSCDPhotoIV new];
    [self addSubview:self.iv_photos_show];
    [_iv_photos_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.width.mas_equalTo(DDFitHeight(70.f));
        make.top.equalTo(_tf_decription_content.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _iv_photos_show.image = kImage(@"desk_imgadd_default");
    
    _iv_photos_show1 = [LSCDPhotoIV new];
    [self addSubview:self.iv_photos_show1];
    [_iv_photos_show1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_iv_photos_show);
        make.left.equalTo(_iv_photos_show.mas_right).offset(margion);
    }];
    _iv_photos_show1.hidden = YES;
    _iv_photos_show1.image = kImage(@"desk_imgadd_default");
    
    _iv_photos_show2 = [LSCDPhotoIV new];
    [self addSubview:self.iv_photos_show2];
    [_iv_photos_show2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_iv_photos_show);
        make.left.equalTo(_iv_photos_show1.mas_right).offset(margion);
    }];
    _iv_photos_show2.hidden = YES;
    _iv_photos_show2.image = kImage(@"desk_imgadd_default");
    
    _iv_photos_show3 = [LSCDPhotoIV new];
    [self addSubview:self.iv_photos_show3];
    [_iv_photos_show3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_iv_photos_show);
        make.left.equalTo(_iv_photos_show2.mas_right).offset(margion);
    }];
    _iv_photos_show3.hidden = YES;
    _iv_photos_show3.image = kImage(@"desk_imgadd_default");
    
    _iv_photos_show4 = [LSCDPhotoIV new];
    [self addSubview:self.iv_photos_show4];
    [_iv_photos_show4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(_iv_photos_show);
        make.left.equalTo(_iv_photos_show);
        make.top.equalTo(_iv_photos_show.mas_bottom).offset(DDFitHeight(20.f));
    }];
    _iv_photos_show4.hidden = YES;
    _iv_photos_show4.image = kImage(@"desk_imgadd_default");
    
    _lbl_decription_line = [UILabel new];
    [self addSubview:self.lbl_decription_line];
    [_lbl_decription_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.bottom.equalTo(self.mas_bottom).offset(-DDFitHeight(20.f));
    }];
    _lbl_decription_line.backgroundColor = kLineBgColor;
    
    _lbl_photo_des = [UILabel new];
    [self addSubview:self.lbl_photo_des];
    [_lbl_photo_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_decription_content);
        make.height.equalTo(_ti_decription);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.bottom.equalTo(_lbl_decription_line.mas_top).offset(-DDFitHeight(5.f));
    }];
    _lbl_photo_des.text = @"(第一张图默认为桌头像)";
    _lbl_photo_des.textColor = kCommonGrayTextColor;
    _lbl_photo_des.font = DDFitFont(14.f);
    
    NSArray *image_shows_array = @[_iv_photos_show,_iv_photos_show1,_iv_photos_show2,_iv_photos_show3,_iv_photos_show4];
    
    for (int i = 0 ; i < image_shows_array.count; i++) {
        LSCDPhotoIV *iv = image_shows_array[i];
        iv.tag = baseTag + i;
        iv.userInteractionEnabled = YES;
        iv.deleteClicked = ^(NSInteger tag) {
            if (weakSelf.deleteUpdate) {
                weakSelf.deleteUpdate(tag - baseTag);
            }
        };
        [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotos:)]];
    }
}

#pragma mark - 添加图片
- (void)addPhotos:(UITapGestureRecognizer *)tap {
    _entity.dEscription = _tf_decription_content.text;
    if (_selectPhotos) {
        _selectPhotos((LSCDPhotoIV *)tap.view);
    }
}

- (void)putPhotosWhitModel:(id)obj {
    self.entity = (LSCreatDeskEntity *)obj;
    _tf_decription_content.text = _entity.dEscription;
    NSArray *image_shows_array = @[_iv_photos_show,_iv_photos_show1,_iv_photos_show2,_iv_photos_show3,_iv_photos_show4];
    if(_entity.Images.count > 0) { // 如果有图片，根据图片的数量显示，留一个添加按钮
        for (int i = 0 ; i <= _entity.Images.count; i++) {
            LSCDPhotoIV *iv = image_shows_array[i];
            if (i == _entity.Images.count) {
                iv.hidden = NO;
                iv.image = kImage(@"desk_imgadd_default");
            } else {
                iv.hidden = NO;
                iv.image = _entity.Images[i];
                iv.isClose = NO;
            }
        }
    } else { // 如果没有图片，显示第一个添加按钮
        for (LSCDPhotoIV *ivj in image_shows_array) {
            if (ivj.tag - baseTag == 0) {
                ivj.hidden = NO;
                ivj.isClose = YES;
            } else {
                ivj.hidden = YES;
            }
        }
    }
}

- (void)setEntity:(LSCreatDeskEntity *)entity {
    _entity = entity;
}

@end
