
//
//  DDUsercenterTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDUsercenterTableViewCell.h"
#import "DDNumbersTextView.h"
#import "DDRewardCellView.h"
#import "DDAlbumCellView.h"
#import "DDActivitiesHisCellView.h"

#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

@interface  DDUsercenterTableViewCell()
@property (nonatomic, strong) DDNumbersTextView *ntView;  //
@property (nonatomic, strong) DDRewardCellView  *rewardView;
@property (nonatomic, strong) DDAlbumCellView   *albumView;
@property (nonatomic, strong) DDActivitiesHisCellView *activitiesHisView;
@end

@implementation DDUsercenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(DDNumbersTextView *)ntView{
    if (!_ntView) {
        _ntView =[[DDNumbersTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _ntView.type = DDNumbersTextViewTypeNormal;
        WeakSelf(weakSelf)
        weakSelf.ntView.variousNumbersClickBlcok = ^(NSInteger index) {
            if (_variousNumberClickBlcok) {
                _variousNumberClickBlcok(index);
            }
        };
    }
    return _ntView;
}
-(DDRewardCellView *)rewardView{
    if (!_rewardView) {
        _rewardView =[[DDRewardCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _rewardView.type = DDRewardTypeNormal;
    }
    return _rewardView;
}
-(DDAlbumCellView *)albumView{
    if (!_albumView) {
        _albumView =[[DDAlbumCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
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

-(void)setStyle:(DDUserCellStyle)style{
    switch (style) {
        case DDUserCellStyleVariousNumbers:
        {
            [self.contentView addSubview:self.ntView];
        }
            break;
        case DDUserCellStyleTongCoin:
        {
            [self.contentView addSubview:self.rewardView];
        }
            break;
        case DDUserCellStyleAlbum:
        {
            [self.contentView addSubview:self.albumView];
        }
            break;
        case DDUserCellStyleActivities:
        {
            [self.contentView addSubview:self.activitiesHisView];
        }
            break;
        default:
            break;
    }
}

- (void)updateWithModel:(DDUserInfoModel *)model{
    [self.ntView updateWithModel:model];
    [self.rewardView updateWithModel:model];
    [self.albumView updateWithModel:model];
    [self.activitiesHisView updateWithModel:model];
}

@end



































