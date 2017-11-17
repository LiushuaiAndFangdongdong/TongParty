//
//  FXDAnimationField.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "FXDAnimationField.h"

#define KLabelX 5
#define KLabelH 20

#define kIconHeight  DDFitHeight(24)
#define kIconWidth  kIconHeight*0.9
#define angle2radian(angle) ((angle) / 180.0 * M_PI)

@interface FXDAnimationField()
@property (assign,nonatomic) BOOL isNull;
@property (assign,nonatomic) CGFloat labelHeight;
@property (assign,nonatomic) CGFloat textFiledHeight;
@property (strong,nonatomic) UILabel *placeLabel;
@property (strong, nonatomic)UILabel *bottoomLabel;
@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UIButton *eyeBtn;
@property (nonatomic, strong) UILabel *horizonLine;
@property (nonatomic, strong) UIButton *sendCodeBtn;
@end

@implementation FXDAnimationField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.isNull = YES;//默认为空
        //默认动画
        self.animationType = FXDAnimationTypeUp;
        self.textFiledHeight = self.frame.size.height - self.labelHeight;

        self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(KLabelX, (self.textFiledHeight - kIconWidth)/2, kIconWidth, kIconHeight)];
        [self addSubview:self.leftView];
        
        //添加占位符
        CGRect rectPlacer = CGRectMake(KLabelX + kIconWidth +KLabelX ,self.labelHeight ,self.frame.size.width ,self.textFiledHeight);
        self.placeLabel = [[UILabel alloc]initWithFrame:rectPlacer];
        self.placeholderColor = [UIColor greenColor];
                self.placeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.placeLabel];
    
        //添加底部线
        self.bottoomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        self.bottoomLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:self.bottoomLabel];
    }
    return self;
}

#pragma mark -监测textField的输入
- (void)valueChange:(UITextField*)textField
{
    switch (self.animationType)
    {
        case FXDAnimationTypeBound: [self animationBound]; break;
        case FXDAnimationTypeShake: [self animationShake]; break;
        case FXDAnimationTypeUp:    [self animationUp];    break;
    }
    self.bottoomLabel.backgroundColor = kBgGreenColor;
    //取出当前输入的文字
    _textInput = textField.text;
}

#pragma mark -监听textField的结束

