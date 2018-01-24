
//
//  DDDeskMatchViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskMatchViewController.h"

@interface DDDeskMatchViewController ()
@property (nonatomic, strong) UILabel *descLbl;
@property (nonatomic, strong) UIImageView *searchView;
@property (nonatomic, strong) UILabel *matchLabel;
@property (nonatomic, strong) UIImageView *ellipsisView;
@end

@implementation DDDeskMatchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"开始心跳桌匹配"];
    [self setupViews];
}


-(UILabel *)descLbl{
    if (!_descLbl) {
        _descLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 60)];
        _descLbl.text = @"桐聚猫会根据您的筛选\n为您推荐最合心意的桌子";
        _descLbl.textColor = kGrayColor;
        _descLbl.font = kFont(18);
        _descLbl.numberOfLines = 2;
        _descLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _descLbl;
}

-(UIImageView *)searchView{
    if (!_searchView) {
        _searchView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth -180)/2, 250, 180, 180)];
        _searchView.image = kImage(@"lovedesk_match_search");
    }
    return _searchView;
}

-(UILabel *)matchLabel{
    if (!_matchLabel) {
        _matchLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 100, kScreenHeight - 100, 100, 20)];
        _matchLabel.text = @"匹配中";
        _matchLabel.textColor = kGrayColor;
        _matchLabel.textAlignment = NSTextAlignmentRight;
        _matchLabel.font = kFont(15);
    }
    return _matchLabel;
}

-(UIImageView *)ellipsisView{
    if (!_ellipsisView) {
        //图片控件,坐标和大小
        _ellipsisView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight - 100, 40, 20)];
        // 给图片控件添加图片对象
        [_ellipsisView setImage:[UIImage imageNamed:@"ellipsis0"]];
    }
    return _ellipsisView;
}

- (void)setupViews{
    
    [self.view addSubview:self.descLbl];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.matchLabel];
    [self.view addSubview:self.ellipsisView];
    
//    //旋转动画
//    CGAffineTransform transform;
//    transform = CGAffineTransformRotate(_searchView.transform,M_PI/6.0);
//    [UIView beginAnimations:@"rotate" context:nil ];
//    [UIView setAnimationDuration:3];
//    [UIView setAnimationDelegate:self];
//    [_searchView setTransform:transform];
//    [UIView commitAnimations];


    //创建一个可变数组
    NSMutableArray *ary=[NSMutableArray new];
    for(int i = 0;i < 3; i++){
        //通过for 循环,把我所有的 图片存到数组里面
        NSString *filename = [NSString stringWithFormat:@"ellipsis%d",i];
//        // imageWithContentsOfFile: 没有缓存(传入文件的全路径)
//        NSBundle *bundle = [NSBundle mainBundle];
//        NSString *path = [bundle pathForResource:filename ofType:nil];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        UIImage *image  =[UIImage imageNamed:filename];

        [ary addObject:image];
    }
    
    // 设置图片的序列帧 图片数组
    _ellipsisView.animationImages=ary;
    //动画重复次数
    _ellipsisView.animationRepeatCount = 9999;
    //动画执行时间,多长时间执行完动画
    _ellipsisView.animationDuration=2.0;
    //开始动画
    [_ellipsisView startAnimating];
//    [self performSelector:@selector(clearAinimationImageMemory) withObject:nil afterDelay:3.f];// 性能优化的重点来了，此处我在执行完序列帧以后我执行了一个清除内存的操作
}

// 清除animationImages所占用内存
- (void)clearAinimationImageMemory {
    [self.ellipsisView stopAnimating];
    self.ellipsisView.animationImages = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







