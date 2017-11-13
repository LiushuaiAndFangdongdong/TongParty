//
//  LSRecommendAddressVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRecommendAddressVC.h"
#import "LSRecommendAddressCell.h"
#import "DOPDropDownMenu.h"
#import "LSSortingView.h"
@interface LSRecommendAddressVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LSSortingView *sortingView;
@property (nonatomic, strong) NSArray *classifys;
@end

@implementation LSRecommendAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSelectData];
    [self setupNavi];
    [self setUpViews];
}


- (void)tj_refresh {
    [self tj_endRefresh];
}

- (void)tj_loadMore {
    [self tj_endLoadMore];
}

-(void)initSelectData{
    
    // 数据
    self.classifys = @[@"内容",@"人均",@"位置",@"其他"];

}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}


- (void)setupNavi {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30))];
    titleView.backgroundColor = [UIColor whiteColor];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    [titleView addSubview:self.searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma  mark search view
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30));
        _searchBar.backgroundColor = kBgWhiteGrayColor;
        _searchBar.layer.cornerRadius = DDFitHeight(15);
        _searchBar.layer.masksToBounds = YES;
        [_searchBar.layer setBorderWidth:5];
        [_searchBar.layer setBorderColor:kBgWhiteGrayColor.CGColor];  //设置边框为白色
        _searchBar.backgroundImage = [UIImage new];
        //_searchBar.text = @"你看他在狼人杀";
        //[self.searchBar resignFirstResponder];
    }
    return _searchBar;
}

- (LSSortingView *)sortingView {
    if (!_sortingView) {
        _sortingView = [[LSSortingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _sortingView.onTapBlcok = ^(NSInteger index) {
            NSLog(@"%ld",index);
        };
    }
    return _sortingView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    LSRecommendAddressCell *cell = [LSRecommendAddressCell cellWithTableView:self.tableView];

    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(85.f);
}

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section {
    return DDFitWidth(40.f);
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    if (_selectedAddressResult) {
        _selectedAddressResult(@"阜北社区8号楼41单元9号");
    }
    [self pop];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {

    return self.sortingView;
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
