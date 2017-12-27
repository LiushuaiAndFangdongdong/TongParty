//
//  DDBaseTableViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDBaseTableView.h"
#import "DDBaseTableViewCell.h"
#import "DDCustomCommonEmptyView.h"

//
typedef void(^DDTableVcCellSelectedHandle)(DDBaseTableViewCell *cell, NSIndexPath *indexPath);

//
typedef NS_ENUM(NSUInteger, DDBaseTableVcRefreshType) {
    /** 无法刷新*/
    DDBaseTableVcRefreshTypeNone = 0,
    /** 只能刷新*/
    DDBaseTableVcRefreshTypeOnlyCanRefresh,
    /** 只能上拉加载*/
    DDBaseTableVcRefreshTypeOnlyCanLoadMore,
    /** 都能刷新加载*/
    DDBaseTableVcRefreshTypeRefreshAndLoadMore
};

@interface DDBaseTableViewController : DDBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}

/** 刚才执行的是刷新*/
@property (nonatomic, assign) NSInteger isRefresh;

/** 刚才执行的是上拉加载*/
@property (nonatomic, assign) NSInteger isLoadMore;

/** 添加空界面文字*/
- (void)tj_addEmptyPageWithText:(NSString *)text;

/** 设置导航栏右边的item*/
- (void)tj_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 设置导航栏左边的item*/
- (void)tj_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 监听通知*/
- (void)tj_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 隐藏statusBar*/
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/** 导航右边Item*/
@property (nonatomic, strong) UIBarButtonItem *navRightItem;

/** 导航左边Item*/
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;

/** 标题*/
@property (nonatomic, copy) NSString *navItemTitle;

/** 表视图*/
@property (nonatomic, weak) DDBaseTableView *tableView;

/** 表视图偏移*/
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 加载刷新类型*/
@property (nonatomic, assign) DDBaseTableVcRefreshType refreshType;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

/** 刷新数据*/
- (void)tj_reloadData;

/** 开始下拉*/
- (void)tj_beginRefresh;

/** 停止刷新*/
- (void)tj_endRefresh;

/** 停止上拉加载*/
- (void)tj_endLoadMore;

/** 隐藏刷新*/
- (void)tj_hiddenRrefresh;

/** 隐藏上拉加载*/
- (void)tj_hiddenLoadMore;

/** 提示没有更多信息*/
- (void)tj_noticeNoMoreData;

/** 配置数据*/
- (void)tj_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;

/** 配置数据*/
- (void)tj_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText;

/** 是否在下拉刷新*/
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;

/** 是否在上拉加载*/
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;

#pragma mark - 子类去重写
/** 左滑删除*/
-(void)tj_commitEditForRowAtIndexPath:(NSIndexPath *)indexPath;
/** 分组数量*/
- (NSInteger)tj_numberOfSections;

/** 某个分组的cell数量*/
- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section;

/** 某行的cell*/
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 点击某行*/
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell;

/** 某行行高*/
- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/** 某个组头*/
- (UIView *)tj_headerAtSection:(NSInteger)section;

/** 某个组尾*/
- (UIView *)tj_footerAtSection:(NSInteger)section;

/** 某个组头高度*/
- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section;

/** 某个组尾高度*/
- (CGFloat)tj_sectionFooterHeightAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)tj_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类去继承
/** 刷新方法*/
- (void)tj_refresh;

/** 上拉加载方法*/
- (void)tj_loadMore;

@property (nonatomic, assign) BOOL showRefreshIcon;

- (void)endRefreshIconAnimation;

@property (nonatomic, weak, readonly) UIView *refreshHeader;

#pragma mark - loading & alert
- (void)tj_showLoading;

- (void)tj_hiddenLoading;

- (void)tj_showTitle:(NSString *)title after:(NSTimeInterval)after;


@end










