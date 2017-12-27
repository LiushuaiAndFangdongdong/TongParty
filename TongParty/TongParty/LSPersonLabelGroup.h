//
//  LSPersonLabelGroup.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSPersonLabelModel.h"
@interface LSPersonLabelGroup : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray<LSPersonLabelModel *> *items;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
