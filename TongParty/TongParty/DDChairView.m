
//
//  DDChairView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDChairView.h"
#import "UIView+Layer.h"
#import "UIView+Frame.h"

@interface DDChairView()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *avatarView;
@end

//皇冠宽高之比：87/62
@implementation DDChairView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

-(void)setType:(DDChairType)type{
    switch (type) {
        case DDChairTypeHolder:
        {
            self.avatarView = [[UIImageView alloc] init];
            [self addSubview:self.avatarView];
            self.bgView = [[UIImageView alloc] init];
            [self addSubview:self.bgView];
            [self layoutIfNeeded];
            
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(-4);
                make.right.mas_equalTo(-13);
                make.height.mas_equalTo(self.width*62/87);
            }];
            self.bgView.image = kImage(@"desk_holder_chair");
            [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.bottom.and.right.mas_equalTo(0);
                make.height.mas_equalTo(self.width);
            }];
            self.avatarView.layerCornerRadius = self.width/2;
        }
            break;
        case DDChairTypeLeft:
        {
            self.bgView = [[UIImageView alloc] init];
            [self addSubview:self.bgView];
            self.avatarView = [[UIImageView alloc] init];
            [self.bgView addSubview:self.avatarView];
            [self layoutIfNeeded];
            
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            self.bgView.image = kImage([self leftrandomString]);
            [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(3);
                make.left.mas_equalTo(4);
                make.bottom.mas_equalTo(-3);
                make.right.mas_equalTo(-2);
            }];
            self.avatarView.layerCornerRadius = (self.width-6)/2;
            self.avatarView.backgroundColor = kLightGrayColor;
        }break;
        case DDChairTypeRight:
        {
            self.bgView = [[UIImageView alloc] init];
            [self addSubview:self.bgView];
            self.avatarView = [[UIImageView alloc] init];
            [self.bgView addSubview:self.avatarView];
            [self layoutIfNeeded];
            
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            self.bgView.image = kImage([self rightrandomString]);
            [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(3);
                make.left.mas_equalTo(2);
                make.bottom.mas_equalTo(-3);
                make.right.mas_equalTo(-4);
            }];
            self.avatarView.layerCornerRadius = (self.width-6)/2;
            self.avatarView.backgroundColor = kLightGrayColor;
        }break;
        case DDChairTypeBottom:
        {
            self.bgView = [[UIImageView alloc] init];
            [self addSubview:self.bgView];
            self.avatarView = [[UIImageView alloc] init];
            [self.bgView addSubview:self.avatarView];
             [self layoutIfNeeded];
            
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            self.bgView.image = kImage(@"desk_chair_bottom");
            
            [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(3);
                make.left.mas_equalTo(3);
                make.bottom.mas_equalTo(-3);
                make.right.mas_equalTo(-3);
            }];
            self.avatarView.layerCornerRadius = (self.width-6)/2;
            self.avatarView.backgroundColor = kRedColor;
        }break;
        default:
            break;
    }
}
#pragma mark -
- (NSString *)leftrandomString {
    
    NSArray *array = @[@"0",
                       @"1",
                       @"2"];
    NSString *randomstr = [NSString stringWithFormat:@"desk_chair_left%@",array[arc4random() % array.count]];
    return randomstr;
}
- (NSString *)rightrandomString {
    
    NSArray *array = @[@"0",
                       @"1",
                       @"2"];
    NSString *randomstr = [NSString stringWithFormat:@"desk_chair_right%@",array[arc4random() % array.count]];
    return randomstr;
}

-(void)updateAvatarWithImage:(NSString *)imagestr{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:kDefaultAvatar];
}

@end













