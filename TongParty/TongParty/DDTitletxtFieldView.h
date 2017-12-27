//
//  DDTitletxtFieldView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCustomPlaceHolderTextView.h"
typedef NS_ENUM(NSUInteger, DDTextFieldStyle) {
    /** 常规*/
    DDTextFieldStyleNormal,
    /** 文字*/
    DDTextFieldStyleText,
    /** 图片*/
    DDTextFieldStyleImage
};


@interface DDTitletxtFieldView : UIView
@property (nonatomic, assign) DDTextFieldStyle style;
@property (nonatomic, copy)  NSString  *titlestring;
@property (nonatomic, copy)  NSString *ploceholderstr;
@property (nonatomic, copy)  NSString *titleImagestr;
@property (nonatomic, strong) DDCustomPlaceHolderTextView  *textView;
@end

