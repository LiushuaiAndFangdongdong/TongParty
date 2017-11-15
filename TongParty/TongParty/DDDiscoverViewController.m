//
//  DDDiscoverViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDiscoverViewController.h"
//旋转罗盘
#import "DDCircleView.h"
// 罗盘上图标
#import "DDDragImageView.h"
#import "DDRecomCardViewController.h"

// 图标大小
#define kScale [UIScreen mainScreen].bounds.size.width/375.0f
#define ImageWidth 50 * kScale
#define ImageHeight 50 * kScale
// 转盘frame
#define ScrollFrame CGRectMake(kScreenWidth - 180 * kScale, kScreenHeight - 240 * kScale - 64*2 , 290 * kScale , 290 * kScale)

#define ScrollFrame2 CGRectMake(200 * kScale -kScreenWidth+ 60, kScreenHeight - 420 * kScale - 64*2 , 290 * kScale , 290 * kScale)

// 图标tag
#define BASE_IMAGEVIEW_TAG 1000
#define CENTER_IMAGEVIEW_TAG 1100

@interface DDDiscoverViewController ()
{
    //---------------------------------------------------
    // 转盘
    DDDragImageView *imageviewCharitiesOne;
    DDDragImageView *imageviewPressOne;
    DDDragImageView *imageviewDetailOne;
    DDDragImageView *imageviewCharitiesTwo;
    DDDragImageView *imageviewPressTwo;
    DDDragImageView *imageviewDetailTwo;
    UIImageView *imageviewCenterQuick;
    // 按钮
    NSMutableArray *arrImage;
    // 中心点
    CGPoint pointCenter;
    //半径
    CGFloat fRadius;
    //平均角度
    CGFloat fAvarage_Radina;
    CGPoint pointDrag;
    NSInteger iCurrentIndex;
    NSInteger iStep;
    //---------------------------------------------------
    // 转盘2
    DDDragImageView *imageviewCharitiesOne2;
    DDDragImageView *imageviewPressOne2;
    DDDragImageView *imageviewDetailOne2;
    DDDragImageView *imageviewCharitiesTwo2;
    DDDragImageView *imageviewPressTwo2;
    DDDragImageView *imageviewDetailTwo2;
    UIImageView *imageviewCenterQuick2;
    // 按钮
    NSMutableArray *arrImage2;
    // 中心点
    CGPoint pointCenter2;
    //半径
    CGFloat fRadius2;
    //平均角度
    CGFloat fAvarage_Radina2;
    CGPoint pointDrag2;
    NSInteger iCurrentIndex2;
    NSInteger iStep2;
    //---------------------------------------------------
}
@property (nonatomic, strong) UIImageView *recommedView;
- (void)initDragImageView;
- (void)showImage;

- (void)initDragImageView2;
- (void)showImage2;
@end

