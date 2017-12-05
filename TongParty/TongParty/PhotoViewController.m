//
//  PhotoViewController.m
//  WXMovie
//
//  Created by wei.chen on 15/8/10.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionView.h"
#import "PhotoCell.h"


@interface PhotoViewController ()

@end

@implementation PhotoViewController{

    UILabel *_titleLable;

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImgClickNotification object:nil];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellImgClick) name:kImgClickNotification object:nil];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor blackColor];
    
    //automaticallyAdjustsScrollViewInsets  是否让控制设置第一个子视图的scrollView自动向下偏移64
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self _initViews];
    
   
}


- (void)_initViews{
    
    //2.创建列表视图
    //之前：在当前控制器中创建UICollectionView,并且在当前这个类实现协议方法
    PhotoCollectionView *photoCollectionView = [[PhotoCollectionView alloc] initWithFrame:self.view.bounds];
    photoCollectionView.urls = _urls;
    [self.view addSubview:photoCollectionView];
    

    
    //3.滚动到指定的单元格
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [photoCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    
    _titleLable = [[UILabel alloc] initWithFrame: CGRectMake(0, 20,  [[UIScreen mainScreen] bounds].size.width, 44)];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.textColor= [UIColor whiteColor];
    _titleLable.font = [UIFont systemFontOfSize:17];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = [NSString stringWithFormat:@"%ld of %ld",_index+1,_urls.count];
    [self.view addSubview:_titleLable];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleNot:) name:@"page" object:nil];
    
    
    
}



//
- (void)titleNot:(NSNotification *)not{
    
    NSNumber *page = not.object;
    _titleLable.text = [NSString stringWithFormat:@"%@ of %ld",page,_urls.count];
    [self.view addSubview:_titleLable];

}


//单元格中图片点击的通知方法
- (void)cellImgClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
