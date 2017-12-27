//
//  LSContentSortingView.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSContentSortingView.h"
#import "LSContentLabelCollectionViewCell.h"
#import "LSContentHeaderView.h"
#import "LSContentFooterView.h"
@interface LSContentSortingView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)UIButton    *btn_cancel;
@property (nonatomic, strong)UIButton    *btn_confirm;
@end

@implementation LSContentSortingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.dataArray = [NSMutableArray array];
    NSArray *labelArr = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr1 = @[@"KTV",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr2 = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr3 = @[@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:labelArr forKey:@"labels"];
    [dic setObject:@"1" forKey:@"isexpand"];
    [self.dataArray addObject:dic];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:labelArr1 forKey:@"labels"];
    [dic1 setObject:@"1" forKey:@"isexpand"];
    [self.dataArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:labelArr2 forKey:@"labels"];
    [dic2 setObject:@"1" forKey:@"isexpand"];
    [self.dataArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:labelArr3 forKey:@"labels"];
    [dic3 setObject:@"1" forKey:@"isexpand"];
    [self.dataArray addObject:dic3];
    
    [self.collectionView reloadData];
    
    [self addSubview:self.btn_cancel];
    [_btn_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    [_btn_cancel setTitle:@"重置" forState:UIControlStateNormal];
    [_btn_cancel setTitleColor:kBlackColor forState:UIControlStateNormal];
    _btn_cancel.titleLabel.font = DDFitFont(16.f);
    
    [self addSubview:self.btn_confirm];
    [_btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    [_btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
    _btn_confirm.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    [_btn_confirm setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _btn_confirm.titleLabel.font = DDFitFont(16.f);
    
    self.backgroundColor = kWhiteColor;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);
        layout.footerReferenceSize = CGSizeMake(self.frame.size.width, 15);
        //layout.itemSize =CGSizeMake(110, 150);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 45.f) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentLabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LSContentLabelCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LSContentHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LSContentFooterView"];
        _collectionView.backgroundColor = kBgWhiteGrayColor;
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - 懒加载
- (UIButton *)btn_cancel {
    if (!_btn_cancel) {
        _btn_cancel = [UIButton new];
    }
    return _btn_cancel;
}

- (UIButton *)btn_confirm {
    if (!_btn_confirm) {
        _btn_confirm = [UIButton new];
    }
    return _btn_confirm;
}

#pragma mark collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *d = self.dataArray[section];
    NSArray *labelsArr = d[@"labels"];
    NSString *isexpand = d[@"isexpand"]; // 0 展开  1 不展开
    if (labelsArr.count > 8 && [isexpand isEqualToString:@"1"]) {
        return 8;
    }
    return labelsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSContentLabelCollectionViewCell *cell = (LSContentLabelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LSContentLabelCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *d = self.dataArray[indexPath.section];
    NSArray *labelsArr = d[@"labels"];
    cell.lbl_action.text = labelsArr[indexPath.row];
    cell.backgroundColor = kBgWhiteGrayColor;
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width/5.0f, self.frame.size.width/12.f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LSContentHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LSContentHeaderView" forIndexPath:indexPath];
        for (id obj in headerView.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel* theLabel = (UILabel*)obj;
                [theLabel removeFromSuperview];
            }
        }
        UILabel *label = [UILabel new];
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.left.equalTo(headerView).offset(DDFitWidth(8.f));
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kBlackColor;
        label.font = DDFitFont(14.f);
        label.text = @"狼人杀";
        headerView.backgroundColor = kBgWhiteGrayColor;
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSDictionary *d = self.dataArray[indexPath.section];
        NSArray *labelsArr = d[@"labels"];
        NSString *isexpand = d[@"isexpand"]; // 0 展开  1 不展开
        
        LSContentFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LSContentFooterView" forIndexPath:indexPath];
        // 清空
        for (id obj in footerView.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel* theLabel = (UILabel*)obj;
                [theLabel removeFromSuperview];
            }
        }
        
        if (labelsArr.count > 8) {
            UILabel *label = [UILabel new];
            [footerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(footerView);
            }];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = kCommonGrayTextColor;
            label.font = DDFitFont(13.f);
            if ([isexpand isEqualToString:@"0"]) {
                label.text = @"收起部分";
            } else {
                label.text = @"展开全部";
            }
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandSection:)]];
            label.tag = indexPath.section;
        }
        
        return footerView;
    }
    return nil;
}


- (void)expandSection:(UITapGestureRecognizer *)tap {
    
    UILabel *label = (UILabel *)[tap view];
    NSMutableDictionary *d = self.dataArray[label.tag];
    NSString *isexpand = [d objectForKey:@"isexpand"]; // 0 展开  1 不展开
    if ([isexpand isEqualToString:@"0"]) {
        [d setValue:@"1" forKey:@"isexpand"];
    } else {
        [d setValue:@"0" forKey:@"isexpand"];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:label.tag]];
}




@end
