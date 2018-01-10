//
//  LSCreateDeskContentSortVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskContentSortVC.h"
#import "LSContentLabelCollectionViewCell.h"
#import "LSContentHeaderView.h"
#import "LSContentFooterView.h"
#import "TSActionDemoView.h"
@interface LSCreateDeskContentSortVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableDictionary    *customDic; // 我的活动
@property (nonatomic, strong)NSMutableArray         *activityArr; // 常规活动
@property (nonatomic, strong)NSMutableDictionary    *hot_actDic; // 热门活动
@property (nonatomic, strong)NSMutableDictionary *dataDict;
@property (nonatomic, strong)UIView       *view_searchBar;
@property (nonatomic, strong)NSArray      *searchResultArr;  // 搜索结果
@property (nonatomic, strong)NSMutableArray      *selectedEntityArr;  // 选择集合
@end

@implementation LSCreateDeskContentSortVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedEntityArr = [NSMutableArray array];
    [self customNavi];
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    [DDTJHttpRequest getActivitiesListblock:^(NSDictionary *dict) {
        if (dict) {
            self.dataDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        }
    } failure:^{
        
    }];
}

- (void)setDataDict:(NSMutableDictionary *)dataDict {
    self.customDic = [NSMutableDictionary dictionary];
    self.activityArr = [NSMutableArray array];
    self.hot_actDic = [NSMutableDictionary dictionary];
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
    self.view.backgroundColor = kBgWhiteGrayColor;
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 15);
        //layout.itemSize =CGSizeMake(110, 150);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kNavigationBarHeight - DDFitHeight(30.f)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentLabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LSContentLabelCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LSContentHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LSContentFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LSContentFooterView"];
        _collectionView.backgroundColor = kBgWhiteGrayColor;
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)customNavi {
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setTitleColor:kGreenColor forState:UIControlStateNormal];
    rBtn.titleLabel.font = DDFitFont(14.f);
    rBtn.frame = CGRectMake(0, 0, DDFitWidth(40.f),DDFitWidth(50.f));
    [rBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
    self.navigationItem.titleView = self.view_searchBar;
}

- (UIView *)view_searchBar {
    if (!_view_searchBar) {
        _view_searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, DDFitHeight(45.f))];
        _view_searchBar.backgroundColor = kWhiteColor;
        UISearchBar *search = [UISearchBar new];
        [_view_searchBar addSubview:search];
        [search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_view_searchBar);
            make.width.equalTo(_view_searchBar).multipliedBy(0.8f);
            make.height.equalTo(_view_searchBar).multipliedBy(0.6f);
        }];
        search.delegate = self;
        search.backgroundColor = kWhiteColor;
        search.layer.cornerRadius = DDFitHeight(15.f);
        search.layer.masksToBounds = YES;
        [search.layer setBorderWidth:1];
        [search.layer setBorderColor:[UIColor whiteColor].CGColor];
        UIImage* searchBarBg = [self GetImageWithColor:kBgWhiteGrayColor andHeight:DDFitHeight(45.f)];
        [search setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        [search setBackgroundImage:searchBarBg];
        [search setBackgroundColor:[UIColor clearColor]];
        search.placeholder = @"搜索活动";
    }
    return _view_searchBar;
}

- (void)rightAction:(UIButton *)sender {
//    [self pop];
//    if(_selectActivity) {
//        if (self.selectedEntityArr) {
//            _selectActivity(self.selectedEntityArr);
//        }
//    }
}


