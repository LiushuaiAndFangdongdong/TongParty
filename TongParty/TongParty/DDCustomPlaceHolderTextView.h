//
//  DDCustomPlaceHolderTextView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  有placeHolder的UITextView

#import <UIKit/UIKit.h>


@class DDCustomPlaceHolderTextView;
@protocol DDCustomPlaceHolderTextViewDelegate <NSObject>
/** 文本改变回调*/
- (void)customPlaceHolderTextViewTextDidChange:(DDCustomPlaceHolderTextView *)textView;
@end




@interface DDCustomPlaceHolderTextView : UITextView
@property (nonatomic, weak) id <DDCustomPlaceHolderTextViewDelegate> del;
@property (nonatomic, copy)   NSString *placehoder;
@property (nonatomic, strong) UIColor *placehoderColor;
@property (nonatomic, assign) CGFloat placeholderTopMargin;
@property (nonatomic, assign) CGFloat placeholderLeftMargin;
@property (nonatomic, strong) UIFont *placeholderFont;
@end







