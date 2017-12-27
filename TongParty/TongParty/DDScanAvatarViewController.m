
//
//  DDScanAvatarViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDScanAvatarViewController.h"

@interface DDScanAvatarViewController ()
@property (nonatomic, strong) UIImageView *bigAvatarView;
@end

@implementation DDScanAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"头像"];
    [self.view addSubview:self.bigAvatarView];
}

- (UIImageView *)bigAvatarView{
    if (!_bigAvatarView) {
        _bigAvatarView = [[UIImageView   alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight/2)];
        NSURL *avatarUrl = [NSURL URLWithString:[DDUserSingleton shareInstance].image];
        [_bigAvatarView sd_setImageWithURL:avatarUrl placeholderImage:kDefaultAvatar];
    }
    return _bigAvatarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
