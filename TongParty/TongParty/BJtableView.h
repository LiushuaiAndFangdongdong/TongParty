//
//  BJtableView.h
//  DangAn
//
//  Created by 未来社区 on 16/6/14.
//  Copyright © 2016年 lijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BJtableView;
@protocol BJtableViewDelegate<NSObject>

- (void)section:(int)section row:(int )alert;

@end

@interface BJtableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataAry;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)id<BJtableViewDelegate> delegate;


@end
