//
//  PhotoCell.m
//  WXMovie
//
//  Created by wei.chen on 15/8/10.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"


@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //1.创建滑动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //设置缩放的最大、最小倍数
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        
        //隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
        
        
        //2.创建图片视图
        _imgView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgView];
        
        
        //3.创建点击手势对象，缩放图片视图
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        //设置这个手势点击的数量
        tap2.numberOfTapsRequired = 2;
        [_scrollView addGestureRecognizer:tap2];


        //4.创建单击手势,用于隐藏导航栏
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        tap1.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:tap1];
        
        //5.解决双击、单击手势的冲突
        //如果双击手势产生了，取消单击手势的响应
        //当tap2手势触发之后，取消tap1手势的响应
        [tap1 requireGestureRecognizerToFail:tap2];

        UILongPressGestureRecognizer *longbaocun = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(baocunimg:)];
        longbaocun.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:longbaocun];
    
    }
    
    return self;
}


- (void)baocunimg:(UILongPressGestureRecognizer *)longPress{
    
    if (_bjTB==nil) {
        
        _bjTB= [[BJtableView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _bjTB.delegate = self;
        [self addSubview:_bjTB];
        _bjTB.dataAry = @[@"保存图片"];
    }
    
    _bjTB.hidden = NO;
}



- (void)section:(int)section row:(int )alert{
    
    _bjTB.hidden = YES;
    [_bjTB removeFromSuperview];
    _bjTB=nil;
    
    
    if (section==0) {
        if (alert==0) {
         [self saveImageToPhotos:_imgView.image];
        }
    }
}



- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法



- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
//        [MBProgressHUD showError:msg toView:[UIApplication sharedApplication].keyWindow];
        
    }else{
        
        msg = @"保存图片成功" ;
//        [MBProgressHUD showSuccess:msg toView:[UIApplication sharedApplication].keyWindow];
        
    }
    
}




- (void)setUrlstring:(NSString *)urlstring {
    _urlstring = urlstring;
    
    if([_urlstring rangeOfString:@"http"].location !=NSNotFound) { //网络图片
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_urlstring] placeholderImage:[UIImage imageNamed:@"图片加载默认图-1"]];;//有中文须先转码
    }else{
        
        _imgView.image = [UIImage imageNamed:_urlstring];
    }
    
    
}


    
    
- (void)layoutSubviews{
    
    [super layoutSubviews];
}



//双击手势响应方法
- (void)tap2 {
    
//    _scrollView.zoomScale   //_scrollView 对子视图放大的倍数
    if (_scrollView.zoomScale > 1) {  //大于1，说明已经被放大了
        
        //缩小
        [_scrollView setZoomScale:1 animated:YES];
        
    } else {
        //放大
        [_scrollView setZoomScale:3 animated:YES];

    }
    
}

- (void)tap1 {
    
//    NSLog(@"单击");
    
    //完成隐藏导航栏的功能
    //self.superview.superview; ---> self.view  ---> 控制器  ---> 导航控制器
    
    
    //要将图片点击事件 ----> 发送(通知) ---> 控制器
    /**
     解决事件通讯，iOS中提供了三种方案：代理、block、通知
     这三种方案解决了事件通讯，并且通讯的两个对象是解耦合
     */
    
    //[代理 协议方法]
    
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kImgClickNotification object:nil];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgView;
}













@end
