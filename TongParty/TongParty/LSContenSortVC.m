//
//  LSContenSortVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSContenSortVC.h"
#import "LSContentSortingView.h"
#import "TSActionDemoView.h"
@interface LSContenSortVC ()
@property (nonatomic, strong)LSContentSortingView *contentSortView;
@end

@implementation LSContenSortVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.contentSortView.dataDict) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    [MBProgressHUD showLoading:self.contentSortView];
    [DDTJHttpRequest getActivitiesListblock:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.contentSortView];
        if (dict) {
            self.contentSortView.dataDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        }
    } failure:^{
        
    }];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentSortView];
}

- (LSContentSortingView *)contentSortView {
    WeakSelf(weakSelf);
    if (!_contentSortView) {
        _contentSortView = [[LSContentSortingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight*2/2.8f)];
        _contentSortView.addCustomActivity = ^{
            TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
            demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
            demoAlertView.isAutoHidden = YES;
            demoAlertView.titleString = @"活动名称";
            demoAlertView.ploceHolderString = @"请输入活动名称";
            typeof(TSActionDemoView) __weak *weakView = demoAlertView;
            [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
                typeof(TSActionDemoView) __strong *strongView = weakView;
                [DDTJHttpRequest customActivitieWith:string block:^(NSDictionary *dict) {
                    [weakSelf loadData];
                } failure:^{
                    
                }];
                [strongView dismissAnimated:YES];
            }];
            [demoAlertView show];
        };
        _contentSortView.confirmSort = ^(NSArray *selectedArray) {
            weakSelf.confirmSort(selectedArray);
        };
    }
    return _contentSortView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
