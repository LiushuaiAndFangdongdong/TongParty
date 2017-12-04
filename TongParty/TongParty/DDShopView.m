
//
//  DDShopView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShopView.h"
#import "DDStretchableTableHeaderView.h"

@interface DDShopView()
@property (nonatomic, strong) UIImageView *bgImageView ;
@property (nonatomic, strong) DDStretchableTableHeaderView *stretchHeaderView;
@end

@implementation DDShopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)initStretchHeader
{
    //背景
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.userInteractionEnabled = YES;
    //    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"placeHolder" ofType:@".jpg"]];
    
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:_bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchPic:)]];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:CGRectMake(15, 30, 26, 26)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBack_Click:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnBack];
//    
//    self.pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 90, contentView.frame.size.height - 30, 80, 20)];
//    self.pageLabel.textColor = [UIColor whiteColor];
//    self.pageLabel.font = [UIFont systemFontOfSize:15];
//    self.pageLabel.textAlignment = NSTextAlignmentRight;
//    [contentView addSubview:self.pageLabel];
    
    self.stretchHeaderView = [DDStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self withView:_bgImageView subViews:contentView];
    
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}


- (void)setupViews{
    
}

@end






