//
//  LSHomeQRcodeVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSHomeQRcodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "LSQRScanView.h"

@interface LSHomeQRcodeVC ()<AVCaptureMetadataOutputObjectsDelegate>{
    UIAlertController *_messageAlerController;
}
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)AVCaptureSession *scanCaptureSession;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *avcLayer;
@property(nonatomic,strong)NSTimer *animtaingTimer;
@property(nonatomic,strong)NSObject *observer;

@end

@implementation LSHomeQRcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isOpenCamera]){
        [self startScanning];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"打开相机来允许\"桐聚\"使用相机"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        //添加取消到UIAlertController中
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            // 退场
            [self dismiss];
        }];
        [alertController addAction:cancelAction];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.avcLayer.frame = self.view.layer.bounds;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.tabBarController.tabBar.hidden = YES;
    [self.scanView lineStartAnimation];
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - DDFitWidth(60.f), kNavigationBarHeight - DDFitHeight(30.f), DDFitWidth(50.f), DDFitHeight(50.f))];
    [btn_close setTitle:@"X" forState:UIControlStateNormal];
    [btn_close setTitleColor:kWhiteColor forState:UIControlStateNormal];
    btn_close.titleLabel.font = DDFitFont(18.f);
    [btn_close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_close];
}

- (UIView *)scanView{
    if (!_scanView) {
        _scanView = [[LSQRScanView alloc]initWithFrame:CGRectZero leftEdge:(CGRectGetWidth(self.view.bounds) * 1 / 5) / 2];
        [self.view addSubview:_scanView];
        [_scanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.and.bottom.equalTo(self.view);
        }];
    }
    return _scanView;
}

- (void)startScanning{
    //创建会话
    self.scanCaptureSession = [[AVCaptureSession alloc]init];
    //获取AVCaptureDevice 实例并设置defaultDeviceWithMediaType类型
    AVCaptureDevice *avCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    //初始化输入流
    AVCaptureDeviceInput *avCaptureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:avCaptureDevice error:&error];
    //给会话添加输入流
    [self.scanCaptureSession addInput:avCaptureDeviceInput];
    //创建输出流
    AVCaptureMetadataOutput *avCaptureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //给会话添加输出流
    [self.scanCaptureSession addOutput:avCaptureMetadataOutput];
    //设置代理
    [avCaptureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //先添加再设置输出的类型
    [avCaptureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //摄像头图层显示的范围大小,可以自己随便设置。与下面avCaptureMetadataOutput.rectOfInterest这个属性是两个概念(这个指的是扫一扫有效区域)
    self.avcLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.scanCaptureSession];
    [self.avcLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer addSublayer:self.avcLayer]; 
    [self.scanCaptureSession startRunning];
}

#pragma mark -AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (_messageAlerController) {
        return;
    }
    if (metadataObjects.count > 0) {
        [self.scanView lineStopAnimation];
        AVMetadataMachineReadableCodeObject *metadataMacObj = metadataObjects[0];
        NSString *result = metadataMacObj.stringValue;
        NSLog(@"scnString = %@",result);
        if (self.allBlock) {
            _allBlock(result);
            [self.scanCaptureSession stopRunning];
            [self dismiss];
        }
    }
}

- (UIBarButtonItem *)customRightTitleButtonForNavigationWithAction:(SEL)action title:(NSString *)title CGSize:(CGSize)size{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateHighlighted];
    button.titleLabel.font = kFont(14);
    button.frame = CGRectMake(0, 0, size.width,size.height);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    return btnBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (BOOL)isOpenCamera {
    BOOL isCamera = YES;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        isCamera = NO;
    }
    return isCamera;
}


@end
