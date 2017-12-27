//
//  LSContenSortVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSContenSortVC.h"
#import "LSContentSortingView.h"
@interface LSContenSortVC ()
@property (nonatomic, strong)LSContentSortingView *contentSortView;
@end

@implementation LSContenSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    [DDTJHttpRequest getActivitiesListblock:^(NSDictionary *dict) {
        
    } failure:^{
        
    }];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentSortView];
}

- (LSContentSortingView *)contentSortView {
    if (!_contentSortView) {
        _contentSortView = [[LSContentSortingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight*2/3)];
        
    }
    return _contentSortView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
