
//
//  DDShopDetailViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShopDetailViewController.h"
#import "DDStretchableTableHeaderView.h"
#import "DDNoticeMessageCell.h"

@interface DDShopDetailViewController ()
@property (nonatomic, strong) UIImageView *bgImageView ;
@property (nonatomic, strong) DDStretchableTableHeaderView *stretchHeaderView;
@end

@implementation DDShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self initStretchHeader];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kBgWhiteGrayColor;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
}

- (void)initStretchHeader
{
    //背景
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = kImage(@"person_bg_image");
//    _bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"placeHolder" ofType:@".jpg"]];
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:_bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchPic:)]];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:CGRectMake(15, 30, 26, 26)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"back_tj"] forState:UIControlStateNormal];
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
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:_bgImageView subViews:contentView];
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDNoticeMessageCell *cell = [DDNoticeMessageCell cellWithTableView:self.tableView];
    //    cell.elementModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end







