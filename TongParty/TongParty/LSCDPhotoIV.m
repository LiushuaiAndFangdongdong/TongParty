//
//  LSCDPhotoIV.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDPhotoIV.h"

@interface LSCDPhotoIV ()
@property (nonatomic, strong)UIButton *delete_btn;
@end
@implementation LSCDPhotoIV


- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.delete_btn];
        [_delete_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(DDFitHeight(8.5f));
            make.top.mas_offset(DDFitHeight(-8.5f));
            make.height.width.mas_equalTo(DDFitHeight(18.f));
        }];
    }
    return self;
}

- (UIButton *)delete_btn {
    if (!_delete_btn) {
        _delete_btn = [UIButton new];
        _delete_btn.hidden = YES;
        [_delete_btn setBackgroundImage:kImage(@"desk_delete") forState:UIControlStateNormal];
        [_delete_btn addTarget:self action:@selector(deleteSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delete_btn;
}

- (void)deleteSelf:(UIButton *)sender {
    if (_deleteClicked) {
        _deleteClicked(self.tag);
    }
}

- (void)setIsClose:(BOOL)isClose {
    _isClose = isClose;
    if (!_isClose) {
        _delete_btn.hidden = NO;
    }
}

@end
