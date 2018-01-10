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
#import "LSActivityEntity.h"

@interface LSContentSortingView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)UIButton    *btn_cancel;
@property (nonatomic, strong)UIButton    *btn_confirm;
@property (nonatomic, strong)NSMutableDictionary    *customDic;
@property (nonatomic, strong)NSMutableArray         *activityArr;
@property (nonatomic, strong)NSMutableDictionary    *hot_actDic;
@property (nonatomic, strong)NSMutableArray         *selectedArr; // 被选择的活动
@end

@implementation LSContentSortingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgWhiteGrayColor;
        [self setupViews];
    }
    return self;
}


- (void)setDataDict:(NSMutableDictionary *)dataDict {
    
    self.customDic = [NSMutableDictionary dictionary];
    self.activityArr = [NSMutableArray array];
    self.hot_actDic = [NSMutableDictionary dictionary];
    self.selectedArr = [NSMutableArray array];
    [self.customDic setObject:[LSActivityEntity mj_objectArrayWithKeyValuesArray:dataDict[@"custom"]] forKey:@"labels"];
    [self.customDic setObject:@"1" forKey:@"isexpand"];
    NSArray *acArr = [LSActivityEntity mj_objectArrayWithKeyValuesArray:dataDict[@"activity"]];
    for (LSActivityEntity *aEntity in acArr) {
        aEntity.child = [LSActivityEntity mj_objectArrayWithKeyValuesArray:aEntity.child];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:aEntity forKey:@"labels"];
        [dic setObject:@"1" forKey:@"isexpand"];
        [self.activityArr addObject:dic];
    }
    
    [self.hot_actDic setObject:[LSActivityEntity mj_objectArrayWithKeyValuesArray:dataDict[@"hot_act"]] forKey:@"labels"];
    [self.hot_actDic setObject:@"1" forKey:@"isexpand"];
    
    [self.collectionView reloadData];
}

