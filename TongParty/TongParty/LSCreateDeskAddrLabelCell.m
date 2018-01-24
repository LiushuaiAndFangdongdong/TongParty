//
//  LSCreateDeskAddrLabelCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskAddrLabelCell.h"
#import "LSAddressLabelEntity.h"
@interface LSCreateDeskAddrLabelCell (){
    CGFloat finalH;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_btn_background_constraint;
@property (nonnull, strong)NSArray *labels;
@end
@implementation LSCreateDeskAddrLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)updatePhotoWithArray:(NSDictionary *)dict {
    _labels = dict[@"array"];
    NSString *isexpand = dict[@"isexpand"]; // 0 展开  1 不展
    if (!_labels) {
        return;
    }
    if (isexpand.integerValue == 0) {
        [self.btn_expandMore setTitle:@"收起部分" forState:UIControlStateNormal];
    } else {
        [self.btn_expandMore setTitle:@"展开全部" forState:UIControlStateNormal];
    }
    
    for (id obj in self.view_label_background.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            [theButton removeFromSuperview];
        }
    }
    
    if (_labels.count > 4) {
        self.view_btn_background_constraint.constant = DDFitHeight(75.f);
    }
    if (_labels.count <= 4) {
        self.view_btn_background_constraint.constant = DDFitHeight(35.f);
    }
    
    if (_labels.count <= 8) {
        self.btn_expandMore.hidden = YES;
    }
    
    CGFloat btn_lableH = DDFitHeight(25.f);
    CGFloat btn_lableW = (kScreenWidth - DDFitWidth(70.f))/4.f;
    
    for (int btn_count = 0; btn_count < _labels.count; btn_count++) {
        UIButton *btn_label = [UIButton new];
        LSAddressLabelEntity *einty = _labels[btn_count];
        if (btn_count < 4) {
            btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * btn_count, DDFitHeight(10.f), btn_lableW, btn_lableH);
        }else {
            int page = btn_count/4;
            int index = btn_count%4;
            btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * index, DDFitHeight(10.f) + (btn_lableH +  DDFitWidth(10.f)) * page, btn_lableW, btn_lableH);
        }
        if (btn_count == _labels.count - 1) {
           finalH = btn_label.frame.origin.y + 30;
        }
        
        if (btn_count >= 8) {
            btn_label.hidden = YES;
        }
        btn_label.layer.borderColor = kCommonGrayTextColor.CGColor;
        btn_label.layer.borderWidth = kLineHeight;
        btn_label.layer.cornerRadius = 3.f;
        [btn_label setTitle:einty.name forState:UIControlStateNormal];
        [btn_label setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn_label.titleLabel.font = DDFitFont(12.f);
//        [btn_label addTarget:self action:@selector(chooseLabel:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_label_background addSubview:btn_label];
    }
    
    if (isexpand.integerValue == 0) {
        // 展示所有标签
        for (id obj in self.view_label_background.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton* theButton = (UIButton*)obj;
                theButton.hidden = NO;
            }
        }
        
        if (_labels) {
            if (_labels.count <= 8 && _labels.count > 4) {
                self.view_btn_background_constraint.constant = DDFitHeight(DDFitHeight(75.f));
            }
            if (_labels.count <= 4) {
                self.view_btn_background_constraint.constant = DDFitHeight(DDFitHeight(35.f));
            }
            
            if (_labels.count > 8) {
                self.view_btn_background_constraint.constant = DDFitHeight(finalH);
            }
        }
        [self layoutIfNeeded];
        return;
    }
    [self layoutIfNeeded];
}
- (IBAction)expandMore:(id)sender {
    if (_expandMoreBlcok) {
        _expandMoreBlcok();
    }
}
- (IBAction)managerAddress:(id)sender {
    if (_managerAddressBlcok) {
        _managerAddressBlcok();
    }
}

@end
