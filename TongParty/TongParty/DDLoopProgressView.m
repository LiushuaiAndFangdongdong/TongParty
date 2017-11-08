//
//  DDLoopProgressView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoopProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define ViewWidth self.frame.size.width   //环形进度条的视图宽度
#define ProgressWidth 2.5                 //环形进度条的圆环宽度
#define Radius ViewWidth/2-ProgressWidth  //环形进度条的半径


@interface DDLoopProgressView()<CAAnimationDelegate> {
    
    CAShapeLayer *arcLayer;
    UILabel *label;
    NSTimer *progressTimer;
}

@property (nonatomic,assign)CGFloat i;

@end

@implementation DDLoopProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


-(void)drawRect:(CGRect)rect {
    
    _i=0;
    CGContextRef progressContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(progressContext, ProgressWidth);
    CGContextSetRGBStrokeColor(progressContext, 209.0/255.0, 209.0/255.0, 209.0/255.0, 1);
    
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    //绘制环形进度条底框
    CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0, 2*M_PI, 0);
    CGContextDrawPath(progressContext, kCGPathStroke);
    
    //绘制环形进度环
    CGFloat to = self.progress * M_PI * 2; // - M_PI * 0.5为改变初始位置
    
    // 进度数字字号,可自己根据自己需要，从视图大小去适配字体字号
    int fontNum = ViewWidth/6;
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,Radius+10, ViewWidth/6)];
    label.center = CGPointMake(xCenter, yCenter);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:fontNum];
    label.text = @"0%";
    [self addSubview:label];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(xCenter,yCenter) radius:Radius startAngle:0 endAngle:to clockwise:YES];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor=[UIColor colorWithRed:227.0/255.0 green:91.0/255.0 blue:90.0/255.0 alpha:0.7].CGColor;
    arcLayer.lineWidth=ProgressWidth;
    arcLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:arcLayer];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // [self drawLineAnimation:arcLayer];
    });
    
    if (self.progress > 1) {
        NSLog(@"传入数值范围为 0-1");
        self.progress = 1;
    }else if (self.progress < 0){
        NSLog(@"传入数值范围为 0-1");
        self.progress = 0;
        return;
    }
    
    if (self.progress > 0) {
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(newThread) object:nil];
        [thread start];
    }
    
}

-(void)newThread {
    
    @autoreleasepool {
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];
    }
}

//NSTimer不会精准调用
-(void)timeLabel
{
    _i += 0.01;
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
          label.text = [NSString stringWithFormat:@"%.0f%%",_i*100];
    });
  
    if (_i >= self.progress) {
        [progressTimer invalidate];
        progressTimer = nil;
        
        NSLog(@"progressTimer传入数值范围为 0-1");
    }
    
}

// //定义动画过程
// -(void)drawLineAnimation:(CALayer*)layer
// {
//    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    bas.duration=self.progress;//动画时间
//    bas.delegate=self;
//    bas.fromValue=[NSNumber numberWithInteger:0];
//    bas.toValue=[NSNumber numberWithInteger:1];
//    [layer addAnimation:bas forKey:@"key"];
// }

@end
