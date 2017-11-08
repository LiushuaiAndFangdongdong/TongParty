//
//  FXDAnimationField.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FXAnimationType){
    FXDAnimationTypeUp,
    FXDAnimationTypeShake,
    FXDAnimationTypeBound
};

typedef NS_ENUM(NSInteger, FXDTextFeildType){
    FXDTextFeildTypeNormal,      //常规
    FXDTextFeildTypeSecurtyPsd,  //后面有个眼睛，明文密文
    FXDTextFeildTypeSendCode     //发送验证码
};

@interface FXDAnimationField : UIView
/**
 *  输入框文字颜色
 */
@property (strong,nonatomic) UIColor *textColor;
/**
 *  占位符
 */
@property (strong,nonatomic) NSString *placeStr;
/**
 *  左边图标
 */
@property (nonatomic, copy) NSString *leftImage;
/**
 *  占位符颜色
 */
@property (strong,nonatomic) UIColor *placeholderColor;
/**
 *  占位符字体，和textField字体大小相同
 */
@property (strong,nonatomic) UIFont *placeholderFont;
/**
 *  文字对齐方式
 */
@property (assign,nonatomic) NSTextAlignment textAlignment;
/**
 *  输入的文字类容
 */
@property (copy,nonatomic,readonly)NSString *textInput;
/**
 *  动画类型
 */
@property (assign,nonatomic) FXAnimationType animationType;
/**
 *  TextFeild类型
 */
@property (nonatomic, assign) FXDTextFeildType  textFeildType;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (strong,nonatomic) UITextField *textFiled;

@property (nonatomic, copy) void(^sendverifyCodeBlcok)(NSString *verifyCode);
- (void)disabledStatus;
@end





