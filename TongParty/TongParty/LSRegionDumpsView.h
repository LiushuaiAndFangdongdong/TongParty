//
//  LSRegionDumpsView.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSRegionDumpsView : UIView
@property (nonatomic, copy) void(^onSelected)(NSString *addString);
@end
