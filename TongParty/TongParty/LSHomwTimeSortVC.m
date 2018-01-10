//
//  LSHomwTimeSortVC.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSHomwTimeSortVC.h"
#import "LSDateSortCell.h"
#import "LSTimeSortTableViewCell.h"
@interface LSHomwTimeSortVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tv_Date;
@property (nonatomic, strong)UITableView *tv_Time;
@property (nonatomic, strong)NSArray     *time_arr;
@property (nonatomic, strong)NSMutableArray     *date_arr;
@property (nonatomic,   copy)NSString *dateStr;
@end
static NSString *cellId = @"cellId";
static NSString *dcellId = @"dcellId";
@implementation LSHomwTimeSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    self.date_arr = [NSMutableArray array];
    for (int i = 0; i < 7; i ++) {
        NSDate *date = [NSDate dateWithTimeInterval:(60 * 60 * 24 * i) sinceDate:[NSDate date]];
        [self.date_arr addObject:date];
    }
    self.time_arr = @[@"上午8:00～11:30",@"午休12:00～14:00",@"下午茶14:30～16:30",@"晚餐17:00～20:30",@"夜生活21:00～次日凌晨"];
    [self.tv_Time reloadData];
}

- (void)setupViews {
    self.view.backgroundColor = kWhiteColor;
    self.tv_Date = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tv_Date];
    [self.tv_Date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.4f);
        make.bottom.equalTo(self.view).offset(-DDFitHeight(150.f));
    }];
    self.tv_Date.delegate = self;
    self.tv_Date.dataSource = self;
    self.tv_Date.backgroundColor = kWhiteColor;
    self.tv_Date.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tv_Date.showsVerticalScrollIndicator = NO;
    self.tv_Date.separatorColor = kClearColor;
    [self.tv_Date registerNib:[UINib nibWithNibName:@"LSDateSortCell" bundle:nil] forCellReuseIdentifier:dcellId];
    
    self.tv_Time = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tv_Time];
    [self.tv_Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.left.equalTo(self.tv_Date.mas_right);
        make.bottom.equalTo(self.view).offset(-DDFitHeight(150.f));
    }];
    self.tv_Time.delegate = self;
    self.tv_Time.dataSource = self;
    self.tv_Time.backgroundColor = kBgWhiteGrayColor;
    self.tv_Time.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tv_Time.showsVerticalScrollIndicator = NO;
    [self.tv_Time registerClass:[LSTimeSortTableViewCell class] forCellReuseIdentifier:cellId];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tv_Time) {
        return self.time_arr.count;
    }
    return self.date_arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tv_Date) {
        LSDateSortCell *dcell = [tableView dequeueReusableCellWithIdentifier:dcellId];
        if (!dcell) {
            dcell = [[LSDateSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dcellId];
        }
        NSDate *date = self.date_arr[indexPath.row];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MM-dd"];
        NSString *s = [format stringFromDate:date];
        NSString *weekString = [self getWeekAndTime:date];

        if (indexPath.row == 0) {
            dcell.selected = YES;
            dcell.lbl_week.text = @"今天";
            dcell.lbl_date.text = s;
        } else {
            dcell.lbl_week.text = [NSString stringWithFormat:@"周%@",weekString];
            dcell.lbl_date.text = s;
        }
        return dcell;
    } else {
        LSTimeSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[LSTimeSortTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.contentView.backgroundColor = kBgWhiteGrayColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.time_arr[indexPath.row];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_confirmSort) {
        return;
    }

    if (tableView == self.tv_Date) {
        NSDate *date = self.date_arr[indexPath.row];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        _dateStr = [format stringFromDate:date];
    } else {
        switch (indexPath.row) {
            case 0:{
                _confirmSort([self appendFormatTimeString:@"08:00:00" DateString:_dateStr],[self appendFormatTimeString:@"11:30:00" DateString:_dateStr]);
            }break;
            case 1:{
                _confirmSort([self appendFormatTimeString:@"12:00:00" DateString:_dateStr],[self appendFormatTimeString:@"14:00:00" DateString:_dateStr]);
            }break;
            case 2:{
                _confirmSort([self appendFormatTimeString:@"14:30:00" DateString:_dateStr],[self appendFormatTimeString:@"16:30:00" DateString:_dateStr]);
            }break;
            case 3:{
                _confirmSort([self appendFormatTimeString:@"17:00:00" DateString:_dateStr],[self appendFormatTimeString:@"11:30:00" DateString:_dateStr]);
            }break;
            case 4:{
                _confirmSort([self appendFormatTimeString:@"21:00:00" DateString:_dateStr],[self appendFormatTimeString:@"23:59:59" DateString:_dateStr]);
            }break;
            default:
                break;
        }
    }
}

- (NSString *)appendFormatTimeString:(NSString *)timeString DateString:(NSString *)dateString{
    if (!dateString) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        dateString = [format stringFromDate:[NSDate date]];
    }
    return [NSString stringWithFormat:@"%@ %@",dateString,timeString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSString *)getWeekAndTime:(NSDate *)date{
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents * conponent = [cal components:unitFlags fromDate:date];
    NSInteger wCurWeek = [conponent weekday];
    NSString *week = nil;
    switch (wCurWeek) {
        case 1:
            week = @"日";
            break;
        case 2:
            week = @"一";
            break;
        case 3:
            week = @"二";
            break;
        case 4:
            week = @"三";
            break;
        case 5:
            week = @"四";
            break;
        case 6:
            week = @"五";
            break;
        case 7:
            week = @"六";
        default:
            break;
    }
    return week;
}




@end