@implementation DDDiscoverViewController

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
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:kWhiteColor];
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = kBlackColor;
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttribute];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加转盘
    [self addCircleView];
    [self addCircleView2];
}
-(void)setupViews{
    
    UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, 170)];
    bannerView.image = [UIImage imageNamed:@"banner_image"];
    [self.view addSubview:bannerView];
    
    self.recommedView = [[UIImageView alloc] init];
    [self.view addSubview:self.recommedView];
    [self.recommedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bannerView.mas_bottom).offset(20);
        make.right.mas_equalTo(-20);
        make.width.and.height.mas_equalTo(30);
    }];
    self.recommedView.userInteractionEnabled = YES;
    self.recommedView.image = kImage(@"discover_recommend");
    [self.recommedView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterRecommendCard)]];
}
#pragma mark 添加转盘
- (void)addCircleView {
    [self initDragImageView];
    [self showImage];
}
- (void)addCircleView2 {
    [self initDragImageView2];
    [self showImage2];
}
- (void)initDragImageView{
    // 添加转盘上图标1
    imageviewCharitiesOne = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewCharitiesOne.image = [UIImage imageNamed:@"circle_item"];
    imageviewCharitiesOne.imgName = @"circle_item";
    imageviewCharitiesOne.selectImgName = @"circle_item";
    // 添加转盘上图标2
    imageviewPressOne = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewPressOne.image = [UIImage imageNamed:@"circle_item"];
    imageviewPressOne.imgName = @"circle_item";
    imageviewPressOne.selectImgName = @"circle_item";
    // 添加转盘上图标3
    imageviewDetailOne = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewDetailOne.image = [UIImage imageNamed:@"circle_item"];
    imageviewDetailOne.imgName = @"circle_item";
    imageviewDetailOne.selectImgName = @"circle_item";
    
    // 添加转盘上图标4
    imageviewCharitiesTwo = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewCharitiesTwo.image = [UIImage imageNamed:@"circle_item"];
    imageviewCharitiesTwo.imgName = @"circle_item";
    imageviewCharitiesTwo.selectImgName = @"circle_item";
    // 添加转盘上图标5
    imageviewPressTwo = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewPressTwo.image = [UIImage imageNamed:@"circle_item"];
    imageviewPressTwo.imgName = @"circle_item";
    imageviewPressTwo.selectImgName = @"circle_item";
    // 添加转盘上图标6
    imageviewDetailTwo = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewDetailTwo.image = [UIImage imageNamed:@"circle_item"];
    imageviewDetailTwo.imgName = @"circle_item";
    imageviewDetailTwo.selectImgName = @"circle_item";
    // 添加转盘中心图标
    imageviewCenterQuick = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    imageviewCenterQuick.image = [UIImage imageNamed:@"转盘icon"];
    // 图标集合
    arrImage = [[NSMutableArray alloc] initWithObjects:imageviewCharitiesOne, imageviewPressOne, imageviewDetailOne, imageviewCharitiesTwo, imageviewPressTwo,imageviewDetailTwo, nil];
    for (int i = 0; i < arrImage.count; i ++) {
        DDDragImageView *imageview = [arrImage objectAtIndex:i];
        imageview.userInteractionEnabled = YES;
        // 添加点击手势，点击相应图标，跳转到某一界面
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imageview addGestureRecognizer:tap];
        imageview.tag = BASE_IMAGEVIEW_TAG + i;
    }
    // 转盘中心图标点击手势
    imageviewCenterQuick.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    [imageviewCenterQuick addGestureRecognizer:tap1];
    imageviewCenterQuick.tag = CENTER_IMAGEVIEW_TAG;
}
-(void)imageClick:(UITapGestureRecognizer *)tap {
    long itag = tap.view.tag - BASE_IMAGEVIEW_TAG;
    switch (itag) {
        case 0:
        case 3:
            imageviewCharitiesOne.image = [UIImage imageNamed:@"circle_item"];
            imageviewCharitiesTwo.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击公益，跳转界面");
            break;
        case 1:
        case 4:
            imageviewPressOne.image = [UIImage imageNamed:@"circle_item"];
            imageviewPressTwo.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击发布，跳转界面");
            break;
        case 2:
        case 5:
            imageviewDetailOne.image = [UIImage imageNamed:@"circle_item"];
            imageviewDetailTwo.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击委托，跳转界面");
            break;
        case 100:
            break;
        default:
            NSLog(@"呵呵");
            break;
    }
}
//显示方式是确定圆心正下方的点，然后逆时针绘制点
- (void)showImage{
    DDCircleView *circleView = [[DDCircleView alloc] initWithFrame:ScrollFrame];
    circleView.arrImages = arrImage;
    circleView.centerImgView = imageviewCenterQuick;
    [self.view addSubview:circleView];
    [circleView loadView];
}
//-------------------------------------------------------------------------------------------
- (void)initDragImageView2{
    // 添加转盘上图标1
    imageviewCharitiesOne2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewCharitiesOne2.image = [UIImage imageNamed:@"circle_item"];
    imageviewCharitiesOne2.imgName = @"circle_item";
    imageviewCharitiesOne2.selectImgName = @"circle_item";
    // 添加转盘上图标2
    imageviewPressOne2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewPressOne2.image = [UIImage imageNamed:@"circle_item"];
    imageviewPressOne2.imgName = @"circle_item";
    imageviewPressOne2.selectImgName = @"circle_item";
    // 添加转盘上图标3
    imageviewDetailOne2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewDetailOne2.image = [UIImage imageNamed:@"circle_item"];
    imageviewDetailOne2.imgName = @"circle_item";
    imageviewDetailOne2.selectImgName = @"circle_item";
    
    // 添加转盘上图标4
    imageviewCharitiesTwo2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewCharitiesTwo2.image = [UIImage imageNamed:@"circle_item"];
    imageviewCharitiesTwo2.imgName = @"circle_item";
    imageviewCharitiesTwo2.selectImgName = @"circle_item";
    // 添加转盘上图标5
    imageviewPressTwo2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewPressTwo2.image = [UIImage imageNamed:@"circle_item"];
    imageviewPressTwo2.imgName = @"circle_item";
    imageviewPressTwo2.selectImgName = @"circle_item";
    // 添加转盘上图标6
    imageviewDetailTwo2 = [[DDDragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
    imageviewDetailTwo2.image = [UIImage imageNamed:@"circle_item"];
    imageviewDetailTwo2.imgName = @"circle_item";
    imageviewDetailTwo2.selectImgName = @"circle_item";
    // 添加转盘中心图标
    imageviewCenterQuick2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    imageviewCenterQuick2.image = [UIImage imageNamed:@"转盘icon"];
    // 图标集合
    arrImage2 = [[NSMutableArray alloc] initWithObjects:imageviewCharitiesOne2, imageviewPressOne2, imageviewDetailOne2, imageviewCharitiesTwo2, imageviewPressTwo2,imageviewDetailTwo2, nil];
    for (int i = 0; i < arrImage2.count; i ++) {
        DDDragImageView *imageview2 = [arrImage2 objectAtIndex:i];
        imageview2.userInteractionEnabled = YES;
        // 添加点击手势，点击相应图标，跳转到某一界面
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image2Click:)];
        [imageview2 addGestureRecognizer:tap];
        imageview2.tag = BASE_IMAGEVIEW_TAG + i;
    }
    // 转盘中心图标点击手势
    imageviewCenterQuick2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image2Click:)];
    [imageviewCenterQuick2 addGestureRecognizer:tap1];
    imageviewCenterQuick2.tag = CENTER_IMAGEVIEW_TAG;
}
-(void)image2Click:(UITapGestureRecognizer *)tap {
    long itag = tap.view.tag - BASE_IMAGEVIEW_TAG;
    switch (itag) {
        case 0:
        case 3:
            imageviewCharitiesOne2.image = [UIImage imageNamed:@"circle_item"];
            imageviewCharitiesTwo2.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击公益，跳转界面2");
            break;
        case 1:
        case 4:
            imageviewPressOne2.image = [UIImage imageNamed:@"circle_item"];
            imageviewPressTwo2.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击发布，跳转界面2");
            break;
        case 2:
        case 5:
            imageviewDetailOne2.image = [UIImage imageNamed:@"circle_item"];
            imageviewDetailTwo2.image = [UIImage imageNamed:@"circle_item"];
            NSLog(@"点击委托，跳转界面2");
            break;
        case 100:
            break;
        default:
            NSLog(@"呵呵2");
            break;
    }
}
//显示方式是确定圆心正下方的点，然后逆时针绘制点
- (void)showImage2{
    DDCircleView *circleView = [[DDCircleView alloc] initWithFrame:ScrollFrame2];
    circleView.arrImages = arrImage2;
    circleView.centerImgView = imageviewCenterQuick2;
    [self.view addSubview:circleView];
    [circleView loadView];
}
-(void)enterRecommendCard{
    DDRecomCardViewController *cardVC = [[DDRecomCardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end







