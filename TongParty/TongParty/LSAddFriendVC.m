//
//  LSAddFriendVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSAddFriendVC.h"
#import "LSAddContactsFriendVC.h"
#import "LSContactsEntity.h"
#import "LSAddContactsCell.h"
@interface LSAddFriendVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)UIView       *view_searchBar;  // 手机搜索好友
@property (nonatomic, strong)NSArray      *contactsArr;
@property (nonatomic, strong)LSAddContactsFriendVC  *contactsVC;
@end
static NSString *addCell = @"LSAddContactsCell";
@implementation LSAddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    [self navigationWithTitle:@"添加好友"];
    [self.view addSubview:self.view_searchBar];
    [self.view addSubview:self.tableView];
}

- (UIView *)view_searchBar {
    if (!_view_searchBar) {
        _view_searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, DDFitHeight(50.f))];
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
        UIImage* searchBarBg = [self GetImageWithColor:kBgWhiteGrayColor andHeight:DDFitHeight(50.f)];
        [search setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        [search setBackgroundImage:searchBarBg];
        [search setBackgroundColor:[UIColor clearColor]];
        search.placeholder = @"搜索对方手机号码";
        search.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _view_searchBar;
}
static NSString *commonCell = @"commonCell";
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _view_searchBar.bottom + 1, kScreenWidth, kScreenHeight - _view_searchBar.bottom - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kBgWhiteGrayColor;
        [_tableView registerNib:[UINib nibWithNibName:@"LSAddContactsCell" bundle:nil]
         forCellReuseIdentifier:addCell];
        [_tableView registerNib:[UINib nibWithNibName:@"LSFriendCommonCell" bundle:nil] forCellReuseIdentifier:commonCell];
    }
    return _tableView;
}

#pragma mark - tableview delegate && datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_contactsArr) {
        return 1;
    }
    return _contactsArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_contactsArr) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCell];
        return cell;
    } else {
        
        LSAddContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:addCell];
        cell.lbl_line.hidden = YES;
        LSContactsEntity *entity = _contactsArr[indexPath.row];
        cell.btn_add.tag = [entity.id integerValue];
        if ([entity.is_friend integerValue] == 1) {
            // 已经是好友
            [cell.btn_add setTitle:@"跟随" forState:UIControlStateNormal];
            [cell.btn_add addTarget:self action:@selector(followFriend:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            // 尚未成为好友
           [cell.btn_add addTarget:self action:@selector(addContacts:) forControlEvents:UIControlEventTouchUpInside];
        }
        [cell updateValueWith:entity];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(50.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!_contactsArr) {
        
        [self.navigationController pushViewController:self.contactsVC animated:YES];
    }
}

- (LSAddContactsFriendVC *)contactsVC {
    if (!_contactsVC) {
        _contactsVC = [[LSAddContactsFriendVC alloc] init];
    }
    return _contactsVC;
}

// 跟随
- (void)followFriend:(UIButton *)sender {
    
}

// 添加
- (void)addContacts:(UIButton *)sender {
    NSString *tagString = [NSString stringWithFormat:@"%ld",sender.tag];
    [DDTJHttpRequest addFriendsToListWithToken:[DDUserSingleton shareInstance].token fid:tagString  block:^(NSDictionary *dict) {
        [self pop];
    } failure:^{
        
    }];
}


#pragma mark - 搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 11) {
        NSString *phone = [NSString stringWithFormat:@"%@,",searchText];
        [DDTJHttpRequest getContactsListWithToken:[DDUserSingleton shareInstance].token phone:phone block:^(NSDictionary *dict) {
            _contactsArr = [LSContactsEntity mj_objectArrayWithKeyValuesArray:dict[@"have"]];
            [_tableView reloadData];
        } failure:^{
            
        }];
    }
    if (searchText.length == 0) {
        _contactsArr = nil;
        [_tableView reloadData];
    }
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
}
@end
