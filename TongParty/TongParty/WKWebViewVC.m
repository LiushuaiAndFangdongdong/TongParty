//
//  WKWebViewVC.m
//  _49park
//
//  Created by SJ on 2017/11/13.
//  Copyright © 2017年 ls. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>

@interface WKWebViewVC ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) CALayer *progresslayer;
@property (nonatomic, strong) NSString *titleStr;
@end

@implementation WKWebViewVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(popController)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = [[WKUserContentController alloc]init];
    [config.userContentController addScriptMessageHandler:self name:@"iOSAttractJoin"];
    WKWebView *webView;
    if(self.isNONavigat){
        webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20) configuration:config];
    }else{
        webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) configuration:config];
    }
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    //添加属性监听
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    //进度条
    UIView *progress;
    if(self.isNONavigat){
        progress = [[UIView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 3)];
    }else{
        progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    }
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = kGreenColor.CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView){
            [self navigationWithTitle:self.webView.title] ;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)popController{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
