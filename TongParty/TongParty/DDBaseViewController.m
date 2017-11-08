//
//  DDBaseViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDCustomNoNetworkEmptyView.h"      //没有网络时候显示的视图
#import "NSNotificationCenter+Addition.h"   //通知
#import "DDCustomLoadingAnimationView.h"    //loading动画视图
#import "DDLocationManager.h"               //定位管理类
#import "AFNetworkReachabilityManager.h"
#import "UIView+Tap.h"                      //动态添加手势
#import "UIImage+Addition.h"    
#import "UIView+RedPoint.h"
#import "DPScreenshotsPopView.h"   //截图分享
#import <UShareUI/UShareUI.h>
#import "DDTJShareManager.h"

//#import "YYWebImageManager.h"
//#import "YYDiskCache.h"
//#import "YYMemoryCache.h"

@interface DDBaseViewController ()<CAAnimationDelegate>

@property (nonatomic, weak) DDCustomNoNetworkEmptyView *noNetworkEmptyView;
@property (nonatomic, weak) DDCustomLoadingAnimationView *animationView;
@property (nonatomic,assign) BOOL isHidden;
@end

@implementation DDBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    _isHidden=YES;
    //================第一种通过注册通知的方法
    //    注册通知  iOS7提供一个崭新的推送方法：UIApplicationUserDidTakeScreenshotNotification。只要像往常一样订阅即可知道什么时候截图了。
    //        注意：UIApplicationUserDidTakeScreenshotNotification 将会在截图完成之后显示。现在在截图截取之前无法得到通知。
    //        希望苹果会在iOS8当中增加 UIApplicationUserWillTakeScreenshotNotification。（只有did, 没有will显然不是苹果的风格...）
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:YES];
    //自动调整ScrollView的inset.
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = kBgWhiteGrayColor;
    
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:kNHRequestSuccessNotification];
}

- (void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
//    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
//    if (self.navigationController == nil) return ;
//    if (vc.hidesBottomBarWhenPushed == NO) {
//        vc.hidesBottomBarWhenPushed = YES;
//    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (DDCustomNoNetworkEmptyView *)noNetworkEmptyView {
    if (!_noNetworkEmptyView) {
        DDCustomNoNetworkEmptyView *empty = [[DDCustomNoNetworkEmptyView alloc] init];
        [self.view addSubview:empty];
        _noNetworkEmptyView = empty;
        
        WeakSelf(weakSelf);
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(DDCustomNoNetworkEmptyView *emptyView) {
            [weakSelf loadData];
            
        };
    }
    return _noNetworkEmptyView;
}

- (void)showLoadingAnimation {
    DDCustomLoadingAnimationView *animation = [[DDCustomLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _animationView = animation;
    [self.view bringSubviewToFront:animation];
}

- (void)hideLoadingAnimation {
    [_animationView dismiss];
    _animationView = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.animationView];
}

- (void)loadData {
    [self showLoadingAnimation];
    
    // 网络不可用
    if ([AFNetworkReachabilityManager sharedManager].reachable == NO) {
        
        [self hideLoadingAnimation];
        //        self.noNetworkEmptyView.hidden = NO;
        
//        [self.view addSubview:self.noNetworkEmptyView];
        
    } else { // 网络可用
        
        [self.noNetworkEmptyView removeFromSuperview];
        _noNetworkEmptyView = nil;
    }
}

- (BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
//    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
//    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}

- (UIBarButtonItem *)customTitleButtonForNavigationWithAction:(SEL)action title:(NSString *)title CGSize:(CGSize)size{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button setTitleColor:kBgGreenColor forState:UIControlStateHighlighted];
    button.titleLabel.font = kFont(14);
    button.frame = CGRectMake(0, 0, size.width,size.height);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    return btnBar;
}

-(UIBarButtonItem *)customButtonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed isRedPoint:(BOOL)isRedPoint pointValue:(NSString *)pointValue CGSizeMake:(CGSize)size
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage reSizeImage:[UIImage imageNamed:imageNamed] toSize:size];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, size.width,size.height);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    if (isRedPoint) {
        [button showRedAtOffSetX:0 AndOffSetY:0 OrValue:pointValue];
    }else{
        [button hideRedPoint];
    }
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:view];
    return btnBar;
}

