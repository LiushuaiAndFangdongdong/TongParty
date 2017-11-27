
//
//  DDLocationAddressVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLocationAddressVC.h"


@interface DDLocationAddressVC ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DDLocationAddressVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    _mapView.showsUserLocation = YES;//打开定位
    _mapView.userTrackingMode = MAUserTrackingModeFollow;//跟踪用户
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapViews];
    [self setupTableViews];
}
- (void)setupTableViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2 - kNavigationBarHeight, kScreenWidth, kScreenHeight - kScreenHeight/2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)initSearch{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    if (_currentLocation ==nil || _search == nil) {
        return;
    }
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    //    request.keywords            = @"电影院";
    request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}
- (void)initMapViews{
    //添加地图视图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    _mapView.showsCompass = NO;
    _mapView.zoomLevel  = 19;
    [self.view addSubview:_mapView];
}
//发起逆地理编码请求
- (void)initAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

//地图上点击当前位置出现的标题副标题
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"%@",response);
    NSString *str1 = response.regeocode.addressComponent.city;
    if (str1.length == 0) {
        str1 = response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title = str1;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}

//实时获得用户的经纬度
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    _currentLocation = [userLocation.location copy]; //获得经纬度
    [self initSearch];
}

//当点击定位annotion时进行逆地理编程进行编码查询
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }
}

/** POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    self.dataArray = [NSMutableArray arrayWithArray:response.pois];
    // 周边搜索完成后，刷新tableview
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













