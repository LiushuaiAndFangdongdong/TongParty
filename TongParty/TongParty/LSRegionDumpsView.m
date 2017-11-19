//
//  LSRegionDumpsView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRegionDumpsView.h"


@interface LSRegionDumpsView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *father_tableView;
@property (nonatomic, strong)UITableView *child_tableView;
@property (nonatomic, strong)UIButton    *btn_region;
@property (nonatomic, strong)UIButton    *btn_subway;
@property (nonatomic, strong)NSArray     *area_array; // 商圈区域数据
@property (nonatomic, strong)NSMutableArray  *region_array; // 商圈数据
@property (nonatomic, strong)NSArray         *circles_array; // 商圈数据

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
    
    [self addSubview:self.btn_subway];
    [_btn_subway mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
    
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
        [_btn_region setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
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




#pragma mark - UITableView Delegate && Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.father_tableView) {
        return self.area_array.count;
    }
    if (tableView == self.child_tableView) {
        if (_circles_array) {
            return _circles_array.count;
        } else {
            _circles_array = [NSArray new];
            NSDictionary *firstDic = self.region_array[0];
            _circles_array = firstDic[@"circles"];
            return _circles_array.count;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(55.f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.father_tableView) {
        static NSString *fatherCellID = @"fatherCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fatherCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fatherCellID];
        }
        cell.selectedBackgroundView.backgroundColor = kBgWhiteGrayColor;
        cell.textLabel.text = self.area_array[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kCommonGrayTextColor;
        if (indexPath.row == 0) {
            cell.selected = YES;
        }
        return cell;
    }
    if (tableView == self.child_tableView) {
        static NSString *childCellID = @"childCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:childCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:childCellID];
        }
        cell.contentView.backgroundColor = kBgWhiteGrayColor;
        NSDictionary *circlesDic = _circles_array[indexPath.row];
        cell.textLabel.text = circlesDic[@"name"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kCommonGrayTextColor;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.father_tableView) {
        for (NSIndexPath* i in [tableView indexPathsForVisibleRows]) {
            UITableViewCell *unSelectedCell = [tableView cellForRowAtIndexPath:i];
            unSelectedCell.textLabel.textColor = kCommonGrayTextColor;
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self updateChildTableViewDataWithAreaString:self.area_array[indexPath.row]];
        cell.textLabel.textColor = kBlackColor;
    }
    if (tableView == self.child_tableView) {
        if (_onSelected) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            _onSelected(cell.textLabel.text);
        }
    }
}

- (void)updateChildTableViewDataWithAreaString:(NSString *)areaString {
    _circles_array = [NSArray new];
    for (NSDictionary *circlesDic in _region_array) {
        if ([areaString isEqualToString:circlesDic[@"name"]]) {
            _circles_array = circlesDic[@"circles"];
        }
    }
    [_child_tableView reloadData];
}

- (NSArray *)area_array {
    if (!_area_array) {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region_dumps" ofType:@"json"]];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            NSArray *citiesArray = dict[@"cities"];
             if (citiesArray.count > 0 ) {
                 NSDictionary *citiesDict = citiesArray[0];
                 if ([[DDUserSingleton shareInstance].city isEqualToString:citiesDict[@"name"]] ||
                     [[DDUserDefault objectForKey:@"currentCity"] isEqualToString:citiesDict[@"name"]]) {
                     NSArray *countiesArray = citiesDict[@"counties"];
                         for (NSDictionary *areaDic in countiesArray) {
                             [newArray addObject:areaDic[@"name"]];
                             [self.region_array addObject:areaDic];
                         }
                 }
             }
        }
        _area_array = newArray;
    }
    return _area_array;
}

- (NSMutableArray *)region_array {
    if (!_region_array) {
        _region_array = [NSMutableArray new];
    }
    return _region_array;
}

@end
