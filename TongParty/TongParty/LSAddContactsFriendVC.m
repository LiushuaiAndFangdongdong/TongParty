//
//  LSAddContactsFriendVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSAddContactsFriendVC.h"
#import "LSContactsEntity.h"
#import "LSAddContactsCell.h"
#import "LSInviteContactsCell.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import "LXAlertView.h"
@interface LSAddContactsFriendVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)UIView       *view_searchBar;
@property (nonatomic, strong)NSMutableArray      *contactsArr;
@property (nonatomic, strong)NSMutableArray      *inviteArr;
@property (nonatomic, strong)NSArray      *oldContactsArr;
@property (nonatomic, strong)NSArray      *oldInviteArr;
@property (nonatomic, strong)UILocalizedIndexedCollation *collation;
@end
static NSString *addCell = @"LSAddContactsCell";
static NSString *inviteCell = @"LSInviteContactsCell";
@implementation LSAddContactsFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAddressBookClick];
    [self setupViews];
}


- (void)setupViews {
    [self navigationWithTitle:@"添加通讯录好友"];
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _view_searchBar.bottom + 1, kScreenWidth, kScreenHeight - _view_searchBar.bottom - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kBgWhiteGrayColor;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.sectionIndexColor = kCommonGrayTextColor;
        [_tableView registerNib:[UINib nibWithNibName:@"LSAddContactsCell" bundle:nil]
         forCellReuseIdentifier:addCell];
        [_tableView registerNib:[UINib nibWithNibName:@"LSInviteContactsCell" bundle:nil]
         forCellReuseIdentifier:inviteCell];
        
    }
    return _tableView;
}

#pragma mark - tableview delegate && datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _contactsArr.count;
    } else {
        return [_inviteArr[section - 1] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.inviteArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LSAddContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:addCell];
        if (indexPath.row == _contactsArr.count - 1) {
            // 消除最后单元格分割线
            cell.lbl_line.hidden = YES;
        }
        LSContactsEntity *entity = _contactsArr[indexPath.row];
        cell.btn_add.tag = [entity.id integerValue];
        [cell.btn_add addTarget:self action:@selector(addContacts:) forControlEvents:UIControlEventTouchUpInside];
        [cell updateValueWith:_contactsArr[indexPath.row]];
        return cell;
    } else {
        LSInviteContactsCell *icell = [tableView dequeueReusableCellWithIdentifier:inviteCell];
        if (indexPath.row == [_inviteArr[indexPath.section - 1] count] - 1) {
            // 消除最后单元格分割线
            icell.lbl_line.hidden = YES;
        }
        icell.selectionStyle = UITableViewCellSelectionStyleNone;
        LSContactsEntity *entity = _inviteArr[indexPath.section - 1][indexPath.row];
        icell.btn_invite.tag = [entity.mobile integerValue];
        [icell.btn_invite addTarget:self action:@selector(inviteContacts:) forControlEvents:UIControlEventTouchUpInside];
        [icell updateValueWith:_inviteArr[indexPath.section - 1][indexPath.row]];
        return icell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(60.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || [_inviteArr[section - 1] count] <= 0 || !_inviteArr[section - 1]) {
        return 0.000001;
    }
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001; 
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        NSArray *UserObjsInSection = [_inviteArr objectAtIndex:section - 1];
        if(UserObjsInSection == nil || [UserObjsInSection count] <= 0) {
            return nil;
        }
        return [[_collation sectionTitles] objectAtIndex:section - 1];
    }
    return NULL;
}

//索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_collation sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - 搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_contactsArr removeAllObjects];
    [_inviteArr removeAllObjects];

    for (LSContactsEntity *model in _oldContactsArr) {
        if ([model.mobile hasPrefix:searchText]) {
            [_contactsArr addObject:model];
        }
    }
    
    for (NSArray *ar in _oldInviteArr) {
        NSMutableArray *modelarr = [NSMutableArray array];
        for (LSContactsEntity *model in ar) {
            if ([model.mobile hasPrefix:searchText]) {
                [modelarr addObject:model];
            }
        }
        [_inviteArr addObject:modelarr];
    }
    
    if ((_contactsArr.count == 0 && _inviteArr.count == 0 )||  searchText.length == 0) {
        _contactsArr = [[NSMutableArray alloc] initWithArray:_oldContactsArr];
        _inviteArr = [[NSMutableArray alloc] initWithArray:_oldInviteArr];
    }

    NSLog(@"%@",searchText);

    [_tableView reloadData];
}

#pragma mark - 通讯录数据
// 添加通讯录好友
- (void)addContacts:(UIButton *)sender {
    NSString *tagString = [NSString stringWithFormat:@"%ld",sender.tag];
    [DDTJHttpRequest addFriendsToListWithToken:[DDUserSingleton shareInstance].token fid:tagString  block:^(NSDictionary *dict) {
        [self getAddressBookClick];
    } failure:^{
        
    }];
}

