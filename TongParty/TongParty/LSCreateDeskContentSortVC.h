//
//  LSCreateDeskContentSortVC.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"
#import "LSActivityEntity.h"

@interface LSCreateDeskContentSortVC : DDBaseViewController
@property (nonatomic, copy) void(^selectActivity)(LSActivityEntity *entity);
@end
