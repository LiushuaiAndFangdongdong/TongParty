//
//  LSCreateDeskAddPicCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskAddPicCell.h"

@interface LSCreateDeskAddPicCell ()
@property (weak, nonatomic) IBOutlet UIView *view_pictrues;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_pictrues_constraint;


@end
@implementation LSCreateDeskAddPicCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updatePhotoWithArray:(NSArray *)photosArr {
    
    if (!photosArr) {
        return;
    }
    
    // 清除
    for (id obj in self.view_pictrues.subviews) {
        if ([obj isKindOfClass:[LSCDPhotoIV class]]) {
            LSCDPhotoIV* lp = (LSCDPhotoIV*)obj;
            [lp removeFromSuperview];
        }
    }
    CGFloat iv_btn_H = (self.view_pictrues.frame.size.width - 30)/4;
    if (photosArr.count > 0) {
        for (int i = 0; i < photosArr.count; i++) {
            if (i >= 5) {
                break;
            }
            CGFloat ivH;
            CGFloat ivW;
            if (i == 4) {
                ivH = iv_btn_H + 20;
                ivW = 10;
            } else {
                ivH = 10;
                ivW = 10 + (iv_btn_H + 10)*i;
            }
            LSCDPhotoIV *iv_btn = [[LSCDPhotoIV alloc] initWithFrame:CGRectMake(ivW, ivH , iv_btn_H, iv_btn_H)];
            iv_btn.userInteractionEnabled = YES;
            iv_btn.image = photosArr[i];
            iv_btn.index = i;
            iv_btn.deleteClicked = ^(NSInteger idx) {
                
                if (_deleteClicked) {
                    _deleteClicked(idx);
                }
            };
            
            [self.view_pictrues addSubview:iv_btn];
            
            if (i == 4 && photosArr.count >= 5) {
                self.view_pictrues_constraint.constant = DDFitHeight(iv_btn_H * 2) + 25;
                break;
            }
            self.view_pictrues_constraint.constant = DDFitHeight(iv_btn_H) + 15;
            [self layoutIfNeeded];
        }
        
        if (photosArr.count < 5) {
            CGFloat addH;
            CGFloat addW;
            if (photosArr.count - 1 >= 3) {
                addH = iv_btn_H + 20;
                addW = 10;
                self.view_pictrues_constraint.constant = DDFitHeight(iv_btn_H * 2) + 25;
            } else {
                self.view_pictrues_constraint.constant = DDFitHeight(iv_btn_H) + 15;
                addH = 10;
                addW = 10 + (iv_btn_H + 10)*(photosArr.count);
            }
            LSCDPhotoIV *add_iv_btn = [[LSCDPhotoIV alloc] initWithFrame:CGRectMake(addW, addH, iv_btn_H, iv_btn_H)];
            [self.view_pictrues addSubview:add_iv_btn];
            add_iv_btn.isClose = NO;
            add_iv_btn.image = kImage(@"desk_imgadd_default");
            add_iv_btn.userInteractionEnabled = YES;
            [add_iv_btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotos:)]];
        }
    } else {
        LSCDPhotoIV *add_iv_btn = [[LSCDPhotoIV alloc] initWithFrame:CGRectMake(10, 5, iv_btn_H, iv_btn_H)];
        [self.view_pictrues addSubview:add_iv_btn];
        add_iv_btn.isClose = NO;
        add_iv_btn.image = kImage(@"desk_imgadd_default");
        self.view_pictrues_constraint.constant = DDFitHeight(iv_btn_H) + 15;
        add_iv_btn.userInteractionEnabled = YES;
        [add_iv_btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotos:)]];
    }
    [self layoutIfNeeded];
}

#pragma mark - 添加图片
- (void)addPhotos:(UITapGestureRecognizer *)tap {
    if (_selectPhotos) {
        _selectPhotos((LSCDPhotoIV *)tap.view);
    }
}

@end
