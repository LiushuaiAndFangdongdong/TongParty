//
//  LSQRScanView.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSQRScanView.h"
#import <Masonry/Masonry.h>

@interface LSQRScanView ()
@property(nonatomic,strong)UIImageView *lineImageView;
@end
@implementation LSQRScanView{
    CGFloat _leftEdge;
    CGSize _scanWindow;
    CGFloat _minX,_maxX,_minY,_maxY,_viewWidth,_viewHeigth;
    CGContextRef _context;
    NSTimer *_animationTimer;
}

- (instancetype)initWithFrame:(CGRect)frame leftEdge:(CGFloat)edge{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _leftEdge = edge;
        [self addlineImageView];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    _scanWindow = CGSizeMake(CGRectGetWidth(self.bounds) - _leftEdge * 2, CGRectGetWidth(self.bounds) - _leftEdge *2);
    _viewWidth = CGRectGetWidth(self.bounds);
    _viewHeigth = CGRectGetHeight(self.bounds);
    _minX = _leftEdge;
    _maxX = _leftEdge + _scanWindow.width;
    _minY = 80;
    _maxY = 80 + _scanWindow.height;
    _context = UIGraphicsGetCurrentContext();
    //绘制遮罩
    [self drawMask];
    //矩形框
    [self drawScanRect];
    
}

- (void)drawMask{
    CGContextSetRGBFillColor(_context,0,0,0,0.5f);
    CGRect makeRect = CGRectMake(0, 0, _viewWidth, 80  + DDFitHeight(80.f));
    CGContextFillRect(_context, makeRect);
    
    makeRect = CGRectMake(0, _minY + DDFitHeight(80.f), _leftEdge, _scanWindow.height);
    CGContextFillRect(_context, makeRect);
    
    makeRect = CGRectMake(_maxX, _minY + DDFitHeight(80.f), _leftEdge, _scanWindow.height);
    CGContextFillRect(_context, makeRect);
    
    makeRect = CGRectMake(0, _maxY + DDFitHeight(80.f), _viewWidth, _viewHeigth - _scanWindow.height - 80);
    CGContextFillRect(_context, makeRect);
    
}
- (void)drawScanRect{
    CGContextSetStrokeColorWithColor(_context, kGreenColor.CGColor);
    CGContextSetLineWidth(_context, 1);
    CGContextAddRect(_context, CGRectMake(_minX, _minY + DDFitHeight(80.f), _scanWindow.width, _scanWindow.width));
    CGContextStrokePath(_context);
    
    CGFloat lineWidth = DDFitWidth(45.f);
    CGFloat lineHeight = DDFitWidth(45.f);
    CGFloat line_minX = _minX + 5/2;
    CGFloat line_maxX = _maxX - 5/2;
    CGFloat line_minY = _minY + 5/2 + DDFitHeight(80.f);
    CGFloat line_maxY = _maxY - 5/2 + DDFitHeight(80.f);
    
    CGContextSetStrokeColorWithColor(_context, kGreenColor.CGColor);
    CGContextSetLineWidth(_context, 5);
    
    CGContextMoveToPoint(_context, line_minX, line_minY);
    CGContextAddLineToPoint(_context, line_minX + lineWidth, line_minY);
    
    CGContextMoveToPoint(_context, line_minX, line_minY - 5/2);
    CGContextAddLineToPoint(_context, line_minX, line_minY + lineHeight + 5/2);
    
    CGContextMoveToPoint(_context, line_minX, line_maxY);
    CGContextAddLineToPoint(_context, line_minX + lineWidth, line_maxY);
    
    CGContextMoveToPoint(_context, line_minX, line_maxY + 5/2);
    CGContextAddLineToPoint(_context, line_minX, line_maxY - lineHeight - 5/2);
    
    CGContextMoveToPoint(_context, line_maxX, line_maxY);
    CGContextAddLineToPoint(_context, line_maxX - lineWidth, line_maxY);
    
    CGContextMoveToPoint(_context, line_maxX, line_maxY + 5/2);
    CGContextAddLineToPoint(_context, line_maxX, line_maxY - lineHeight - 5/2);
    
    CGContextMoveToPoint(_context, line_maxX, line_minY);
    CGContextAddLineToPoint(_context, line_maxX - lineWidth, line_minY);
    
    CGContextMoveToPoint(_context, line_maxX, line_minY - 5/2);
    CGContextAddLineToPoint(_context, line_maxX, line_minY + lineHeight + 5/2);
    
    CGContextStrokePath(_context);
}
- (void)addlineImageView{
    _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    [self addSubview:_lineImageView];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(80  + DDFitHeight(80.f));
        make.left.equalTo(self.mas_left).with.offset(_leftEdge);
        make.right.equalTo(self.mas_right).with.offset(-_leftEdge);
    }];
    
    UIView *barView = [UIView new];
    barView.backgroundColor = [UIColor clearColor];
    [self addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *reminderLabel = [UILabel new];
    reminderLabel.text = @"扫描桌主的二维码名片，即可完成签到";
    reminderLabel.textAlignment = NSTextAlignmentCenter;
    reminderLabel.textColor = [UIColor whiteColor];
    reminderLabel.font = DDFitFont(15.f);
    [self addSubview:reminderLabel];
    [reminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo( DDFitHeight(500.f));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(DDFitWidth(300.f), DDFitHeight(25.f)));
    }];
}
- (void)lineStartAnimation{
    if (!_animationTimer) {
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    }
}
- (void)animation{
    [_lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(80  + DDFitHeight(80.f) + _scanWindow.height - 10);
        make.left.equalTo(self.mas_left).with.offset(_leftEdge);
        make.right.equalTo(self.mas_right).with.offset(-_leftEdge);
    }];
    [UIView animateWithDuration:1 animations:^{
        _lineImageView.hidden = NO;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).with.offset(80  + DDFitHeight(80.f));
            make.left.equalTo(self.mas_left).with.offset(_leftEdge);
            make.right.equalTo(self.mas_right).with.offset(-_leftEdge);
        }];
        _lineImageView.hidden = YES;
    }];
}
- (void)lineStopAnimation{
    
    _lineImageView.hidden = YES;
    [_animationTimer invalidate];
    _animationTimer = nil;
}
- (void)openPhotoLibraryClick{
    
    if (self.openPhotoLibrary) {
        self.openPhotoLibrary();
    }
}
- (void)openFlashClick{
    
    if (self.openFlash){
        self.openFlash();
    }
}
@end
