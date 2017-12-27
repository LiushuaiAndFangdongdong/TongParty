//
//  DDNumbersTextView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDUserInfoModel.h"

typedef NS_ENUM(NSUInteger, DDNumbersTextViewType) {
    /** 常规*/
    DDNumbersTextViewTypeNormal,
    /** 查看别人的个人主页时，后面有关注和邀请按钮*/
    DDNumbersTextViewTypeOthers
};

@interface DDNumbersTextView : UIView
@property (nonatomic, copy) void(^variousNumbersClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^careBtnClickBlcok)(BOOL isCare);
@property (nonatomic, assign) DDNumbersTextViewType type;
- (void)updateWithModel:(id)model withType:(DDNumbersTextViewType)style;
@end


@interface  DDNumbersTextItemView : UIView
@property (nonatomic, copy) NSString *itemNumbers;
@property (nonatomic, copy) NSString *itemName;
@end

