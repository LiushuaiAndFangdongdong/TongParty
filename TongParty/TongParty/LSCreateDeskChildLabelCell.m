//
//  LSCreateDeskChildLabelCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskChildLabelCell.h"
#import "LSCDTimeAddressView.h"

@interface LSCreateDeskChildLabelCell ()
@property (nonatomic, strong)LSCDTimeAddressView       *view_startTime;
@end
@implementation LSCreateDeskChildLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAddressView];
    }
    return self;
}


- (LSCDTimeAddressView *)view_startTime {
    WeakSelf(weakSelf);
    if (!_view_startTime) {
        _view_startTime = [[LSCDTimeAddressView alloc] init];
        weakSelf.view_startTime.onClickBlcok = ^(NSInteger index) {
            if (_onClickBlcok) {
                _onClickBlcok(index);
            }
        };
        weakSelf.view_startTime.expandMoreBlcok = ^(CGFloat final_height) {
            if (_expandMoreBlcok) {
                _expandMoreBlcok(final_height);
            }
        };
    }
    return _view_startTime;
}

- (void)setupAddressView {
    [self.contentView addSubview:self.view_startTime];
    [_view_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

// 赋值
- (void)updateWithObj:(id)obj {
    
    [_view_startTime putDataToViewWith:obj returnHeight:^(CGFloat height) {
        self.height = height;
        NSLog(@"heiht~~~~~~~~~~~~~~~~~~~~~~%lf",self.height);
    }];
}

@end
