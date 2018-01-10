//
//  LSPlayRewardGiftVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSPlayRewardGiftVC.h"
#import "LSGiftCollectionViewCell.h"
#import "LSGiftCollectionViewLayout.h"
#import "LSGiftEntity.h"
@interface LSPlayRewardGiftVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *view_control;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LSPlayRewardGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    [DDTJHttpRequest getGiftsDicblock:^(NSDictionary *dict) {
        self.dataArray = [LSGiftEntity mj_objectArrayWithKeyValuesArray:dict];
        [self.collectionView reloadData];
    } failure:^{
        
    }];
}
- (void)setupViews {
    self.view.backgroundColor = kClearColor;
    [self view_control];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat collectionView_H = kScreenHeight/2.8f - DDFitHeight(50.f);
        layout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        layout.itemSize = CGSizeMake(kScreenWidth/4.f, collectionView_H/2.f);
        layout.minimumInteritemSpacing = -0.5;
        layout.minimumLineSpacing = -0.5;;
        _collectionView.pagingEnabled = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight - collectionView_H - kNavigationBarHeight - DDFitHeight(50.f), kScreenWidth, collectionView_H) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSGiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LSGiftCollectionViewCell"];
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIView *)view_control {
    if (!_view_control) {
        _view_control = [UIView new];
        [self.view addSubview:_view_control];
        [_view_control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.collectionView.mas_bottom).offset(0.5f);
            make.bottom.equalTo(self.view);
        }];
        _view_control.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        
        UIImageView *iv_coin = [UIImageView new];
        [_view_control addSubview:iv_coin];
        [iv_coin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view_control);
            make.height.width.mas_equalTo(DDFitHeight(20.f));
            make.left.mas_equalTo(10.f);
        }];
        iv_coin.image = kImage(@"Gift_coin");
        
        UILabel *lbl_coinCount = [UILabel new];
        [_view_control addSubview:lbl_coinCount];
        [lbl_coinCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iv_coin);
            make.left.equalTo(iv_coin.mas_right).offset(5);
        }];
        lbl_coinCount.text = @"铜币 10";
        lbl_coinCount.textColor = kWhiteColor;
        lbl_coinCount.font = DDFitFont(12.f);
        
        UIButton *btn_addGift = [UIButton new];
        [_view_control addSubview:btn_addGift];
        [btn_addGift mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view_control);
            make.left.equalTo(lbl_coinCount.mas_right).offset(5);
            make.height.width.equalTo(iv_coin);
        }];
        [btn_addGift setBackgroundImage:kImage(@"Gift_recharge_add") forState:UIControlStateNormal];
    }
    return _view_control;
}

#pragma mark collectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSGiftCollectionViewCell *cell = (LSGiftCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LSGiftCollectionViewCell" forIndexPath:indexPath];
    [cell updateValueWith:self.dataArray[indexPath.row]];
    cell.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = kBgWhiteGrayColor.CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //LSGiftCollectionViewCell *cell = (LSGiftCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //[self updateCollectionViewCellStatus:cell selected:YES];
}

-(void)updateCollectionViewCellStatus:(LSGiftCollectionViewCell *)myCollectionCell selected:(BOOL)selected {

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
