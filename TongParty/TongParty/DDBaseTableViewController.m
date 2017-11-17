//
//  DDBaseTableViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import "DDBaseTableHeaderFooterView.h"  //table footer
#import <objc/runtime.h>
#import "MJExtension.h"
#import "UIView+Tap.h"
#import "UIView+Layer.h"
#import "MJRefresh.h"

const char DDBaseTableVcNavRightItemHandleKey;
const char DDBaseTableVcNavLeftItemHandleKey;

@interface DDBaseTableViewController ()
@property (nonatomic, copy) DDTableVcCellSelectedHandle handle;
@property (nonatomic, weak) UIImageView *refreshImg;
@end

@implementation DDBaseTableViewController
@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;


#pragma mark   - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (DDBaseTableView *)tableView {
    if(!_tableView){
        DDBaseTableView *tab = [[DDBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//        DDBaseTableView *tab = [[DDBaseTableView alloc] initWithFrame:CGRectMake(self.view.mj_origin.x, self.view.mj_origin.y-1, self.view.mj_w, self.view.mj_h) style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
//        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.backgroundColor = kBgWhiteGrayColor;
        tab.separatorColor = kSeperatorColor;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。有时会加上顶部tool bar的高度 20, 20+44 = 64
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    
    //    [self nh_hiddenLoadMore];
}

#pragma mark - loading & alert
- (void)tj_showLoading {
    //    [FMHUD showLoading];
}

- (void)tj_hiddenLoading {
    //    [FMHUD hideHUD];
}

- (void)tj_showTitle:(NSString *)title after:(NSTimeInterval)after {
    //    [FDHUD showTitle:title];
    //    [FDHUD hideHUDAfterTimeout:after];
}

/** 添加空界面文字*/
- (void)tj_addEmptyPageWithText:(NSString *)text {
    //    [[NHEmptyPageManager sharedManager] setDelegateForScrollView:self.tableView emptyText:text];
}

/** 设置导航栏右边的item*/
- (void)tj_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle {
    [self tj_setUpNavItemTitle:itemTitle handle:handle leftFlag:NO];
}

/** 设置导航栏左边的item*/
- (void)tj_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *leftItemTitle))handle {
    [self tj_setUpNavItemTitle:itemTitle handle:handle leftFlag:YES];
}

- (void)tj_navItemHandle:(UIBarButtonItem *)item {
    void (^handle)(NSString *) = objc_getAssociatedObject(self, &DDBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

- (void)tj_setUpNavItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *itemTitle))handle leftFlag:(BOOL)leftFlag {
    if (itemTitle.length == 0 || !handle) {
        if (itemTitle == nil) {
            itemTitle = @"";
        } else if ([itemTitle isKindOfClass:[NSNull class]]) {
            itemTitle = @"";
        }
        if (leftFlag) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    } else {
        if (leftFlag) {
            objc_setAssociatedObject(self, &DDBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(tj_navItemHandle:)];
        } else {
            objc_setAssociatedObject(self, &DDBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(tj_navItemHandle:)];
        }
    }
    
}

/** 监听通知*/
- (void)tj_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

/** 设置刷新类型*/
- (void)setRefreshType:(DDBaseTableVcRefreshType)refreshType {
    _refreshType = refreshType;
    switch (refreshType) {
        case DDBaseTableVcRefreshTypeNone: // 没有刷新
            break ;
        case DDBaseTableVcRefreshTypeOnlyCanRefresh: { // 只有下拉刷新
            [self tj_addRefresh];
        } break ;
        case DDBaseTableVcRefreshTypeOnlyCanLoadMore: { // 只有上拉加载
            [self tj_addLoadMore];
        } break ;
        case DDBaseTableVcRefreshTypeRefreshAndLoadMore: { // 下拉和上拉都有
            [self tj_addRefresh];
            [self tj_addLoadMore];
        } break ;
        default:
            break ;
    }
}

