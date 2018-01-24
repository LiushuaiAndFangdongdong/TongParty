
//
//  DDHisUsercenterTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHisUsercenterTableViewCell.h"
#import "DDSexInfoView.h"
#import "DDNumbersTextView.h"
#import "DDRewardCellView.h"
#import "DDAlbumCellView.h"
#import "DDActivitiesHisCellView.h"

#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

@interface DDHisUsercenterTableViewCell()
@property (nonatomic, strong) DDSexInfoView *infoView;
@property (nonatomic, strong) DDNumbersTextView *ntView;  //
@property (nonatomic, strong) DDRewardCellView  *rewardView;
@property (nonatomic, strong) DDAlbumCellView   *albumView;
@property (nonatomic, strong) DDActivitiesHisCellView *activitiesHisView;
@end

@implementation DDHisUsercenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (DDSexInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[DDSexInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    }
    return _infoView;
}
-(DDNumbersTextView *)ntView{
    if (!_ntView) {
        _ntView =[[DDNumbersTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _ntView.type = DDNumbersTextViewTypeOthers;
        WeakSelf(weakSelf)
        weakSelf.ntView.variousNumbersClickBlcok = ^(NSInteger index) {
            if (_variousNumberClickBlcok) {
                _variousNumberClickBlcok(index);
            }
        };
        weakSelf.ntView.careBtnClickBlcok = ^(BOOL isCare) {
            weakSelf.careBtnClickBlcok(isCare);
        };
    }
    return _ntView;
}
-(DDRewardCellView *)rewardView{
    WeakSelf(weakSelf);
    if (!_rewardView) {
        _rewardView =[[DDRewardCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _rewardView.type = DDRewardTypeHis;
        _rewardView.playReward = ^{
            if (weakSelf.playReward) {
                weakSelf.playReward();
            }
        };
    }
    return _rewardView;
}
-(DDAlbumCellView *)albumView{
    if (!_albumView) {
        _albumView =[[DDAlbumCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    }
    return _albumView;
}
-(DDActivitiesHisCellView  *)activitiesHisView{
    if (!_activitiesHisView) {
        _activitiesHisView =[[DDActivitiesHisCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60+kActivityItemWidth+20)];
        WeakSelf(weakSelf)
        weakSelf.activitiesHisView.activityHistoryClickBlcok = ^(NSInteger index) {
            if (_activityHistoryClickBlcok) {
                _activityHistoryClickBlcok(index);
            }
        };
    }
    return _activitiesHisView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setStyle:(DDHisUserCellStyle)style{
    switch (style) {
        case DDHisUserCellStyleUserInfo:
        {
            [self.contentView addSubview:self.infoView];
        }
            break;
        case DDHisUserCellStyleVariousNumbers:
        {
            [self.contentView addSubview:self.ntView];
        }
            break;
        case DDHisUserCellStyleTongCoin:
        {
            [self.contentView addSubview:self.rewardView];
        }
            break;
        case DDHisUserCellStyleAlbum:
        {
            [self.contentView addSubview:self.albumView];
        }
            break;
        case DDHisUserCellStyleActivities:
        {
            [self.contentView addSubview:self.activitiesHisView];
        }
            break;
        default:
            break;
    }
}

- (void)updateValueWith:(id)model {
    [_infoView updateValueWithModel:model];
    [_ntView updateWithModel:model withType:DDNumbersTextViewTypeOthers];

    [_albumView updateWithHisUserModel:model];
    LSHisUserInfoModel *m = (LSHisUserInfoModel *)model;
    if (m.table.count == 0 || !m) {
        self.activitiesHisView.height = 60;
    }else{
        self.activitiesHisView.height = 60+kActivityItemWidth+20;
    }
    if (!m && m.photo && m.photo.count > 0) {
        self.albumView.height = 60.f;
    } else {
        self.albumView.height = 130.f;
    }
}

@end














