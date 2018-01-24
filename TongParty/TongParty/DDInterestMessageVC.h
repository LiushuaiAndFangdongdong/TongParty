//
//  DDInterestMessageVC.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import "DDMessageModel.h"
@interface DDInterestMessageVC : DDBaseTableViewController
@property (nonatomic, copy) void(^members)(NSString *count);
@property (nonatomic, strong)DDMessageModel *messageModel;
@end