- (void)setupViews {;

    [self addSubview:self.btn_cancel];
    [_btn_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    [_btn_cancel setTitle:@"重置" forState:UIControlStateNormal];
    [_btn_cancel setTitleColor:kBlackColor forState:UIControlStateNormal];
    _btn_cancel.titleLabel.font = DDFitFont(16.f);
    [_btn_cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [_btn_confirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel:(UIButton *)sender {
    _btn_confirm.backgroundColor = kWhiteColor;
    [_btn_confirm setTitleColor:kBlackColor forState:UIControlStateNormal];
    _btn_cancel.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    [_btn_cancel setTitleColor:kWhiteColor forState:UIControlStateNormal];
    if (!self.selectedArr) {
        return;
    }
    for (LSActivityEntity *entity in self.selectedArr) {
        entity.is_selected = NO;
    }
    [self.collectionView reloadData];
    [self.selectedArr removeAllObjects];
}

- (void)confirm:(UIButton *)sender {
    _btn_cancel.backgroundColor = kWhiteColor;
    [_btn_cancel setTitleColor:kBlackColor forState:UIControlStateNormal];
    _btn_confirm.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    [_btn_confirm setTitleColor:kWhiteColor forState:UIControlStateNormal];
    if (_confirmSort) {
        _confirmSort(self.selectedArr);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);
        layout.footerReferenceSize = CGSizeMake(self.frame.size.width, 15);
        //layout.itemSize =CGSizeMake(110, 150);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 55.f) collectionViewLayout:layout];
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
    return 2 + self.activityArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *labelsArr = self.customDic[@"labels"];
        NSString *isexpand = self.customDic[@"isexpand"];
        if (labelsArr.count > 8 && [isexpand isEqualToString:@"1"]) {
            return 8;
        }
        return labelsArr.count;
    }
    if (section == 1) {
        NSArray *labelsArr = self.hot_actDic[@"labels"];
        NSString *isexpand = self.hot_actDic[@"isexpand"];
        if (labelsArr.count > 8 && [isexpand isEqualToString:@"1"]) {
            return 8;
        }
        return labelsArr.count;
    }
    if (section - 2 >= 0) {
        NSMutableDictionary *d = self.activityArr[section - 2];
        LSActivityEntity *entity = d[@"labels"];
        NSString *isexpand = d[@"isexpand"];
        if (entity.child.count > 8 && [isexpand isEqualToString:@"1"]) {
            return 8;
        }
        return entity.child.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSContentLabelCollectionViewCell *cell = (LSContentLabelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LSContentLabelCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *d;
    if (indexPath.section == 0) {
        d = self.customDic;
    }
    if (indexPath.section == 1) {
        d = self.hot_actDic;
    }
    NSArray *labelsArr = d[@"labels"];
    if (indexPath.section <= 1) {
        LSActivityEntity *entity = labelsArr[indexPath.row];
        cell.lbl_action.textColor = entity.is_selected ? kWhiteColor:kCommonGrayTextColor;
        cell.lbl_action.backgroundColor = entity.is_selected ? kGreenColor:kWhiteColor;
        cell.lbl_action.text = entity.name;
    } else {
        if (indexPath.section - 2 >= 0) {
            NSMutableDictionary *d = self.activityArr[indexPath.section - 2];
            LSActivityEntity *fentity = d[@"labels"];
            LSActivityEntity *childentity = fentity.child[indexPath.row];
            cell.lbl_action.textColor = childentity.is_selected ? kWhiteColor:kCommonGrayTextColor;
            cell.lbl_action.backgroundColor = childentity.is_selected ? kGreenColor:kWhiteColor;
            cell.lbl_action.text = childentity.name;
        }
    }


    cell.backgroundColor = kBgWhiteGrayColor;
    
    return cell;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width/5.0f, self.frame.size.width/13.f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LSContentLabelCollectionViewCell *cell = (LSContentLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *d;
    if (indexPath.section == 0) {
        d = self.customDic;
    }
    if (indexPath.section == 1) {
        d = self.hot_actDic;
    }
    NSArray *labelsArr = d[@"labels"];
    if (indexPath.section <= 1) {
        LSActivityEntity *entity = labelsArr[indexPath.row];
        entity.is_selected = !entity.is_selected;
        if (entity.is_selected) {
            [self.selectedArr addObject:entity];
        } else {
            [self.selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (entity == obj) {
                    [self.selectedArr removeObject:entity];
                }
            }];
        }
        [self updateCollectionViewCellStatus:cell selected:entity.is_selected];
    } else {
        if (indexPath.section - 2 >= 0) {
            NSMutableDictionary *d = self.activityArr[indexPath.section - 2];
            LSActivityEntity *fentity = d[@"labels"];
            LSActivityEntity *childentity = fentity.child[indexPath.row];
            childentity.is_selected = !childentity.is_selected;
            if (childentity.is_selected) {
                [self.selectedArr addObject:childentity];
            } else {
                [self.selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (childentity == obj) {
                        [self.selectedArr removeObject:childentity];
                    }
                }];
            }
            [self updateCollectionViewCellStatus:cell selected:childentity.is_selected];
        }
    }
}


-(void)updateCollectionViewCellStatus:(LSContentLabelCollectionViewCell *)myCollectionCell selected:(BOOL)selected {
    myCollectionCell.lbl_action.textColor = selected ? kWhiteColor:kCommonGrayTextColor;
    myCollectionCell.lbl_action.backgroundColor = selected ? kGreenColor:kWhiteColor;
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
        for (id obj in headerView.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton* theButton = (UIButton*)obj;
                [theButton removeFromSuperview];
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
        if (indexPath.section == 0) {
            label.text = @"我的活动";
            UIButton *customBtn = [UIButton new];
            [headerView addSubview:customBtn];
            [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerView);
                make.right.equalTo(headerView).offset(-DDFitWidth(8.f));
            }];
            [customBtn setTitle:@"添加活动" forState:UIControlStateNormal];
            [customBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [customBtn setBackgroundImage:kImage(@"desk_manage_address") forState:UIControlStateNormal];
            customBtn.titleLabel.font = DDFitFont(13.f);
            [customBtn addTarget:self action:@selector(addCustomActivity:) forControlEvents:UIControlEventTouchUpInside];
        } else if (indexPath.section == 1) {
            label.text = @"热门活动";
        } else {
            if (indexPath.section - 2 >= 0) {
                NSMutableDictionary *d = self.activityArr[indexPath.section - 2];
                LSActivityEntity *fentity = d[@"labels"];
                label.text = fentity.name;
            }
        }
        
        headerView.backgroundColor = kBgWhiteGrayColor;
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSArray *labelsArr;
        NSString *isexpand; // 0 展开  1 不展开
        
        if (indexPath.section == 0) {
            labelsArr = self.customDic[@"labels"];
            isexpand = self.customDic[@"isexpand"];
        }else if (indexPath.section == 1) {
            labelsArr = self.hot_actDic[@"labels"];
            isexpand = self.hot_actDic[@"isexpand"];
        } else {
            NSMutableDictionary *d = self.activityArr[indexPath.section - 2];
            LSActivityEntity *aentity = d[@"labels"];
            labelsArr = aentity.child;
            isexpand = d[@"isexpand"];
        }
        
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


// 自定义活动
- (void)addCustomActivity:(UIButton *)sender {
    if (_addCustomActivity) {
        _addCustomActivity();
    }
}

- (void)expandSection:(UITapGestureRecognizer *)tap {
    
    UILabel *label = (UILabel *)[tap view];
    NSMutableDictionary *d;
    if (label.tag == 0) {
        d = self.customDic;
    } else if (label.tag == 1) {
        d = self.hot_actDic;
    } else {
        d = self.activityArr[label.tag - 2];
    }
    NSString *isexpand = [d objectForKey:@"isexpand"]; // 0 展开  1 不展开
    if ([isexpand isEqualToString:@"0"]) {
        [d setValue:@"1" forKey:@"isexpand"];
    } else {
        [d setValue:@"0" forKey:@"isexpand"];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:label.tag]];
}




@end