/** 导航栏标题*/
- (void)setNavItemTitle:(NSString *)navItemTitle {
    if ([navItemTitle isKindOfClass:[NSString class]] == NO) return ;
    if ([navItemTitle isEqualToString:_navItemTitle]) return ;
    _navItemTitle = navItemTitle.copy;
    self.navigationItem.title = navItemTitle;
}

- (NSString *)navItemTitle {
    return self.navigationItem.title;
}

/** statusBar是否隐藏*/
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return ;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (void)setShowRefreshIcon:(BOOL)showRefreshIcon {
    _showRefreshIcon = showRefreshIcon;
    self.refreshImg.hidden = !showRefreshIcon;
}

- (UIImageView *)refreshImg {
    if (!_refreshImg) {
        UIImageView *refreshImg = [[UIImageView alloc] init];
        [self.view addSubview:refreshImg];
        _refreshImg = refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image =kImage(@"refresh");
        WeakSelf(weakSelf);
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
        refreshImg.layerCornerRadius = 22;
        refreshImg.backgroundColor = kWhiteColor;
        
        [refreshImg setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf tj_beginRefresh];
        }];
    }
    return _refreshImg;
}

- (void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)endRefreshIconAnimation {
    [self.refreshImg.layer removeAnimationForKey:@"rotationAnimation"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

/** 右边item*/
- (void)setNavRightItem:(UIBarButtonItem *)navRightItem {
    
    _navRightItem = navRightItem;
    self.navigationItem.rightBarButtonItem = navRightItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}
/** 左边item*/
- (void)setNavLeftItem:(UIBarButtonItem *)navLeftItem {
    
    _navLeftItem = navLeftItem;
    self.navigationItem.leftBarButtonItem = navLeftItem;
}

- (UIBarButtonItem *)navLeftItem {
    return self.navigationItem.leftBarButtonItem;
}

/** 需要系统分割线*/
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

- (void)tj_addRefresh {
    [DDUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self tj_refresh];
    }];
}

- (void)tj_addLoadMore {
    [DDUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self tj_loadMore];
    }];
}

/** 表视图偏移*/
- (void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset {
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
//    WeakSelf(weakSelf);
    //    // update
    //    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(weakSelf.view).mas_offset(weakSelf.tableEdgeInset);
    //    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}
/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    _sepLineColor = sepLineColor;
    
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return _sepLineColor ? _sepLineColor : [UIColor whiteColor];
}

/** 刷新数据*/
- (void)tj_reloadData {
    [self.tableView reloadData];
}

/** 开始下拉*/
- (void)tj_beginRefresh {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils beginPullRefreshForScrollView:self.tableView];
    }
}

/** 刷新*/
- (void)tj_refresh {
    if (self.refreshType == DDBaseTableVcRefreshTypeNone || self.refreshType == DDBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return ;
    }
    self.isRefresh = YES; self.isLoadMore = NO;
}

/** 上拉加载*/
- (void)tj_loadMore {
    if (self.refreshType == DDBaseTableVcRefreshTypeNone || self.refreshType == DDBaseTableVcRefreshTypeOnlyCanRefresh) {
        return ;
    }
    if (self.dataArray.count == 0) {
        return ;
    }
    self.isRefresh = NO; self.isLoadMore = YES;
    
}

