//
//  CustomCardView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "CustomCardView.h"
#import "DDBigDeskView.h"

@interface CustomCardView ()
@property (nonatomic, strong) DDBigDeskView *deskView;
@end

@implementation CustomCardView

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    
    self.backgroundColor = kWhiteColor;
    
    self.deskView = [[DDBigDeskView alloc] init];
    [self addSubview:self.deskView];
    self.deskView.type = DDDeskShowTypeCard;
    
}

- (void)cc_layoutSubviews  {    
    self.deskView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)installData:(DDTableInfoModel *)element{
    [self.deskView updateDeskInfoModel:element];
}

@end









