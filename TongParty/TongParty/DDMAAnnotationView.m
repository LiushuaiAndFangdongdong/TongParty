//
//  DDMAAnnotationView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMAAnnotationView.h"
#import "DDLoopProgressView.h"
#import "UIView+Layer.h"

@implementation DDMAAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //大头针的图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.alpha = 0.5f;
        imageView.layerCornerRadius = 35;
        [self addSubview:imageView];
        DDLoopProgressView *custom = [[DDLoopProgressView alloc]init];
        custom.size = CGSizeMake(72.5, 72.5);
        custom.center = imageView.center;
        custom.progress = 1;
        [self addSubview:custom];
        
    }
    
    return self;
}
@end
