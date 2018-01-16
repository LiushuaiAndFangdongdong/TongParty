//
//  LSRegionDumpsView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRegionDumpsView.h"
#import "LSSubwayEntity.h"
#import "LSAdmRegionEntity.h"
#import "LSRangeEntity.h"
@interface LSRegionDumpsView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *father_tableView;
@property (nonatomic, strong)UITableView *child_tableView;
@property (nonatomic, strong)UIButton    *btn_region;
@property (nonatomic, strong)UIButton    *btn_subway;
@property (nonatomic, strong)UIImageView *iv_region;
@property (nonatomic, strong)UIImageView *iv_subway;
@property (nonatomic, strong)NSArray     *area_array; // 商圈区域数据
@property (nonatomic, strong)NSArray     *region_array; // 商圈数据
@property (nonatomic, strong)NSArray     *circles_array; // 商圈数据
//@property (nonatomic, strong)NSArray     *nearly_array; // 附近数据
@end

@implementation LSRegionDumpsView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.btn_region];
    [_btn_region mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    [_btn_region addTarget:self action:@selector(regionDump:) forControlEvents:UIControlEventTouchUpInside];
    _iv_region = [UIImageView new];
    [_btn_region addSubview:_iv_region];
    [_iv_region mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btn_region.mas_centerX).offset(-DDFitWidth(25.f));
        make.centerY.equalTo(_btn_region);
        make.height.width.mas_equalTo(DDFitHeight(20.f));
        make.width.mas_equalTo(DDFitHeight(25.f));
    }];
    _iv_region.image = kImage(@"region_selected");
    
    [self addSubview:self.btn_subway];
    [_btn_subway mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    [_btn_subway addTarget:self action:@selector(subway:) forControlEvents:UIControlEventTouchUpInside];
    _iv_subway = [UIImageView new];
    [_btn_subway addSubview:_iv_subway];
    [_iv_subway mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btn_subway.mas_centerX).offset(-DDFitWidth(25.f));
        make.centerY.equalTo(_btn_region);
        make.height.width.mas_equalTo(DDFitHeight(18.f));
    }];
    _iv_subway.image = kImage(@"subway_normal");
    
    _father_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _father_tableView.delegate = self;
    _father_tableView.dataSource = self;
    _father_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _father_tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.father_tableView];
    [_father_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(_btn_region.mas_bottom);
        make.width.equalTo(_btn_region).multipliedBy(0.75f);
    }];
    
    _child_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _child_tableView.delegate = self;
    _child_tableView.dataSource = self;
    _child_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _child_tableView.showsVerticalScrollIndicator = NO;
    _child_tableView.backgroundColor = kBgWhiteGrayColor;
    [self addSubview:self.child_tableView];
    [_child_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(_father_tableView.mas_right);
        make.top.equalTo(_father_tableView);
    }];
    
}


#pragma mark - 懒加载
//- (UITableView *)fahter_tableView {
//
//    if (!_father_tableView) {
//        _father_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _father_tableView.delegate = self;
//        _father_tableView.dataSource = self;
//    }
//    return _father_tableView;
//}
//
//- (UITableView *)child_tableView {
//
//    if (!_child_tableView) {
//        _child_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _child_tableView.delegate = self;
//        _child_tableView.dataSource = self;
//    }
//    return _child_tableView;
//}

- (UIButton *)btn_region {
    if (!_btn_region) {
        _btn_region = [UIButton new];
        [_btn_region setTitle:@"商圈" forState:UIControlStateNormal];
        [_btn_region setTitleColor:kBlackColor forState:UIControlStateNormal];
        _btn_region.titleLabel.font = DDFitFont(15.f);
        
        
    }
    return _btn_region;
}

