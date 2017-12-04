//
//  LSContentSortView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSContentSortView.h"
#import "LSMapContentSortCell.h"
#import "LSContentSortModel.h"
@interface LSContentSortView ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton    *btn_cancel;
@property (nonatomic, strong)UIButton    *btn_confirm;
@property (nonatomic, strong)NSMutableArray<LSContentSortModel*> *label_array;
@end
@implementation LSContentSortView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.label_array = [NSMutableArray new];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = kBgWhiteGrayColor;
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(_btn_confirm.mas_top);
    }];
    
    NSArray *labelArr = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr1 = @[@"KTV",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr2 = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"水吧",@"俱乐部",@"茶馆"];
    NSArray *labelArr3 = @[@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会"];
    
    [_label_array addObject:[[LSContentSortModel alloc] initWithArray:labelArr]];
    [_label_array addObject:[[LSContentSortModel alloc] initWithArray:labelArr1]];
    [_label_array addObject:[[LSContentSortModel alloc] initWithArray:labelArr2]];
    [_label_array addObject:[[LSContentSortModel alloc] initWithArray:labelArr3]];
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.label_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"cellID%ld%ld",indexPath.section,indexPath.row];
    LSMapContentSortCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LSMapContentSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_label_array) {
            cell.entity = _label_array[indexPath.row];
        }
    }

    cell.showMoreBlock = ^(UITableViewCell *currentCell){
        NSIndexPath *indexRow = [_tableView indexPathForCell:currentCell];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSContentSortModel *entity = nil;
    if ([self.label_array count] > indexPath.row) {
        entity = [self.label_array objectAtIndex:indexPath.row];
    }
    if (entity.isShowMore) {
        return [LSMapContentSortCell cellMoreHeight:entity];
    } else {
        return [LSMapContentSortCell cellDefaultHeight:entity];
    }
    return 0;
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
@end
