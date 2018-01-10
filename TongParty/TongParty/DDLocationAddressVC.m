
//
//  DDLocationAddressVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLocationAddressVC.h"
#import "LSPoiSearchSuggestionVc.h"

@interface DDLocationAddressVC ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate> {
    CGFloat _oldY;
    CLLocationCoordinate2D oldCoordinate;
}
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView      *view_searchBar;
@property (nonatomic, strong) UIButton    *btn_backLocal;
@property (nonatomic, strong) UIImageView *iv_mapMark;
@property (nonatomic, strong) LSPoiSearchSuggestionVc *suggestionsVc;
@end

@implementation DDLocationAddressVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    [self navigationWithTitle:@"选择地点"];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.iv_mapMark];
    // 回归当前位置按钮
    _btn_backLocal = [UIButton new];
    [self.mapView addSubview:_btn_backLocal];
    [_btn_backLocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(DDFitHeight(35.f));
        make.bottom.equalTo(_mapView).offset(-DDFitHeight(10.f));
        make.right.equalTo(_mapView).offset(-DDFitHeight(10.f));
    }];
    [_btn_backLocal setBackgroundImage:kImage(@"back_userLocation") forState:UIControlStateNormal];
    [_btn_backLocal addTarget:self action:@selector(backLocal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.view_searchBar];
    //[self addChildVc:self.suggestionsVc];
}

- (MAMapView *)mapView {
    if (!_mapView) {
        //添加地图视图
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.view_searchBar.bottom, kScreenWidth, self.view.height/2.5f)];
        _mapView.delegate = self;
        _mapView.showsCompass = NO;
        _mapView.zoomLevel  = 17.5f;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsAccuracyRing = NO;
        r.locationDotBgColor = kWhiteColor;
        [_mapView updateUserLocationRepresentation:r];
        _mapView.rotateEnabled = NO;
        _mapView.rotateCameraEnabled = NO;
    }
    return _mapView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mapView.bottom - self.view_searchBar.bottom, kScreenWidth, self.view.height - self.mapView.bottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)view_searchBar {
    if (!_view_searchBar) {
        _view_searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DDFitHeight(45.f))];
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
        search.placeholder = @"搜索地点";
        UIView *view_tap = [[UIView alloc] initWithFrame:_view_searchBar.bounds];
        [_view_searchBar addSubview:view_tap];
        [view_tap addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyWorkSearchPois:)]];
    }
    return _view_searchBar;
}

- (UIImageView *)iv_mapMark {
    if (!_iv_mapMark) {
        _iv_mapMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(15.f), DDFitHeight(30.f))];
        _iv_mapMark.center = self.mapView.center;
        _iv_mapMark.image = kImage(@"map_mark");
    }
    return _iv_mapMark;
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

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (LSPoiSearchSuggestionVc *)suggestionsVc {
    WeakSelf(weakSelf);
    if (!_suggestionsVc) {
        _suggestionsVc = [[LSPoiSearchSuggestionVc alloc] init];
        _suggestionsVc.view.frame = CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight);
        _suggestionsVc.suggestionResultBlock = ^(AMapTip *tip) {
            AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
            request.keywords            = tip.name;
            request.sortrule            = 0;
            request.requireExtension    = YES;
            [MBProgressHUD showLoading:nil toView:weakSelf.tableView];
            [weakSelf.search AMapPOIAroundSearch:request];
            weakSelf.mapView.centerCoordinate = CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
        };
    }
    return _suggestionsVc;
}


- (void)keyWorkSearchPois:(UITapGestureRecognizer *)tap {
    [self presentVc:self.suggestionsVc completion:nil];
}



- (void)searchPOIWith:(CLLocationCoordinate2D)coordinate {

    oldCoordinate = coordinate;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //    request.keywords            = @"电影院";
    //request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [MBProgressHUD showLoading:nil toView:self.tableView];
    [self.search AMapPOIAroundSearch:request];
}

//- (void)initSearch{
//
//    if (_currentLocation == nil || _search == nil) {
//        return;
//    }
//
//}


//发起逆地理编码请求
- (void)initAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

#pragma mark - mapView delegate
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // 根据屏幕位置转换地图坐标经纬度
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:_iv_mapMark.frame.origin toCoordinateFromView:self.mapView];
    double distance = [self distanceBetweenOrderBy:markCoordinate.latitude :oldCoordinate.latitude :markCoordinate.longitude :oldCoordinate.longitude];
    if (distance > 300) {
        [self searchPOIWith:markCoordinate];
    }
}

//地图上点击当前位置出现的标题副标题
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSString *str1 = response.regeocode.addressComponent.city;
    if (str1.length == 0) {
        str1 = response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title = str1;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}

//实时获得用户的经纬度
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    _currentLocation = [userLocation.location copy];
    // 初次获取位置 执行一次即可
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self searchPOIWith:CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude)];
    });
    
}

//当点击定位annotion时进行逆地理编程进行编码查询
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }
}

/** POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0)
    {
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    self.dataArray = [NSMutableArray arrayWithArray:response.pois];
    [MBProgressHUD hideAllHUDsInView:self.tableView];
    // 周边搜索完成后，刷新tableview
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DDFitHeight(60.f);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellId];
    }
    AMapPOI *poi = _dataArray[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@%@",poi.province,poi.city,poi.district,poi.address];
    return cell;
}

//点击回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_locationAddressSelectBlcok) {
        _locationAddressSelectBlcok(_dataArray[indexPath.row]);
    }
    [self pop];
}

- (void)backLocal:(UIButton *)sender {
    [self.mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual: self.tableView]) {
        if (self.tableView.contentOffset.y > _oldY) {
            [UIView animateWithDuration: 0.25 delay: 0 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
                _mapView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height/2.5f);
                 _tableView.frame = CGRectMake(0, self.mapView.bottom - self.view_searchBar.bottom, kScreenWidth, self.view.height - self.mapView.bottom + self.view_searchBar.bottom);
                _iv_mapMark.center = self.mapView.center;
            } completion: ^(BOOL finished) {
                
            }];
        }
        else{
            if (scrollView.contentOffset.y > 0) {
                //滑到顶部更新
                return;
            }
            [UIView animateWithDuration: 0.25 delay: 0 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
                _mapView.frame = CGRectMake(0, self.view_searchBar.bottom, kScreenWidth, self.view.height/2.5f);
                _tableView.frame = CGRectMake(0, self.mapView.bottom, kScreenWidth, self.view.height - self.mapView.bottom);
                _iv_mapMark.center = self.mapView.center;
            } completion: ^(BOOL finished) {
                
            }];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = self.tableView.contentOffset.y;
}


// 计算两坐标点之间的距离
-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}

- (float)radians:(float)degrees{
    return (degrees*3.14159265)/180.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













