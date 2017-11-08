//
//  DDCustomPlaceHolderTextView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDCustomPlaceHolderTextView.h"

@interface DDCustomPlaceHolderTextView()
@property (nonatomic,weak) UILabel *placehoderLabel;
@end

@implementation DDCustomPlaceHolderTextView

//1.initWithCoder: 对于.xib，当你嵌入一个视图对象到xib，视图加载时默认调用的是该方法；例如：假如创建的view来自nib，那么将会调用initWithCoder，由系统来调用，自己不能调用。
//2.initWithFrame: 非.xib的手动编码，视图加载时默认调用的是该方法。是由自己调用，来初始化对象的

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _config];
    }
    return self;
}

- (void)_config {
    self.font = [UIFont systemFontOfSize:14];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    self.placeholderLeftMargin = 5;
    self.placeholderTopMargin = 8;
}

- (UILabel *)placehoderLabel {
    if (!_placehoderLabel) {
        UILabel *placehoderLabel = [[UILabel alloc]init];
        placehoderLabel.numberOfLines = 0;
        [self addSubview:placehoderLabel];
        _placehoderLabel = placehoderLabel;
        self.placehoderColor = [UIColor lightGrayColor];
    }
    return _placehoderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _config];
    }
    return self;
}

- (void)textDidChange {
    self.placehoderLabel.hidden = self.text.length;
    if ([self.del respondsToSelector:@selector(customPlaceHolderTextViewTextDidChange:)]) {
        [self.del customPlaceHolderTextViewTextDidChange:self];
    }
}

- (void)setText:(NSString *)text{
    [super setText:text];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setPlacehoder:(NSString *)placehoder{
    
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    [self setNeedsLayout];
}

- (void)setPlaceholderLeftMargin:(CGFloat)placeholderLeftMargin {
    _placeholderLeftMargin = placeholderLeftMargin;
    [self setNeedsLayout];
}

- (void)setPlaceholderTopMargin:(CGFloat)placeholderTopMargin {
    _placeholderTopMargin = placeholderTopMargin;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize maxSize = CGSizeMake(self.placehoderLabel.frame.size.width-10, MAXFLOAT);
    CGRect LabelFrame = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.placehoderLabel.font,NSFontAttributeName, nil] context:nil];
    self.placehoderLabel.frame = CGRectMake(self.placeholderLeftMargin + 2, self.placeholderTopMargin, self.frame.size.width - 2 * self.placeholderLeftMargin, LabelFrame.size.height);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}



@end
