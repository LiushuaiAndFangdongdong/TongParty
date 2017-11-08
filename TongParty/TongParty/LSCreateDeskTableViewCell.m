//
//  LSCreateDeskTableViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskTableViewCell.h"
#import "LSCreateDeskActionCellView.h"
#import "LSCDTimeAddressView.h"
#import "LSCDMembersCellView.h"
#import "LSCDDescriptionCellView.h"
#import "LSCDJoinDeskCellView.h"
@interface LSCreateDeskTableViewCell ()
// 1
@property (nonatomic, strong)LSCreateDeskActionCellView *view_action;
// 2
@property (nonatomic, strong)LSCDTimeAddressView        *view_startTime;
// 3
@property (nonatomic, strong)LSCDMembersCellView        *view_members;
// 4
@property (nonatomic, strong)LSCDDescriptionCellView    *view_description;
// 5
@property (nonatomic, strong)LSCDJoinDeskCellView       *view_joinDesk;
@end

@implementation LSCreateDeskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (LSCreateDeskActionCellView *)view_action {
    if (!_view_action) {
        _view_action = [[LSCreateDeskActionCellView alloc] init];
    }
    return _view_action;
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
    }
    return _view_startTime;
}

- (LSCDMembersCellView *)view_members {
    if (!_view_members) {
        _view_members = [LSCDMembersCellView new];
    }
    return _view_members;
}

- (LSCDDescriptionCellView *)view_description {
    if (!_view_description) {
        _view_description = [LSCDDescriptionCellView new];
    }
    return _view_description;
}

- (LSCDJoinDeskCellView *)view_joinDesk {
    if (!_view_joinDesk) {
        _view_joinDesk = [LSCDJoinDeskCellView new];
    }
    return _view_joinDesk;
}


- (void)setStyle:(LSCreateDeslCellStyle)style {
    _style = style;
    [_view_action removeFromSuperview];
    [_view_members removeFromSuperview];
    [_view_startTime removeFromSuperview];
    [_view_joinDesk removeFromSuperview];
    [_view_description removeFromSuperview];
    switch (_style) {
        case LSCreateCellSytleActionAndTheme:{
            [self setupActionView];
        }break;
        case LSCreateCellSytleTimeAndAddress:{
            [self setupAddressView];
        }break;
        case LSCreateCellSytleMembersEstimatePerCapita:{
            [self setupMembersView];
        }break;
        case LSCreateCellSytleDescription:{
            [self setupDescriptionView];
        }break;
        case LSCreateCellSytleIsJoinDesk:{
            [self setupJoinDeskView];
        }break;
            
        default:
            break;
    }
    
}


- (void)setupActionView {
    [self.contentView addSubview:self.view_action];
    [_view_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setupAddressView {
    [self.contentView addSubview:self.view_startTime];
    [_view_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setupMembersView {
    [self.contentView addSubview:self.view_members];
    [_view_members mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setupDescriptionView {
    [self.contentView addSubview:self.view_description];
    [_view_description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setupJoinDeskView {
    [self.contentView addSubview:self.view_joinDesk];
    [_view_joinDesk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

// 赋值
- (void)updateWithObj:(id)obj {
    
    switch (_style) {
        case LSCreateCellSytleTimeAndAddress:{
            [_view_startTime putDataToViewWith:obj returnHeight:^(CGFloat height) {
                self.height = height;
            }];
        }break;
        default:
            break;
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