-(NSArray *)customVariousButtonForNavigationBarWithFirstAction:(SEL)firstAction firstImage:(NSString *)firstImage firstIsRedPoint:(BOOL)firstIsRedPoint firstPointValue:(NSString *)firstPointValue secondAction:(SEL)secondAction secondImage:(NSString *)secondImage secondIsRedPoint:(BOOL)secondIsRedPoint secondPointValue:(NSString *)secondPointValue {
    
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:firstImage] forState:UIControlStateNormal];
    [informationCardBtn sizeToFit];
    if (firstIsRedPoint) {
        [informationCardBtn showRedAtOffSetX:0 AndOffSetY:0 OrValue:firstPointValue];
    }else{
        [informationCardBtn hideRedPoint];
    }
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 10;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:secondImage] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    if (secondIsRedPoint) {
        [settingBtn showRedAtOffSetX:0 AndOffSetY:0 OrValue:secondPointValue];
    }else{
        [settingBtn hideRedPoint];
    }
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
//    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
    
    return @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem] ;
}
//获取导航返回按钮
- (UIBarButtonItem *)backButtonForNavigationBarWithAction:(SEL)action
{
    UIImage *image = [UIImage imageNamed:@"back_tj"];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc] initWithImage:image
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    return btnBar;
}
//设置控制器的导航标题title
- (void)navigationWithTitle:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 49)];
    titlelabel.text = title;
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlelabel;
//        self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(popViewController)];
}

//控制器push时的模态效果
- (void)pushModalWithController:(UIViewController *)controller
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:controller animated:NO];
}
//控制器pop时的模态效果
- (void)popModalViewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
//pop方法
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    UIWindow *keyWindow=[[UIApplication sharedApplication]keyWindow];
    if (_isHidden) {
        DPScreenshotsPopView *popView=[DPScreenshotsPopView initWithScreenShots:image_ selectSheetBlock:^(SelectSheetType type) {
            if (type==QQSelectSheetType) {
                NSLog(@"点击的是QQ分享");
                [self shareWithUMSocialPlatformType:UMSocialPlatformType_QQ image:image_];
            }else if (type==WeiXinSelectSheetType){
                NSLog(@"点击的是微信好友分享");
                [self shareWithUMSocialPlatformType:UMSocialPlatformType_WechatSession image:image_];
            }else if (type==WeiXinCircleSelectSheetType){
                NSLog(@"点击的是微信朋友圈分享");
                [self shareWithUMSocialPlatformType:UMSocialPlatformType_WechatTimeLine image:image_];
            }
        }];
        [popView show];
        
        [keyWindow addSubview:popView];
        _isHidden=NO;
        popView.hiddenBlock = ^{
            _isHidden=YES;
        };
    }else{
    }
}
-(void)shareWithUMSocialPlatformType:(UMSocialPlatformType)type image:(UIImage *)image{
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, image.size.width, image.size.height)];
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
//    UIImage *watermarkImage = [UIImage imageNamed:@"AppIcon"];
//    UIImage *imageWithImageWatermark = [UIImage imageWithUIImage:image watermarkOfImage:watermarkImage position:ATWatermarkPositonBottomRight];
//    //    self.imageView.image = imageWithImageWatermark;
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSForegroundColorAttributeName] = kDarkGreenColor;
//    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
//
//    NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"@桐聚" attributes:attrDict];
//    UIImage *imageWithImageAndTextWatermark = [UIImage imageWithUIImage:imageWithImageWatermark watermarkOfText:attrString position:ATWatermarkPositonBottomRight];
//    imageView.image = imageWithImageAndTextWatermark;
//
    WeakSelf(weakSelf);
    [[DDTJShareManager sharedManager] shareImageWithSharedType:type image:image controller:weakSelf];
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}
//图片转字符串
-(NSString *)imageToBase64Str:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
@end






