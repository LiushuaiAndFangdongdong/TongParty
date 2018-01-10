//
//  FXDCircleView.m
//  TongParty
//
//  Created by 方冬冬 on 2018/1/4.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "FXDCircleView.h"
#import "DDUserCircleView.h"
#import "DDTableCircleView.h"

#define kTag 100

@interface FXDCircleView()
{
    CGFloat _lastPointAngle;//上一个点相对于x轴角度
    CGPoint _centerPoint;
    CGFloat _deltaAngle;
    CGFloat _radius;
    CGFloat _lastImgViewAngle;
}
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImageView *centerView;//中间转盘
@property (nonatomic, strong) UIImageView *cirView;
@end

@implementation FXDCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
        //        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)customUI {
    
    CGFloat centerX = CGRectGetWidth(self.frame) * 0.5f;
    CGFloat centerY = centerX;
    _centerPoint = CGPointMake(centerX, centerY);//中心点
    
    _cirView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _cirView.center = _centerPoint;
    _cirView.image = [UIImage imageNamed:@"转盘"];
    [self addSubview:_cirView];
    
    _centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _centerView.center =  _centerPoint;
    _centerView.image = [UIImage imageNamed:@"转盘icon"];
    [self addSubview:_centerView];
    
    _deltaAngle = M_PI / 3.0f;//6个imgView的间隔角度
    CGFloat currentAngle = 0;
    CGFloat imgViewCenterX = 0;
    CGFloat imgViewCenterY = 0;
    CGFloat imgViewW = 60;
    CGFloat imgViewH =imgViewW;
    _radius = centerX - imgViewW * 0.5f;//imgView.center到self.center的距离
    for (int i = 0; i < 6; i++) {
        currentAngle = _deltaAngle * i;
        imgViewCenterX = centerX + _radius * sin(currentAngle);
        imgViewCenterY = centerY - _radius * cos(currentAngle);
        DDUserCircleView *imgView = [[DDUserCircleView alloc] initWithFrame:CGRectMake(0, 0, imgViewW, imgViewH)];
        imgView.tag = kTag + i;
        imgView.center = CGPointMake(imgViewCenterX, imgViewCenterY);
        //        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"watermelon%d", i]];
        [_cirView addSubview:imgView];
        //        imgView.transform = CGAffineTransformRotate(_cirView.transform, -currentAngle);
    }
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    // 每隔1帧调用一次
    self.displayLink.frameInterval = 1;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)updateNearUserWithArray:(NSArray<DDNearUserModel *> *)userArr{
    if (userArr.count <= 6) {
        for (int i = 0; i < userArr.count; i++) {
            DDUserCircleView *cView = [_cirView viewWithTag:kTag + i];
            [cView updateCircleUserWithModel:userArr[i]];
        }
    }else{
        
    }
}

-(void)updateNearTableWithArray:(NSArray<DDNearTableModel *> *)tableArr{
    if (tableArr.count <= 6) {
        for (int i = 0; i < tableArr.count; i++) {
            DDTableCircleView *cView = [_cirView viewWithTag:kTag + i];
            [cView updateCircleTableWithModel:tableArr[i]];
        }
    }else{
        
    }
}

-(void)handleDisplayLink:(CADisplayLink *)timer{
    
    CGFloat angle = timer.duration * (M_PI_4/2);
    _cirView.transform = CGAffineTransformRotate(_cirView.transform, angle);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_cirView];
    //计算上一个点相对于x轴的角度
    CGFloat lastPointRadius = sqrt(pow(point.y - _centerPoint.y, 2) + pow(point.x - _centerPoint.x, 2));
    if (lastPointRadius == 0) {
        return;
    }
    _lastPointAngle = acos((point.x - _centerPoint.x) / lastPointRadius);
    if (point.y > _centerPoint.y) {
        _lastPointAngle = 2 * M_PI - _lastPointAngle;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_cirView];
    
    //1.计算当前点相对于x轴的角度
    CGFloat currentPointRadius = sqrt(pow(currentPoint.y - _centerPoint.y, 2) + pow(currentPoint.x - _centerPoint.x, 2));
    if (currentPointRadius == 0) {//当点在中心点时，被除数不能为0
        return;
    }
    CGFloat curentPointAngle = acos((currentPoint.x - _centerPoint.x) / currentPointRadius);
    if (currentPoint.y > _centerPoint.y) {
        curentPointAngle = 2 * M_PI - curentPointAngle;
    }
    //2.变化的角度
    CGFloat angle = _lastPointAngle - curentPointAngle;
    
    //手动旋转中间和背景也随着转动
    _centerView.transform = CGAffineTransformRotate(_centerView.transform, angle);
    _cirView.transform = CGAffineTransformRotate(_cirView.transform, angle);
    
    //手动六个view转动
    _lastImgViewAngle = fmod(_lastImgViewAngle + angle, 2 * M_PI);//对当前角度取模
    CGFloat currentAngle = 0;
    CGFloat imgViewCenterX = 0;
    CGFloat imgViewCenterY = 0;
    for (int i = 0; i < 6; i++) {
        UIImageView *imgView = [_cirView viewWithTag:kTag];
        currentAngle = _deltaAngle * i + _lastImgViewAngle;
        imgViewCenterX = _centerPoint.x + _radius * sin(currentAngle);
        imgViewCenterY = _centerPoint.x - _radius * cos(currentAngle);
        imgView = [_cirView viewWithTag:kTag + i];
        imgView.center = CGPointMake(imgViewCenterX, imgViewCenterY);
    }
    
    _lastPointAngle = curentPointAngle;
}

@end





