//
//  LSContentSortModel.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSContentSortModel : NSObject
@property(nonatomic, strong)NSArray   *label_array;
@property(nonatomic, assign)BOOL      isShowMore;
- (instancetype)initWithArray:(NSArray *)array;
@end
