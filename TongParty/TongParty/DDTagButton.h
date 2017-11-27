//
//  DDTagButton.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DDTag;
@interface DDTagButton : UIButton
+ (nonnull instancetype)buttonWithTag: (nonnull DDTag *)tag;
@end