#pragma mark collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!self.searchResultArr) {
        return 2 + self.activityArr.count;
    } else {
        return 1;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.searchResultArr) {
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
    } else {
        return self.searchResultArr.count;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSContentLabelCollectionViewCell *cell = (LSContentLabelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LSContentLabelCollectionViewCell" forIndexPath:indexPath];
    if (!self.searchResultArr) {
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
    } else {
        LSActivityEntity *entity = self.searchResultArr[indexPath.row];
        cell.lbl_action.textColor = entity.is_selected ? kWhiteColor:kCommonGrayTextColor;
        cell.lbl_action.backgroundColor = entity.is_selected ? kGreenColor:kWhiteColor;
        cell.lbl_action.text = entity.name;
    }
    cell.backgroundColor = kBgWhiteGrayColor;
    return cell;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/5.0f, self.view.frame.size.width/14.f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LSContentLabelCollectionViewCell *cell = (LSContentLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!self.searchResultArr) {
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
            if(_selectActivity) {
                if (self.selectedEntityArr) {
                    _selectActivity(entity);
                }
            }
//            if (entity.is_selected && self.selectedEntityArr.count < 1) {
//                [self.selectedEntityArr addObject:entity];
//            } else {
//                [self.selectedEntityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if (entity == obj) {
//                        [self.selectedEntityArr removeObjectAtIndex:idx];
//                        *stop = YES;
//                    }
//                }];
//            }
            [self updateCollectionViewCellStatus:cell selected:entity.is_selected];
            [self pop];
        } else {
            if (indexPath.section - 2 >= 0) {
                NSMutableDictionary *d = self.activityArr[indexPath.section - 2];
                LSActivityEntity *fentity = d[@"labels"];
                LSActivityEntity *childentity = fentity.child[indexPath.row];
                childentity.is_selected = !childentity.is_selected;
                if(_selectActivity) {
                    if (self.selectedEntityArr) {
                        _selectActivity(childentity);
                    }
                }
//                if (childentity.is_selected && self.selectedEntityArr.count < 1) {
//                    [self.selectedEntityArr addObject:childentity];
//                } else {
//                    [self.selectedEntityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        if (childentity == obj) {
//                            [self.selectedEntityArr removeObjectAtIndex:idx];
//                            *stop = YES;
//                        }
//                    }];
//                }
                [self updateCollectionViewCellStatus:cell selected:childentity.is_selected];
                [self pop];
            }
        }
    } else {
        LSActivityEntity *entity = self.searchResultArr[indexPath.row];
        entity.is_selected = !entity.is_selected;
        if(_selectActivity) {
            if (self.selectedEntityArr) {
                _selectActivity(entity);
            }
        }
//        if (entity.is_selected && self.selectedEntityArr.count < 1) {
//            [self.selectedEntityArr addObject:entity];
//        } else {
//            [self.selectedEntityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (entity == obj) {
//                    [self.selectedEntityArr removeObjectAtIndex:idx];
//                    *stop = YES;
//                }
//            }];
//        }
        [self updateCollectionViewCellStatus:cell selected:entity.is_selected];
        [self pop];
    }

}


-(void)updateCollectionViewCellStatus:(LSContentLabelCollectionViewCell *)myCollectionCell selected:(BOOL)selected {
    myCollectionCell.lbl_action.textColor = selected ? kWhiteColor:kCommonGrayTextColor;
    myCollectionCell.lbl_action.backgroundColor = selected ? kGreenColor:kWhiteColor;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchResultArr) {
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
    } else {
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
            label.text = @"搜索结果";
            headerView.backgroundColor = kBgWhiteGrayColor;
            return headerView;
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {

            LSContentFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LSContentFooterView" forIndexPath:indexPath];
            // 清空
            for (id obj in footerView.subviews) {
                if ([obj isKindOfClass:[UILabel class]]) {
                    UILabel* theLabel = (UILabel*)obj;
                    [theLabel removeFromSuperview];
                }
            }
            
            UILabel *label = [UILabel new];
            [footerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(footerView);
            }];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = kCommonGrayTextColor;
            label.font = DDFitFont(13.f);
            return footerView;
        }
    }
    return nil;
}

#pragma mark - 搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        self.searchResultArr = nil;
        [self.collectionView reloadData];
    } else {
        [DDTJHttpRequest searchActivityByText:searchText block:^(NSDictionary *dict) {
            self.searchResultArr = [LSActivityEntity mj_objectArrayWithKeyValuesArray:dict];
            [self.collectionView reloadData];
        } failure:^{
            
        }];
    }
}


// 自定义活动
- (void)addCustomActivity:(UIButton *)sender {
    WeakSelf(weakSelf);
    TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
    demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
    demoAlertView.isAutoHidden = YES;
    demoAlertView.titleString = @"活动名称";
    demoAlertView.ploceHolderString = @"请输入活动名称";
    typeof(TSActionDemoView) __weak *weakView = demoAlertView;
    [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
        typeof(TSActionDemoView) __strong *strongView = weakView;
        [DDTJHttpRequest customActivitieWith:string block:^(NSDictionary *dict) {
            weakSelf.searchResultArr = nil;
            [weakSelf loadData];
        } failure:^{
            
        }];
        [strongView dismissAnimated:YES];
    }];
    [demoAlertView show];
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

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height {
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