// 邀请通讯录好友
- (void)inviteContacts:(UIButton *)sender {
    NSString *tagString = [NSString stringWithFormat:@"%ld",sender.tag];
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[tagString];
        controller.body = @"我在桐聚等你哦！";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark 发短信代理
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
    NSString *statusString = [NSString string];
    if (result == MessageComposeResultCancelled) {
        statusString = @"取消";
    } else if (result == MessageComposeResultSent){
        statusString = @"成功";
    } else {
        statusString = @"失败";
    }
    if (result != MessageComposeResultCancelled) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"发送消息" message:statusString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"知道了！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// 颜色转图片
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

- (void)getAddressBookClick{
    __block NSString *phonesString = [NSString string];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (!error) {
                if (granted) {//允许
                    NSArray *contacts = [self fetchContactWithAddressBook:addressBook];
                    for (NSDictionary *contactDic in contacts) {
                        phonesString = [NSString stringWithFormat:@"%@,",contactDic[@"phoneNumber"]];
                    }
                    [DDTJHttpRequest getContactsListWithToken:[DDUserSingleton shareInstance].token phone:phonesString block:^(NSDictionary *dict) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                        });
                    } failure:^{
                        
                    }];

                }else{//拒绝
                    NSLog(@"拒绝");
                }
            }else{
                NSLog(@"错误!");
            }
        });
    }else{
        NSMutableString *string = [NSMutableString string];
        NSArray *contacts = [self fetchContactWithAddressBook:addressBook];
        for (NSDictionary *contactDic in contacts) {
            NSString *lenStr = contactDic[@"phoneNumber"];
            if ([self validatePhoneWithPhone:lenStr]) {
                [string appendFormat:@"%@,",contactDic[@"phoneNumber"]];
            }
        }
        [self showLoadingAnimation];
        [DDTJHttpRequest getContactsListWithToken:[DDUserSingleton shareInstance].token phone:string block:^(NSDictionary *dict) {
            dispatch_queue_t queue= dispatch_queue_create("userDetailinfo", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                self.contactsArr = [NSMutableArray array];
                NSMutableArray *arr = [NSMutableArray array];
                NSArray *ar = dict[@"nohave"];
                for (NSNumber *phoneNum in ar) {
                    for (NSDictionary *contactDic in contacts) {
                        if ([phoneNum.stringValue isEqualToString:contactDic[@"phoneNumber"]]) {
                            LSContactsEntity *entity = [LSContactsEntity new];
                            entity.name = contactDic[@"name"];
                            entity.mobile = contactDic[@"phoneNumber"];
                            [arr addObject:entity];
                        }
                    }
                }
                NSArray *contactsArray = [LSContactsEntity mj_objectArrayWithKeyValuesArray:dict[@"have"]];
                // 过滤好友
                for (LSContactsEntity *nowEntity in contactsArray) {
                    if ([nowEntity.is_friend integerValue] == 0) {
                        [self.contactsArr addObject:nowEntity];
                    }
                }
                self.inviteArr = [self sortObjectsAccordingToInitialWith:arr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 将全部数据存储起来，用于搜索恢复
                    _oldInviteArr = [NSArray arrayWithArray:self.inviteArr];
                    _oldContactsArr = [NSArray arrayWithArray:self.contactsArr];
                    [self hideLoadingAnimation];
                    [self.tableView reloadData];
                });
            });
        } failure:^{
            
        }];
    }
    
}

- (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        NSArray *array = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            ABRecordRef people = CFArrayGetValueAtIndex((__bridge ABRecordRef)array, i);
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            NSString *allName;
            if ([self checkStringIsNull:lastName] && [self checkStringIsNull:firstName]) {
                allName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
            } else if([self checkStringIsNull:firstName]){
                allName = firstName;
            } else if ([self checkStringIsNull:lastName]){
                allName = lastName;
            } else {
                allName = @"";
            }
            
            ABMutableMultiValueRef phoneNumRef = ABRecordCopyValue(people, kABPersonPhoneProperty);
            NSString *phoneNumber =  ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumRef)).lastObject;
            NSString *phone;
            if ([self checkStringIsNull:phoneNumber]) {
                phone = phoneNumber;
            } else {
                phone = @"";
            }
            NSString *userPhone1 = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSString *userPhone2 = [userPhone1 stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            NSString *userPhone3 = [userPhone2 stringByReplacingOccurrencesOfString:@" " withString:@""];
            [contacts addObject:@{@"name": allName, @"phoneNumber": userPhone3}];
        }
        return contacts;
    }else{
        UIAlertView * positioningAlertivew = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                                       message:@"请您设置允许桐聚访问您的通讯录\n设置-隐私-通讯录"
                                                                      delegate:self
                                                             cancelButtonTitle:@"取消"
                                                             otherButtonTitles:@"设置",nil];
        [positioningAlertivew show];
        return nil;
    }
}

- (BOOL)validatePhoneWithPhone:(NSString *)phone {
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11) {
        return NO;
    } else {
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (BOOL)checkStringIsNull:(NSString *)nullString {
    if (nullString && ![nullString isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {

    } else if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
    }
}

// 按首字母分组排序数组
-(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr {
    
    self.collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger sectionTitlesCount = [[self.collation sectionTitles] count];
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    for (LSContactsEntity *personModel in arr) {
        NSInteger sectionNumber = [self.collation sectionForObject:personModel collationStringSelector:@selector(name)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:personModel];
    }
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [self.collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    return newSectionsArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
