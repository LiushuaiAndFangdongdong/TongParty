//
//  DDTag.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDTag : NSObject
@property (copy, nonatomic, nullable) NSString *text;
@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (strong, nonatomic, nullable) UIColor *textColor;
@property(nonatomic,strong,nullable)UIColor *slcTextColor;
///backgound color
@property (strong, nonatomic, nullable) UIColor *bgColor;
@property(nonatomic,strong,nullable) UIColor *slcColor;
@property(nonatomic,strong,nullable)UIColor *nrmColor;
@property (strong, nonatomic, nullable) UIColor *highlightedBgColor;
///background image
@property (strong, nonatomic, nullable) UIImage *bgImg;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;
///like padding in css
@property (assign, nonatomic) UIEdgeInsets padding;
@property (strong, nonatomic, nullable) UIFont *font;
///if no font is specified, system font with fontSize is used
@property (assign, nonatomic) CGFloat fontSize;
///default:YES
@property (assign, nonatomic) BOOL enable;

- (nonnull instancetype)initWithText: (nonnull NSString *)text;
+ (nonnull instancetype)tagWithText: (nonnull NSString *)text;
@end