- (void)tj_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass {
    [self tj_commonConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}

//- (NHCustomNoNetworkEmptyView *)noNetworkEmptyView {
//    if (!_noNetworkEmptyView) {
//        NHCustomNoNetworkEmptyView *empty = [[NHCustomNoNetworkEmptyView alloc] init];
//        [self.view addSubview:empty];
//        _noNetworkEmptyView = empty;
//
//        WeakSelf(weakSelf);
//        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf.view);
//        }];
//        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(NHCustomNoNetworkEmptyView *emptyView) {
//            [weakSelf loadData];
//
//        };
//    }
//    return _noNetworkEmptyView;
//}

- (void)tj_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText {
    if ([response isKindOfClass:[NSArray class]] == NO) return ;
    if (self.isRefresh) { // 刷新
        
        // 停止刷新
        [self tj_endRefresh];
        
        // 设置模型数组
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        
        // 设置空界面占位文字
        if (emptyText.length) {
            //            [self nh_addEmptyPageWithText:emptyText];
            //            [self.view addSubview:self.noNetworkEmptyView];
        }
        
        // 刷新界面
        [self tj_reloadData];
        
    } else { // 上拉加载
        
        // 停止上拉
        [self tj_endLoadMore];
        
        // 没有数据提示没有更多了
        if ([response count] == 0) {
            [self tj_noticeNoMoreData];
        } else {
            
            // 设置模型数组
            NSArray *newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self tj_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            
            // 刷新界面
            [self tj_reloadData];
        }
    }
}

/** 停止刷新*/
- (void)tj_endRefresh {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils endRefreshForScrollView:self.tableView];
    }
}

/** 停止上拉加载*/
- (void)tj_endLoadMore {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils endLoadMoreForScrollView:self.tableView];
    }
}

/** 隐藏刷新*/
- (void)tj_hiddenRrefresh {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils hiddenHeaderForScrollView:self.tableView];
    }
}

/** 隐藏上拉加载*/
- (void)tj_hiddenLoadMore {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils hiddenFooterForScrollView:self.tableView];
    }
}

/** 提示没有更多信息*/
- (void)tj_noticeNoMoreData {
    if (self.refreshType == DDBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == DDBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [DDUtils noticeNoMoreDataForScrollView:self.tableView];
    }
}

/** 头部正在刷新*/
- (BOOL)isHeaderRefreshing {
    return [DDUtils headerIsRefreshForScrollView:self.tableView];
}

//* 尾部正在刷新
- (BOOL)isFooterRefreshing {
    return [DDUtils footerIsLoadingForScrollView:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(tj_numberOfSections)]) {
        return self.tj_numberOfSections;
    }
    return 0;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(tj_numberOfRowsInSection:)]) {
        return [self tj_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(tj_headerAtSection:)]) {
        return [self tj_headerAtSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(tj_footerAtSection:)]) {
        return [self tj_footerAtSection:section];
    }
    return nil;
}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self respondsToSelector:@selector(tj_cellAtIndexPath:)]) {
        return [self tj_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    DDBaseTableViewCell *cell = [DDBaseTableViewCell cellWithTableView:self.tableView];
    
    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DDBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(tj_didSelectCellAtIndexPath:cell:)]) {
        [self tj_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

- (UIView *)refreshHeader {
    return self.tableView.mj_header;
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) return ;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(tj_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self tj_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(tj_cellheightAtIndexPath:)]) {
        return [self tj_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(tj_sectionHeaderHeightAtSection:)]) {
        return [self tj_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(tj_sectionFooterHeightAtSection:)]) {
        return [self tj_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}


/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
////IOS9前自定义左滑多个按钮需实现此方法
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self tj_commitEditForRowAtIndexPath:indexPath];
////    // 删除模型
////    [self.wineArray removeObjectAtIndex:indexPath.row];
////    // 刷新
////    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//}
//
///**
// *  修改Delete按钮文字为“删除”
// */
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

-(void)tj_commitEditForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 刷新
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
};

- (NSInteger)tj_numberOfSections { return 0; }

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section { return 0; }

- (UITableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath { return [DDBaseTableViewCell cellWithTableView:self.tableView]; }

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 0; }

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell { }

- (UIView *)tj_headerAtSection:(NSInteger)section { return [DDBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (UIView *)tj_footerAtSection:(NSInteger)section { return [DDBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)tj_sectionFooterHeightAtSection:(NSInteger)section { return 0.01; }

- (UIEdgeInsets)tj_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0); }

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }


@end








