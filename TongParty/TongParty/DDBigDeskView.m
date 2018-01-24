//
//  DDBigDeskView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBigDeskView.h"
#import "DDNoticeView.h"
#import "DDChairView.h"
#import "UIView+Frame.h"

#define kDeskHeight   (self.width-100)*1.75
#define kLeftScrollViewHight  (kDeskHeight - 40)
#define kLeftChairWidth   self.width*0.13
//放几个椅子个数
#define kLeftChairNumbers  3
#define kLeftChairMargin  (kLeftScrollViewHight - kLeftChairWidth*kLeftChairNumbers)/(kLeftChairNumbers+1)

@interface DDBigDeskView()
@property (nonatomic, assign) int holderTopMargin;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) DDNoticeView *noticeView;     //公告
@property (nonatomic, strong) DDChairView *holderView;      //桌主椅子
@property (nonatomic, strong) DDChairView *bottomChariView; //下边椅子
@property (nonatomic, strong) UIScrollView *leftChairScrollview;  //左边滚动椅子
@property (nonatomic, strong) UIScrollView *rightChairScrollview; //右边滚动椅子
@end

@implementation DDBigDeskView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    self.bgView = [[UIView alloc] init];
    [self addSubview:self.bgView];
#pragma mark - 桌主椅子
    self.holderView  = [DDChairView new];
    [self.bgView addSubview:self.holderView];
#pragma mark - 公告
    self.noticeView = [DDNoticeView new];
    [self.bgView addSubview:self.noticeView];
#pragma mark - 左边滚动椅子
    self.leftChairScrollview = [[UIScrollView alloc] init];
    [self.bgView addSubview:self.leftChairScrollview];
#pragma mark - 右边滚动椅子
    self.rightChairScrollview = [[UIScrollView alloc] init];
    [self.bgView addSubview:self.rightChairScrollview];
#pragma mark - 桌子背景
    self.deskView = [DDDeskView new];
    [self.bgView addSubview:self.deskView];
#pragma mark - 下边椅子
    self.bottomChariView  = [DDChairView new];
    [self.bgView addSubview:self.bottomChariView];
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height);
    }];

    [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_holderTopMargin);
        make.width.mas_equalTo(kLeftChairWidth);
        make.height.mas_equalTo(kLeftChairWidth+20);
        make.left.mas_equalTo((self.width-kLeftChairWidth)/2);
    }];
    self.holderView.type = DDChairTypeHolder;
    
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.holderView.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    
    
#pragma mark - 左边滚动的椅子 --------------------------
    [self.leftChairScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(kLeftScrollViewHight);
        if (self.noticeView.hidden == NO) {
            make.top.mas_equalTo(self.noticeView.mas_bottom);
        }else{
            make.top.mas_equalTo(self.holderView.mas_bottom);
        }
    }];

#pragma mark - 右边滚动的椅子 --------------------------
    [self.rightChairScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftChairScrollview.mas_top);
        make.width.mas_equalTo(65);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLeftScrollViewHight);
    }];
    
    [self.deskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(kDeskHeight);
        make.width.mas_equalTo(self.width - 100);
        if (self.noticeView.hidden == NO) {
            make.top.mas_equalTo(self.noticeView.mas_bottom).offset(-23);
        }else{
            make.top.mas_equalTo(self.holderView.mas_bottom).offset(-23);
        }
    }];
    
    [self.bottomChariView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.deskView.mas_bottom).offset(-20);
        make.width.mas_equalTo(kLeftChairWidth);
        make.height.mas_equalTo(kLeftChairWidth);
        make.left.mas_equalTo((self.width-kLeftChairWidth)/2);
    }];
    self.bottomChariView.type = DDChairTypeBottom;
}

-(void)setType:(DDDeskShowType)type{
    switch (type) {
        case DDDeskShowTypeNormal:
        {
            _holderTopMargin = 20;
            self.noticeView.hidden = NO;
            self.bottomChariView.hidden = YES;
        }
            break;
        case DDDeskShowTypeCard:
        {
            _holderTopMargin = 5;
            self.noticeView.hidden = YES;
            self.bottomChariView.hidden = YES;
        }
            break;
        case DDDeskShowTypeVisitor:
        {
            _holderTopMargin = 20;
            self.noticeView.hidden = NO;
            self.bottomChariView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)updateVistorAvatar:(NSString *)vistorImage{
    [self.bottomChariView updateAvatarWithImage:vistorImage];
}

#pragma mark - 更新参与者椅子信息
- (void)updatePartsWithArray:(NSArray <DDParticipantModel*>*)array  person_num:(NSString *)person_num{
    //左边椅子数
    int leftChairs = 0;
    //右边椅子数
    int rightChairs = 0;
    
    int person_numValue = [person_num intValue];

    if (person_numValue % 2 == 0) {//如果是偶数
        
        //偶数左右椅子数相等
        leftChairs = rightChairs = (int)person_numValue /2;
        
    }else{//如果是奇数
        
        //奇数左边数量是取余加上取商，右边取商，即左比右多一
        leftChairs = (int)person_numValue/2 + (int)person_numValue % 2;
        rightChairs = (int)person_numValue/2;
    }
    
    for (int i = 0; i < leftChairs; i ++ ) {
        DDChairView *leftChair = [DDChairView new];
        [self.leftChairScrollview addSubview:leftChair];
        [leftChair mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kLeftChairWidth);
            make.width.mas_equalTo(kLeftChairWidth);
            make.centerX.mas_equalTo(self.leftChairScrollview.centerX).offset(5);
            make.top.mas_equalTo(kLeftChairMargin*(i+1)+i*kLeftChairWidth);
        }];
        leftChair.type = DDChairTypeLeft;
        self.leftChairScrollview.contentSize = CGSizeMake(0, kLeftChairMargin*(i+2)+(i+1)*kLeftChairWidth);
        
            if (i  < array.count) {
                DDParticipantModel *model = array[i];
                [leftChair updateAvatarWithImage:model.image];
            }else{
                [leftChair updateAvatarWithImage:nil];
            }


    }
    
    for (int i = 0; i < rightChairs; i ++ ) {
        DDChairView *rightChair = [DDChairView new];
        [self.rightChairScrollview addSubview:rightChair];
        [rightChair mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kLeftChairWidth);
            make.width.mas_equalTo(kLeftChairWidth);
            make.centerX.mas_equalTo(self.rightChairScrollview.centerX).offset(0);
            make.top.mas_equalTo(kLeftChairMargin*(i+1)+i*kLeftChairWidth);
        }];
        rightChair.type = DDChairTypeRight;
        self.rightChairScrollview.contentSize = CGSizeMake(0, kLeftChairMargin*(i+2)+(i+1)*kLeftChairWidth);
       
        int extra =(int)array.count - leftChairs;
            if (i  < extra) {
                DDParticipantModel *model = array[i + leftChairs];
                [rightChair updateAvatarWithImage:model.image];
            }else{
                [rightChair updateAvatarWithImage:nil];
            }

   
    }

}

#pragma mark - 更新桌子信息以及桌主信息
- (void)updateDeskInfoModel:(DDTableInfoModel *)model{
    [_holderView updateAvatarWithImage:model.image];
    [_deskView updateDeskInfoWithModel:model];
}
#pragma mark - 更新桌子公告
- (void)updateNoticeWith:(NSString *)notice{
    _noticeView.noticeString = notice;
}
@end