- (UIButton *)btn_subway {
    if (!_btn_subway) {
        _btn_subway = [UIButton new];
        [_btn_subway setTitle:@"地铁" forState:UIControlStateNormal];
        [_btn_subway setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        _btn_subway.titleLabel.font = DDFitFont(15.f);
    }
    return _btn_subway;
}

#pragma mark - action

- (void)regionDump:(UIButton *)sender {
    [_btn_subway setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    [_btn_region setTitleColor:kBlackColor forState:UIControlStateNormal];
    _iv_subway.image = kImage(@"subway_normal");
    _iv_region.image = kImage(@"region_selected");
    if (!_regionArray) {
        if (_switchToRefionDumps) {
            _switchToRefionDumps();
        }
    } else {
        self.dataArray = _regionArray;
    }
}

- (void)subway:(UIButton *)sender {
    [_btn_region setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    [_btn_subway setTitleColor:kBlackColor forState:UIControlStateNormal];
    _iv_subway.image = kImage(@"subway_selected");
    _iv_region.image = kImage(@"region_normal");
    if (!_subwayArray) {
        if (_switchToSubway) {
            _switchToSubway();
        }
    } else {
        self.dataArray = _subwayArray;
    }

}


#pragma mark - UITableView Delegate && Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.father_tableView) {
        return self.area_array.count + 1;
    }
    if (tableView == self.child_tableView) {

        if (_circles_array) {
            return _circles_array.count;
        } else {
//            id entity = self.area_array[0];
//            if ([entity isKindOfClass:[LSSubwayEntity class]]) {
//                LSSubwayEntity *sEntity = (LSSubwayEntity *)entity;
//                _circles_array = [LSSubwayEntity mj_objectArrayWithKeyValuesArray:sEntity.children];
//            }
//            if ([entity isKindOfClass:[LSAdmRegionEntity class]]) {
//                LSAdmRegionEntity *aEntity = (LSAdmRegionEntity *)entity;
//                _circles_array = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:aEntity.children];
//            }
            NSArray *arr = @[@"500",@"1000",@"2000",@"5000"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (int i = 0; i < arr.count; i++) {
                LSRangeEntity *entity = [LSRangeEntity new];
                entity.distance = arr[i];
                [mArr addObject:entity];
            }
            self.circles_array = [NSArray arrayWithArray:mArr];
            return self.circles_array.count;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(55.f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && tableView == self.father_tableView) {
        static NSString *fatherCellID = @"fatherCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fatherCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fatherCellID];
        }
        cell.textLabel.text = @"附近";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kCommonGrayTextColor;
        return cell;
    }
    if (tableView == self.father_tableView) {
        static NSString *fatherCellID = @"fatherCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fatherCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fatherCellID];
        }
        id entity = self.area_array[indexPath.row - 1];
        if ([entity isKindOfClass:[LSSubwayEntity class]]) {
            LSSubwayEntity *sEntity = (LSSubwayEntity *)entity;
            cell.textLabel.text = sEntity.name;
        }
        if ([entity isKindOfClass:[LSAdmRegionEntity class]]) {
            LSAdmRegionEntity *aEntity = (LSAdmRegionEntity *)entity;
            cell.textLabel.text = aEntity.name;
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kCommonGrayTextColor;
        return cell;
    }
    if (tableView == self.child_tableView) {
        static NSString *childCellID = @"childCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:childCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:childCellID];
        }
        id entity = self.circles_array[indexPath.row];
        if ([entity isKindOfClass:[LSRangeEntity class]]) {
            LSRangeEntity *rEntity = (LSRangeEntity *)entity;
            cell.textLabel.text = [NSString stringWithFormat:@"%@米",rEntity.distance];
        }
        if ([entity isKindOfClass:[LSSubwayEntity class]]) {
            LSSubwayEntity *sEntity = (LSSubwayEntity *)entity;
            cell.textLabel.text = sEntity.name;
        }
        if ([entity isKindOfClass:[LSAdmRegionEntity class]]) {
            LSAdmRegionEntity *aEntity = (LSAdmRegionEntity *)entity;
            cell.textLabel.text = aEntity.name;
        }
        cell.contentView.backgroundColor = kBgWhiteGrayColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kCommonGrayTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.father_tableView) {
        if (indexPath.row == 0) {
            NSArray *arr = @[@"500",@"1000",@"2000",@"5000"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (int i = 0; i < arr.count; i++) {
                LSRangeEntity *entity = [LSRangeEntity new];
                entity.distance = arr[i];
                [mArr addObject:entity];
            }
            self.circles_array = [NSArray arrayWithArray:mArr];
            [_child_tableView reloadData];
            return;
        }
        
        for (NSIndexPath* i in [tableView indexPathsForVisibleRows]) {
            UITableViewCell *unSelectedCell = [tableView cellForRowAtIndexPath:i];
            unSelectedCell.textLabel.textColor = kCommonGrayTextColor;
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self updateChildTableViewDataWithAreaString:self.area_array[indexPath.row - 1]];
        cell.textLabel.textColor = kBlackColor;
    }
    if (tableView == self.child_tableView) {
        
        id entity = self.circles_array[indexPath.row];
        if ([entity isKindOfClass:[LSRangeEntity class]]) {
            LSRangeEntity *rEntity = (LSRangeEntity *)entity;
            if (_onSelectedRange) {
                _onSelectedRange(rEntity.distance);
            }
        }
        if ([entity isKindOfClass:[LSSubwayEntity class]]) {
            LSSubwayEntity *sEntity = (LSSubwayEntity *)entity;
            if (_onSelected) {
                _onSelected(sEntity.latitude,sEntity.longitude);
            }
        }
        if ([entity isKindOfClass:[LSAdmRegionEntity class]]) {
            LSAdmRegionEntity *aEntity = (LSAdmRegionEntity *)entity;
            if (_onSelected) {
                _onSelected(aEntity.latitude,aEntity.longitude);
            }
        }
    }
}

- (void)updateChildTableViewDataWithAreaString:(id)entity {
    if ([entity isKindOfClass:[LSSubwayEntity class]]) {
        LSSubwayEntity *e = (LSSubwayEntity *)entity;
        _circles_array = [LSSubwayEntity mj_objectArrayWithKeyValuesArray:e.children];
    }
    if ([entity isKindOfClass:[LSAdmRegionEntity class]]) {
        LSAdmRegionEntity *e = (LSAdmRegionEntity *)entity;
        _circles_array = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:e.children];
    }
    [_child_tableView reloadData];
}

//- (NSArray *)area_array {
//    if (![[DDUserSingleton shareInstance].city isEqualToString:[DDUserDefault objectForKey:@"currentCity"]] && [DDUserSingleton shareInstance].city && ![[DDUserSingleton shareInstance].city isEqualToString:@""]) {
//        _area_array = nil;
//        [DDUserDefault setObject:[DDUserSingleton shareInstance].city forKey:@"currentCity"];
//    }
//    if (!_area_array) {
//        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region_dumps" ofType:@"json"]];
//        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//        NSMutableArray *newArray = [NSMutableArray array];
//        for (NSDictionary *dict in dataArray) {
//            NSArray *citiesArray = dict[@"cities"];
//            if (citiesArray.count > 0 ) {
//                NSDictionary *citiesDict = citiesArray[0];
//                NSString *cityString = [NSString string];
//                if (![[DDUserSingleton shareInstance].city isEqualToString:@""] && [DDUserSingleton shareInstance].city) {
//                    cityString = citiesDict[@"name"];
//                } else if ([DDUserDefault objectForKey:@"currentCity"]) {
//                    cityString = [DDUserDefault objectForKey:@"currentCity"];
//                } else {
//                    // 在数据为空的时候，设置默认当前城市
//                    cityString = @"北京市";
//                }
//                if ([cityString isEqualToString:citiesDict[@"name"]]) {
//                    NSArray *countiesArray = citiesDict[@"counties"];
//                    for (NSDictionary *areaDic in countiesArray) {
//                        [newArray addObject:areaDic[@"name"]];
//                        [self.region_array addObject:areaDic];
//                    }
//                }
//            }
//        }
//        _area_array = newArray;
//    }
//    return _area_array;
//}

//- (NSMutableArray *)region_array {
//    if (!_region_array) {
//        _region_array = [NSMutableArray new];
//    }
//    return _region_array;
//}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    self.area_array = dataArray;
    self.circles_array = nil;
    [self.father_tableView reloadData];
    [self.child_tableView reloadData];
}

@end
