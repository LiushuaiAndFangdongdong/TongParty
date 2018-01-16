//
//  CustomCardView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "CCDraggableCardView.h"
#import "DDTableInfoModel.h"

@interface CustomCardView : CCDraggableCardView

- (void)installData:(DDTableInfoModel *)element;

@end
