//
//  DDHomeListTableCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

@class NHDiscoverCategoryElement;

@interface DDHomeListTableCell : DDBaseTableViewCell
/** 设置数据*/
@property (nonatomic, strong) NHDiscoverCategoryElement *elementModel;

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel keyWord:(NSString *)keyWord;

@end
