
//
//  DDStatusAvatar.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/3.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDStatusAvatar.h"

@interface DDStatusAvatar()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *statusView;
@end

@implementation DDStatusAvatar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _avatarView.layerCornerRadius =  40;
    
    _statusView = [UIImageView new];
    [self addSubview:_statusView];
    [_statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80*0.36);
    }];
    _statusView.image = kImage(@"desklist_status_host");
}
- (void)setAvatarstring:(NSString *)avatarstring{
//    _avatarView.image = kImage(avatarstring);
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatarstring] placeholderImage:kImage(@"avatar_default")];
}
-(void)setStatusstring:(NSString *)statusstring{
    _statusView.image = kImage(statusstring);
}
@end