- (void)valueEnd:(UITextField *)textField {
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX + kIconWidth + KLabelX;
    if (textField.text.length == 0) {
        self.isNull = YES;
        self.bottoomLabel.backgroundColor = [UIColor grayColor];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placeLabel.frame = labelRect;
            self.placeLabel.font = [UIFont systemFontOfSize:13];
        } completion:nil];
    }
    
}
-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    self.textFiled.keyboardType = keyboardType;
}
#pragma mark - 占位符颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    _placeLabel.textColor = _placeholderColor;
}
-(void)setLeftImage:(NSString *)leftImage{
    _leftImage = leftImage;
    self.leftView.image = [UIImage imageNamed:leftImage];
}
#pragma mark - 对齐方式
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    _placeLabel.textAlignment = _textAlignment;
    _textFiled.textAlignment = _textAlignment;
}
#pragma mark - 占位符
-(void)setPlaceStr:(NSString *)placeStr
{
    _placeStr = placeStr;
    _placeLabel.text = _placeStr;
}
#pragma mark - 字体
-(void)setPlacerholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    _placeLabel.font = _placeholderFont;
    _textFiled.font = _placeholderFont;
}
#pragma mark - 输入框文字颜色
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textFiled.textColor = _textColor;
}
#pragma mark - 动画效果
-(void)setAnimationType:(FXAnimationType)animationType
{
    _animationType = animationType;
}
#pragma mark - textField类型
- (void)setTextFeildType:(FXDTextFeildType )textFeildType
{
    switch (textFeildType) {
        case FXDTextFeildTypeNormal:
            {
                //添加输入框
                CGRect rect_tf = CGRectMake(KLabelX +kIconWidth +KLabelX ,self.labelHeight ,self.frame.size.width -KLabelX -kIconWidth - KLabelX ,self.textFiledHeight );
                self.textFiled = [[UITextField alloc]initWithFrame:rect_tf];
            }
            break;
        case FXDTextFeildTypeSecurtyPsd:
        {
            _textFiled.secureTextEntry = NO;
            self.eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bottoomLabel.size.width - kIconWidth, (self.textFiledHeight - kIconWidth)/2, kIconWidth, kIconWidth*0.8)];
            [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"login_psd_show"] forState:UIControlStateNormal];
            [self addSubview:self.eyeBtn];
            [self.eyeBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect rect_tf = CGRectMake(KLabelX +kIconWidth +KLabelX ,self.labelHeight ,self.bottoomLabel.width - 2*kIconWidth - 2*KLabelX ,self.textFiledHeight );
            self.textFiled = [[UITextField alloc]initWithFrame:rect_tf];
        }break;
        case FXDTextFeildTypeSendCode:
        {
            self.sendCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - DDFitHeight(80), 0, DDFitHeight(80), self.textFiledHeight)];
            [self addSubview:self.sendCodeBtn];
            [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [self.sendCodeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            self.sendCodeBtn.titleLabel.font = kFont(DDFitHeight(13));
            [self.sendCodeBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
            
            self.horizonLine = [[UILabel alloc] initWithFrame:CGRectMake(self.width - self.sendCodeBtn.width -1, DDFitHeight(10), 1, self.textFiledHeight - DDFitHeight(10)*2)];
            [self addSubview:self.horizonLine];
            self.horizonLine.backgroundColor = kGrayColor;
            
            CGRect rect_tf = CGRectMake(KLabelX +kIconWidth +KLabelX ,self.labelHeight ,self.bottoomLabel.width - self.leftView.width -self.sendCodeBtn.width - 2*KLabelX - 1 ,self.textFiledHeight );
            self.textFiled = [[UITextField alloc]initWithFrame:rect_tf];
        }break;
        default:
            break;
    }
    self.textFiled.clearButtonMode  = UITextFieldViewModeWhileEditing;
    self.textFiled.backgroundColor = [UIColor clearColor];
    [self.textFiled addTarget:self
                       action:@selector(valueChange:)
             forControlEvents:UIControlEventEditingDidBegin];
    [self.textFiled addTarget:self
                       action:@selector(valueEnd:)
             forControlEvents:UIControlEventEditingDidEnd];
    //self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textFiled];
    _textFeildType = textFeildType;
}
- (void)showPasswordAction:(UIButton *)sender{
    sender.tag = !sender.tag;
    if (sender.tag) {
        [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"login_psd_notshow"] forState:UIControlStateNormal];
        _textFiled.secureTextEntry = YES;
    }else{
        [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"login_psd_show"] forState:UIControlStateNormal];
        _textFiled.secureTextEntry = NO;
    }
}
#pragma mark -向上的动画
-(void)animationUp
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX + 24 +KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placeLabel.frame = labelRect;
            self.placeLabel.font = [UIFont systemFontOfSize:11];
            //self.placeLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
    }
}
#pragma mark -抖动的动画
-(void)animationShake
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX+ kIconWidth +KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placeLabel.frame = labelRect;
            CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
            rotation.keyPath = @"transform.rotation";
            rotation.values = @[@(angle2radian(-5)),@(angle2radian(5)),@(angle2radian(-5))];
            
            [self.placeLabel.layer addAnimation:rotation forKey:nil];
        }];
    }
}

#pragma mark -弹簧的动画
-(void)animationBound
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX+ kIconWidth +KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placeLabel.frame = labelRect;
        } completion:nil];
    }
}
- (void)disabledStatus
{
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCodeBtn.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *newTitle = [NSString stringWithFormat:@"%d秒后获取", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCodeBtn.enabled = NO;
                [self.sendCodeBtn setTitle:newTitle forState:UIControlStateDisabled];
                [self.sendCodeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 发送验证码
-(void)sendVerifyCode{
    if (_sendverifyCodeBlcok) {
        _sendverifyCodeBlcok(self.textFiled.text);
    }
}
@end








