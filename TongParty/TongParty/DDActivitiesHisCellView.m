//
//  DDActivitiesHisCellView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDActivitiesHisCellView.h"
#import "DDLabelView.h"
#import "UIView+Layer.h"

#define kIconWidth  15
#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

@interface DDActivitiesHisCellView()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *nameLabel;
@end

@implementation DDActivitiesHisCellView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.iconView = [UIImageView new];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kIconWidth);
        make.top.mas_equalTo((60-kIconWidth)/2);
        make.left.mas_equalTo(10);
    }];
    self.iconView.image = [UIImage imageNamed:@"usercenter_activities"];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(12.5);
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    self.nameLabel.text = @"活动历史";
    self.nameLabel.font = kFont(13);
}
- (void)updateWithModel:(DDUserInfoModel *)model;{
    
    //表示未登录
    if (![DDUserDefault objectForKey:@"token"])return;
    
    if (model.ct_num || model.jt_num) {
        
        UIScrollView *scrollView = [UIScrollView new];
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
            make.bottom.mas_equalTo(-5);
            make.left.and.right.mas_equalTo(0);
        }];
        
        int n = 10;
        for (int i=0; i<n; i++) {
            //圆形活动
            DDLabelView *labelView = [DDLabelView new];
            [scrollView addSubview:labelView];
            [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.and.height.mas_equalTo(kActivityItemWidth);
                make.top.mas_equalTo(5);
                make.left.mas_equalTo(kMarginGapWidth * (i+1) + kActivityItemWidth * i);
            }];
            labelView.bgColor = kLightGreenColor;
            labelView.textstring = @"狼人杀";
            labelView.layerCornerRadius = kActivityItemWidth/2;
            labelView.tag = i+10;
            [labelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activitiesItemClick:)]];
            
            //中间的连线
            UILabel *linkline = [UILabel new];
            [scrollView addSubview:linkline];
            [linkline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(1);
                make.left.mas_equalTo(labelView.mas_right).offset(1);
                make.width.mas_equalTo(kMarginGapWidth - 2*1);
                make.top.mas_equalTo(5+kActivityItemWidth/2);
            }];
            linkline.backgroundColor = kLightGrayColor;
            if (i == n- 1) {
                linkline.hidden = YES;
            }
            
            //时间
            UILabel *timeLbl  =[UILabel new];
            [scrollView addSubview:timeLbl];
            [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(labelView.mas_bottom).offset(5);
                make.width.mas_equalTo(kActivityItemWidth);
                make.height.mas_equalTo(20);
                make.left.mas_equalTo(labelView.mas_left);
            }];
            timeLbl.text = @"9月26号";
            timeLbl.font = kFont(12);
            timeLbl.textAlignment = NSTextAlignmentCenter;
            timeLbl.textColor = kGrayColor ;
            
            scrollView.contentSize = CGSizeMake((i+1)*kActivityItemWidth + kMarginGapWidth * (i+2), 0);
        }
    }
}
-(void)activitiesItemClick:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",[tap view].tag);
    if (_activityHistoryClickBlcok) {
        _activityHistoryClickBlcok([tap view].tag - 100);
    }
}
@end











