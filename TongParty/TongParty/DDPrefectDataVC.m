
//
//  DDPrefectDataVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPrefectDataVC.h"
#import "DDPrefectDataView.h"
#import "DDUserInfoModel.h"
@interface DDPrefectDataVC ()<LSUpLoadImageManagerDelegate>
@property (nonatomic, strong) DDPrefectDataView *dataView;
@end

@implementation DDPrefectDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"完善基本信息"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(exsit)];
    [self.view addSubview:self.dataView];
}

- (DDPrefectDataView *)dataView{
    WeakSelf(weakSelf);
    if (!_dataView) {
        _dataView = [[DDPrefectDataView alloc] initWithFrame:self.view.bounds];
        _dataView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
        _dataView.uploadHeaderImage = ^{
            [LSUPLOAD_IMAGE  showActionSheetInFatherViewController:weakSelf delegate:weakSelf];
        };
        _dataView.confirmUpInfo = ^(NSString *sex, NSString *name) {
            [weakSelf uploadInfoWithName:name sex:sex];
        };
    }
    return _dataView;
}

- (void)uploadInfoWithName:(NSString *)name sex:(NSString *)sex {
    DDUserInfoModel *model = [[DDUserInfoModel alloc] init];
    model.sex = sex;
    model.name = name;
    [DDTJHttpRequest upUserInfoWith:model block:^(NSDictionary *dict) {
        [self exsit];
    } failure:^{
        
    }];
}

- (void)uploadImageToServerWithImage:(UIImage *)image {
    [DDTJHttpRequest upUserHeaderImage:image block:^(NSDictionary *dict) {
        [self.dataView.avatarView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:kImage(@"add_avatar_default")];
    } failure:^{
        
    }];
}

- (void)exsit {
    if (self.isModen) {
        [self dismiss];
    } else {
        [self pop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end











