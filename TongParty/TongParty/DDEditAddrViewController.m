

//
//  DDEditAddrViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDEditAddrViewController.h"
#import "DDEditAddrView.h"
#import "DDLocationAddressVC.h"

@interface DDEditAddrViewController ()
@property (nonatomic, strong) DDEditAddrView *editView;
@end

@implementation DDEditAddrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self addViews];
}

- (void)addViews{
    [self.view addSubview:self.editView];
}

- (void)setupNavi {
    [self navigationWithTitle:_titleStr];
    if ([_titleStr isEqualToString:@"编辑地址"]) {
        self.navigationItem.rightBarButtonItem = [self customTitleButtonForNavigationWithAction:@selector(deleteAddress:) title:@"删除" CGSize:CGSizeMake(35,20)];
    }
}

- (DDEditAddrView *)editView{
    WeakSelf(weakSelf);
    if (!_editView) {
        _editView = [[DDEditAddrView alloc] initWithFrame:self.view.bounds];
        _editView.locationAddrBlcok = ^{
            [weakSelf pushLocationVC];
        };
        _editView.saveAddrBlcok = ^(DDAddressModel *addrModel) {
            [weakSelf saveAddressWithModel:addrModel];
        };
        if (_tmpModel) {
            [_editView tempEditValueWith:_tmpModel];
        }
    }
    return _editView;
}

#pragma mark - 删除地址
- (void)deleteAddress:(UIButton *)sender{

    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest deleteCustomAddressWithToken:TOKEN aid:_tmpModel.id block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self popViewController];
        });
    } failure:^{
        //
    }];
}

#pragma mark - 保存地址
- (void)saveAddressWithModel:(DDAddressModel *)model{
    
    if (model.addr == nil || model.addr == NULL ||[model.addr isEqualToString:@""]) {
        [MBProgressHUD showError:@"请定位并选择" toView:self.view];
    }
    if (model.detail == nil || model.detail == NULL ||[model.detail isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入详细地址" toView:self.view];
    }
    
    if ([_titleStr isEqualToString:@"编辑地址"]){
        
        //编辑地址
        [MBProgressHUD showLoading:self.view];
        [DDTJHttpRequest editCustomAddressWithToken:TOKEN aid:_tmpModel.id latitude:model.latitude longitude:model.longitude label:model.label addr:model.addr detail:model.detail block:^(NSDictionary *dict) {
            [MBProgressHUD hideAllHUDsInView:self.view];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self popViewController];
            });
        } failure:^{
            //
        }];
        
    }else{
        
        //新增地址
        [MBProgressHUD showLoading:self.view];
        [DDTJHttpRequest addCustomAddressWithToken:[DDUserSingleton shareInstance].token latitude:model.latitude longitude:model.longitude label:model.label addr:model.addr detail:model.detail block:^(NSDictionary *dict) {
            
            [MBProgressHUD hideAllHUDsInView:self.view];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self popViewController];
            });
        } failure:^{
            //
        }];
    }
}


#pragma mark - 去定位
- (void)pushLocationVC{
    DDLocationAddressVC *locationVC   = [[DDLocationAddressVC alloc] init];
    
    locationVC.locationAddressSelectBlcok = ^(AMapPOI *POI) {
        
        [_editView updateWithMap:POI];
    };
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






