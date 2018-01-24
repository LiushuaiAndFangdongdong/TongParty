//
//  DDPrefectDataView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPrefectDataView : UIScrollView
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, copy)void (^uploadHeaderImage)();
@property (nonatomic, copy)void (^confirmUpInfo)(NSString *sex, NSString *name);
@end
