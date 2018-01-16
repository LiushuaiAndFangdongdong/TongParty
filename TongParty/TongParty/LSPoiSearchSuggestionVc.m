//
//  LSPoiSearchSuggestionVc.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSPoiSearchSuggestionVc.h"
#import "LSDateSortCell.h"
@interface LSPoiSearchSuggestionVc ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong)UIView *view_search;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSArray      *suggestionsArray;
@end

@implementation LSPoiSearchSuggestionVc

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self view_search];
    UIView *bg_view = [UIView new];
    [self.view_search addSubview:bg_view];
    [bg_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view_search.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    bg_view.backgroundColor = kBlackColor;
    bg_view.alpha = 0.5f;
    [self.view addSubview:self.tv_suggestions];
    self.view.backgroundColor = kWhiteColor;
}

- (UIView *)view_search {
    if (!_view_search) {
        _view_search = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, self.view.width, kNavigationBarHeight)];
        _view_search.backgroundColor = kWhiteColor;
        [self.view addSubview:self.view_search];
        UIButton *btn_cacnel = [UIButton new];
        [_view_search addSubview:btn_cacnel];
        [btn_cacnel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view_search);
            make.right.mas_equalTo(DDFitHeight(-5.f));
            make.height.mas_equalTo(DDFitHeight(30.f));
            make.width.mas_equalTo(DDFitWidth(50.f));
        }];
        [btn_cacnel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn_cacnel setTitle:@"取消" forState:UIControlStateNormal];
        [btn_cacnel setTitleColor:kGreenColor forState:UIControlStateNormal];
        
        UISearchBar *searchBar = [UISearchBar new];
        [_view_search addSubview:searchBar];
        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view_search);
            make.left.mas_equalTo(DDFitWidth(10.f));
            make.height.mas_equalTo(30.f);
            make.right.equalTo(btn_cacnel.mas_left).offset(DDFitWidth(-5.f));
        }];
        searchBar.backgroundColor = kCommonGrayTextColor;
        searchBar.layer.masksToBounds = YES;
        searchBar.delegate = self;
        [searchBar.layer setBorderWidth:1];
        [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
        UIImage* searchBarBg = [self GetImageWithColor:kBgWhiteGrayColor andHeight:DDFitHeight(45.f)];
        [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        [searchBar setBackgroundImage:searchBarBg];
        [searchBar setBackgroundColor:[UIColor clearColor]];
        searchBar.layer.cornerRadius = 2.f;
        searchBar.placeholder = @"搜索地点";
    }
    return _view_search;
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

- (UITableView *)tv_suggestions {
    if (!_tv_suggestions) {
        _tv_suggestions = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view_search.bottom, self.view.width, self.view.height - self.view_search.bottom) style:UITableViewStylePlain];
        _tv_suggestions.hidden = YES;
        _tv_suggestions.delegate = self;
        _tv_suggestions.dataSource = self;
        [_tv_suggestions registerNib:[UINib nibWithNibName:@"LSDateSortCell" bundle:nil] forCellReuseIdentifier:@"LSDateSortCell"];
    }
    return _tv_suggestions;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (void)cancel:(UIButton *)sender {
//    if (_cancelOnClicked) {
//        _cancelOnClicked();
//    }
    _tv_suggestions.hidden = YES;
    [self dismiss];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - tableview delegate && datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DDFitHeight(65.f);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _suggestionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSDateSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSDateSortCell"];
    if (!cell) {
        cell = [[LSDateSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LSDateSortCell"];
    }
    AMapTip *tip = _suggestionsArray[indexPath.row];
    cell.lbl_week.text = tip.name;
    cell.lbl_date.text = [NSString stringWithFormat:@"%@%@",tip.district,tip.address];
    cell.lbl_date.font = DDFitFont(13.f);
    cell.lbl_date.textAlignment = NSTextAlignmentLeft;
    cell.lbl_week.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMapTip *tip = _suggestionsArray[indexPath.row];
    [self dismiss];
    self.tv_suggestions.hidden = YES;
    if (_suggestionResultBlock) {
        _suggestionResultBlock(tip);
    }
}

#pragma mark - 搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if ([searchText isEqualToString:@""]) {
        _tv_suggestions.hidden = YES;
    } else {
        _tv_suggestions.hidden = NO;
        AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
        tips.keywords = searchText;
        // 设置搜索范围的关键地名
        NSString *city;
        if ([DDUserSingleton shareInstance].city) {
            city = [DDUserSingleton shareInstance].city;
        } else {
            city = ![DDUserDefault objectForKey:@"current_city"] ? @"北京市" : [DDUserDefault objectForKey:@"current_city"];
        }
        tips.city = city;
        [self.search AMapInputTipsSearch:tips];
    }
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    if (response.tips.count == 0) {
        return;
    } else {
        self.suggestionsArray = response.tips;
    }
}

- (void)setSuggestionsArray:(NSArray *)suggestionsArray {
    _suggestionsArray = suggestionsArray;
    
    [self.tv_suggestions reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
