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
@interface LSRecommendAddressVC ()<UISearchBarDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, weak) DOPDropDownMenu *menu;
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
    return DDFitWidth(44.f);
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    //    NHDiscoverCategoryElement *elementModel = self.dataArray[indexPath.row];
    //    NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCategoryElement:elementModel];
    //    //    [[NHDiscoverTopicViewController alloc] initWithCatogoryId:elementModel.ID];
    //    [self pushVc:topic];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {

    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    menu.layer.borderWidth = 0.24;
    menu.layer.borderColor = [UIColor grayColor].CGColor;
    //    [self.view addSubview:menu];
    _menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //    [menu selectDefalutIndexPath];
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];

    
    return menu;
}

#pragma mark  -DOPDropDownMenuDataSource \DOPDropDownMenuDelegate

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    return self.classifys[indexPath.column];
}

// new datasource
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath {
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath {
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
