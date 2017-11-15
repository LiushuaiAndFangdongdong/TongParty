//
//  DDDeskView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskView.h"
#import "DDCountDownLabel.h"

#define kSeLineHeight  3
//#define kDeskHeight   self.width*1.75
#define kSignBoardWidth  self.width*140/370
#define kSignBoardHeight  kSignBoardWidth*87/140
#define kDataItemHeight  (self.height - 75 - kSeLineHeight*5 -kSignBoardHeight)/6

@interface DDDeskView()
@property (nonatomic, strong) UIImageView *bgView;    //背景
@property (nonatomic, strong) UIImageView *signBoard; //标题牌
@property (nonatomic, strong) UILabel *titleLbl;      //标题
@property (nonatomic, strong) UILabel *startTimeKey;  //开始时间
@property (nonatomic, strong) UILabel *startTimeVlaue;//开始时间值
@property (nonatomic, strong) UIImageView *lineView0; //分割线
@property (nonatomic, strong) UILabel *countDownKey;  //倒计时
@property (nonatomic, strong) DDCountDownLabel *countDownValue;//倒计时值
@property (nonatomic, strong) UIImageView *lineView1; //分割线
@property (nonatomic, strong) UILabel *numbersPeopleKey;//活动人数
@property (nonatomic, strong) UILabel *numbersPeopleValue;//活动人数值
@property (nonatomic, strong) UIImageView *lineView2; //分割线
@property (nonatomic, strong) UILabel *averagePriceKey;//均价
@property (nonatomic, strong) UILabel *averagePriceValue;//均价值
@property (nonatomic, strong) UIImageView *lineView3; //分割线
@property (nonatomic, strong) UILabel *addressKey;//地址
@property (nonatomic, strong) UILabel *addressValue;//地址值
@property (nonatomic, strong) UIImageView *lineView4; //分割线
@property (nonatomic, strong) UILabel *descrKey;//描述
@property (nonatomic, strong) UILabel *descrValue;//描述值
@end
//桌子的高度(kScreenWidth - 100)*1.7 减去向上向下的偏移25+20 再减去标题牌的高度(kScreenWidth-100)*227/443*114/227 即为6项数据的高度 /6
//标题牌宽高之比：227/114    标题牌占桌子的宽度之比：227/443
@implementation DDDeskView
- (instancetype)init {
    self = [super init];
    if (self) {
//        [self initViews];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgView = [[UIImageView alloc] init];
    [self addSubview:self.bgView];
    self.signBoard = [[UIImageView alloc] init];
    [self.bgView addSubview:self.signBoard];
    self.titleLbl = [[UILabel alloc] init];
    [self.signBoard addSubview:self.titleLbl];
    self.startTimeKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.startTimeKey];
    self.startTimeVlaue = [[UILabel alloc] init];
    [self.bgView addSubview:self.startTimeVlaue];
    self.lineView0 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.lineView0];
    self.countDownKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.countDownKey];
    self.countDownValue = [[DDCountDownLabel alloc] init];
    [self.bgView addSubview:self.countDownValue];
    self.lineView1 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.lineView1];
    self.numbersPeopleKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.numbersPeopleKey];
    self.numbersPeopleValue = [[UILabel alloc] init];
    [self.bgView addSubview:self.numbersPeopleValue];
    self.lineView2 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.lineView2];
    self.averagePriceKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.averagePriceKey];
    self.averagePriceValue = [[UILabel alloc] init];
    [self.bgView addSubview:self.averagePriceValue];
    self.lineView3 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.lineView3];
    self.addressKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.addressKey];
    self.addressValue = [[UILabel alloc] init];
    [self.bgView addSubview:self.addressValue];
    self.lineView4 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.lineView4];
    self.descrKey = [[UILabel alloc] init];
    [self.bgView addSubview:self.descrKey];
    self.descrValue = [[UILabel alloc] init];
    [self.bgView addSubview:self.descrValue];
    

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.bgView.image = kImage(@"desk_bg");
    
    [self.signBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(kSignBoardWidth);
        make.height.mas_equalTo(kSignBoardHeight);
    }];
    self.signBoard.image = kImage(@"desk_signBoard");
    

    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(kSignBoardHeight*48/87);
        make.bottom.mas_equalTo(-kSignBoardHeight*13/87);
    }];
    [self createLabel:self.titleLbl text:@"狼人杀" TextColor:kWhiteColor font:kBoldFont(18) textAlignment:NSTextAlignmentCenter];
  //
    

    [self.startTimeKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signBoard.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
    [self createLabel:self.startTimeKey text:@"开始时间" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];
    

    [self.startTimeVlaue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTimeKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
     [self createLabel:self.startTimeVlaue text:@"10-20 20：08" TextColor:kBlackColor font:kFont(13) textAlignment:NSTextAlignmentCenter];
    

    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTimeVlaue.mas_bottom);
        make.left.mas_equalTo(self.signBoard);
        make.right.mas_equalTo(self.signBoard);
        make.height.mas_equalTo(kSeLineHeight);
    }];
    self.lineView0.image = kImage(@"desk_itemsLine_red1");
    

    [self.countDownKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView0.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
     [self createLabel:self.countDownKey text:@"倒计时" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];
    
#pragma mark - 倒计时

    [self.countDownValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
    [self createLabel:self.countDownValue text:nil TextColor:kRedColor font:kFont(13) textAlignment:NSTextAlignmentCenter];
    self.countDownValue.hour = 2;
    self.countDownValue.minute = 11;
    self.countDownValue.second = 30;
    

    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownValue.mas_bottom);
        make.left.mas_equalTo(self.signBoard);
        make.right.mas_equalTo(self.signBoard);
        make.height.mas_equalTo(kSeLineHeight);
    }];
    self.lineView1.image = kImage(@"desk_itemsLine_green");
    

    
    
    
    
    [self.numbersPeopleKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView1.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
   [self createLabel:self.numbersPeopleKey text:@"活动人数" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];
    

    [self.numbersPeopleValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numbersPeopleKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
       [self createLabel:self.numbersPeopleValue text:@"16" TextColor:kBlackColor font:kFont(13) textAlignment:NSTextAlignmentCenter];

    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numbersPeopleValue.mas_bottom);
        make.left.mas_equalTo(self.signBoard);
        make.right.mas_equalTo(self.signBoard);
        make.height.mas_equalTo(kSeLineHeight);
    }];
    self.lineView2.image = kImage(@"desk_itemsLine_green1");
    

    [self.averagePriceKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView2.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
       [self createLabel:self.averagePriceKey text:@"人均价格" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];
    

    [self.averagePriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.averagePriceKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
     [self createLabel:self.averagePriceValue text:@"16元/人" TextColor:kBlackColor font:kFont(13) textAlignment:NSTextAlignmentCenter];
    

    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.averagePriceValue.mas_bottom);
        make.left.mas_equalTo(self.signBoard);
        make.right.mas_equalTo(self.signBoard);
        make.height.mas_equalTo(kSeLineHeight);
    }];
    self.lineView3.image = kImage(@"desk_itemsLine_blue");
    

    [self.addressKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView3.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
     [self createLabel:self.addressKey text:@"地址" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];
    

    
    [self.addressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
    self.addressValue.numberOfLines = 2;
      [self createLabel:self.addressValue text:@"北京市海淀区阜成路北8号楼" TextColor:kBlackColor font:kFont(11) textAlignment:NSTextAlignmentCenter];
    

    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressValue.mas_bottom);
        make.left.mas_equalTo(self.signBoard);
        make.right.mas_equalTo(self.signBoard);
        make.height.mas_equalTo(kSeLineHeight);
    }];
    self.lineView4.image = kImage(@"desk_itemsLine_red");
    

    
    [self.descrKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView4.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
    [self createLabel:self.descrKey text:@"描述" TextColor:kBlackColor font:kFont(12) textAlignment:NSTextAlignmentCenter];

    [self.descrValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descrKey.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kDataItemHeight/2);
    }];
    self.descrValue.numberOfLines = 2;
       [self createLabel:self.descrValue text:@"玩的开心就好" TextColor:kBlackColor font:kFont(13) textAlignment:NSTextAlignmentCenter];
}


-(void)createLabel:(UILabel *)label text:(NSString *)text TextColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
}
@end









