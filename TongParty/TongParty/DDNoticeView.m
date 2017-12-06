//
//  DDNoticeView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNoticeView.h"
#import <dispatch/dispatch.h>
#import "NSString+DDAdd.h"
#import "DDScrollLabelView.h"
#import "UIView+Layer.h"

@interface DDNoticeView()<DDScrollLabelViewDelegate>

@property (nonatomic, strong) UIImageView *hornView;  //喇叭
@property (nonatomic, copy) NSString *notice;
@end
//喇叭宽高比：26/21

@implementation DDNoticeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{

    self.backgroundColor = kBgGrayColor;
    self.layerCornerRadius = 15;
    self.hornView = [[UIImageView alloc] init];
    [self addSubview:self.hornView];
    [self.hornView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(15*21/26);
        make.width.mas_equalTo(15);
//        make.height.and.with.mas_equalTo(15);
    }];
    self.hornView.image = kImage(@"notice_horn");
 
    DDScrollLabelView *drawMarqueeView = [[DDScrollLabelView alloc] init];
    [self addSubview:drawMarqueeView];
    [drawMarqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hornView.mas_right).offset(8);
        make.right.mas_equalTo(-2);
        make.top.and.bottom.mas_equalTo(self);
    }];
    drawMarqueeView.delegate          = self;
    drawMarqueeView.marqueeDirection  = FromLeftType;
    [drawMarqueeView addContentView:[self createLabelWithText:_notice
                                                     textColor:kWhiteColor]];
    [drawMarqueeView startAnimation];
}
-(void)setNoticeString:(NSString *)noticeString{
    if (noticeString == NULL || noticeString == nil) {
       self.notice = @"欢迎来到桐聚！志不同，不桐聚，祝大家玩的开心！";
    }else{
       self.notice = noticeString;
    }
}
#pragma mark -
- (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor {
    
    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat width = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, width, 30);
    label.font       = kFont(13);
    label.text       = string;
    label.textColor  = textColor;
//    dispatch_queue_t backgroundQueue;
//    backgroundQueue = dispatch_queue_create("label", NULL);
//    dispatch_async(backgroundQueue, ^{
//        CGFloat width = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}];
//        dispatch_async(dispatch_get_main_queue(), ^(void) {
//            label.frame = CGRectMake(0, 0, width, 30);
//        });
//    });
//    NSLog(@"%f",label.frame.size.width);
    return label;
}
#pragma mark -
- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}
#pragma mark -
- (CGFloat)randomValue {
    
    return arc4random() % 256 / 255.f;
}
#pragma mark -
- (void)drawMarqueeView:(DDScrollLabelView *)drawMarqueeView animationDidStopFinished:(BOOL)finished
{
    [drawMarqueeView stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [drawMarqueeView addContentView:[self createLabelWithText:[self randomString]
//                                                        textColor:[self randomColor]]];
        [drawMarqueeView addContentView:[self createLabelWithText:_notice
                                                        textColor:kWhiteColor]];
        [drawMarqueeView startAnimation];
    });
}
#pragma mark -
- (NSString *)randomString {
    
    NSArray *array = @[@"方习冬",
                       @"桐聚",
                       @"ios下载",
                       @"欢度元旦",
                       @"欢度新春",
                       @"志不同，不桐聚。"];
    return array[arc4random() % array.count];
}

@end















