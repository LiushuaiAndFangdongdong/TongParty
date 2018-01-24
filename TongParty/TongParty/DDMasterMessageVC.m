
//
//  DDMasterMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMasterMessageVC.h"
#import "LLSegmentBarVC.h"
#import "DDReplyMessageVC.h"
#import "DDInterestMessageVC.h"
@interface DDMasterMessageVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) DDLoginManager *loginManager;
@property (nonatomic, strong) DDReplyMessageVC  *replyMsgVc;
@property (nonatomic, strong) DDInterestMessageVC *interestMsgVc;
@property (nonatomic, weak) LLSegmentBarVC * segmentVC;
//@property (nonatomic,strong) CorePagesView *pagesView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *btn_wait;
@property (nonatomic, strong) UIButton *btn_inter;
@property (nonatomic, strong) UIView   *view_title;
@property (nonatomic, strong) UILabel  *lbl_line;
@property (nonatomic, copy) NSString  *wait_title;
@property (nonatomic, copy) NSString  *inter_title;
@end

@implementation DDMasterMessageVC

- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(kScreenWidth * 2, kScreenHeight - kNavigationBarHeight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;
        _scrollView.scrollEnabled   = NO;
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (UIView *)view_title {
    if (!_view_title) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/1.5f, 45)];
        _btn_wait = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3.f, 45)];
        _btn_wait.titleLabel.font = DDFitFont(15.f);
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"等待回复的人"];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:DDFitFont(15.f)
                              range:NSMakeRange(0, 6)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:kBgGreenColor
                              range:NSMakeRange(0, 6)];
        [_btn_wait setAttributedTitle:AttributedStr forState:UIControlStateNormal];
        _btn_wait.tag = 3607;
        [_btn_wait addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_btn_wait];
        _btn_inter = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2.8f, 0, kScreenWidth/3.f, 45)];
        _btn_inter.titleLabel.font = DDFitFont(15.f);
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:@"感兴趣的人"];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:DDFitFont(15.f)
                               range:NSMakeRange(0, 5)];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:kCommonGrayTextColor
                               range:NSMakeRange(0, 5)];
        [_btn_inter setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
        _btn_inter.tag = 3608;
        [_btn_inter addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_btn_inter];
        _lbl_line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth/2.6f, 2.5)];
        _lbl_line.centerX = _btn_wait.centerX;
        _lbl_line.backgroundColor = kBgGreenColor;
        [view addSubview:_lbl_line];
        _view_title = view;
    }
    return _view_title;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(back)];
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        [self configSegement];
    }];
}
-(void)back{
    [self popViewController];
}

- (void)configSegement{
    
    self.navigationItem.titleView = self.view_title;
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.replyMsgVc];
    [self addChildViewController:self.interestMsgVc];
    [self.scrollView addSubview:self.replyMsgVc.view];
    [self.scrollView addSubview:self.interestMsgVc.view];
    self.interestMsgVc.messageModel = _messageModel;
    self.replyMsgVc.messageModel = _messageModel;
}


-(DDLoginManager *)loginManager {
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


- (DDReplyMessageVC *)replyMsgVc {
    if (!_replyMsgVc) {
        DDReplyMessageVC *rmVC = [[DDReplyMessageVC alloc] init];
        rmVC.members = ^(NSString *count) {
            _wait_title = count;
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"等待回复的人%@",_wait_title ? [NSString stringWithFormat:@"(%@)",_wait_title] : @""]];
            
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:DDFitFont(15.f)
                                  range:NSMakeRange(0, 6)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:kBgGreenColor
                                  range:NSMakeRange(0, 6)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor redColor]
                                  range:NSMakeRange(6, AttributedStr.length - 6)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:DDFitFont(12.f)
                                  range:NSMakeRange(5, AttributedStr.length - 6)];
            [_btn_wait setAttributedTitle:AttributedStr forState:UIControlStateNormal];
            //[_btn_inter setTitle:[NSString stringWithFormat:@"等待回复的人%@",count] forState:UIControlStateNormal];
        };
        [rmVC willMoveToParentViewController:self];
        [self addChildViewController:rmVC];
        [self.view addSubview:rmVC.view];
        rmVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _replyMsgVc = rmVC;
    }
    return _replyMsgVc;
}

- (DDInterestMessageVC *)interestMsgVc {
    if (!_interestMsgVc) {
        DDInterestMessageVC *intertedVC = [[DDInterestMessageVC alloc] init];
        intertedVC.members = ^(NSString *count) {
            _inter_title = count;
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"感兴趣的人%@",_inter_title ? [NSString stringWithFormat:@"(%@)",_inter_title] : @""]];
            
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:DDFitFont(15.f)
                                  range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:kCommonGrayTextColor
                                  range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor redColor]
                                  range:NSMakeRange(5, AttributedStr.length - 5)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:DDFitFont(12.f)
                                  range:NSMakeRange(5, AttributedStr.length - 5)];
            [_btn_inter setAttributedTitle:AttributedStr forState:UIControlStateNormal];
        };
        [intertedVC willMoveToParentViewController:self];
        [self addChildViewController:intertedVC];
        [self.view addSubview:intertedVC.view];
        intertedVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _interestMsgVc = intertedVC;
    }
    return _interestMsgVc;
}

-(void)modelTransform:(UIButton *)sender {
    
    if (sender.tag == 3608) {
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"等待回复的人%@",_wait_title ? [NSString stringWithFormat:@"(%@)",_wait_title] : @""]];
        
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:DDFitFont(15.f)
                               range:NSMakeRange(0, 6)];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:kCommonGrayTextColor
                               range:NSMakeRange(0, 6)];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(6, AttributedStr1.length - 6)];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:DDFitFont(12.f)
                               range:NSMakeRange(5, AttributedStr1.length - 6)];
        [_btn_wait setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"感兴趣的人%@",_inter_title ? [NSString stringWithFormat:@"(%@)",_inter_title] : @""]];
        
        [AttributedStr addAttribute:NSFontAttributeName
                              value:DDFitFont(15.f)
                              range:NSMakeRange(0, 5)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:kBgGreenColor
                              range:NSMakeRange(0, 5)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor redColor]
                              range:NSMakeRange(5, AttributedStr.length - 5)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:DDFitFont(12.f)
                              range:NSMakeRange(5, AttributedStr.length - 5)];
        [_btn_inter setAttributedTitle:AttributedStr forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5f animations:^{
            self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            _lbl_line.centerX = sender.centerX;
        } completion:^(BOOL finished) {
        }];
    } else {
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"感兴趣的人%@",_inter_title ? [NSString stringWithFormat:@"(%@)",_inter_title] : @""]];
        
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:DDFitFont(15.f)
                               range:NSMakeRange(0, 5)];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:kCommonGrayTextColor
                               range:NSMakeRange(0, 5)];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(5, AttributedStr1.length - 5)];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:DDFitFont(12.f)
                               range:NSMakeRange(5, AttributedStr1.length - 5)];
        [_btn_inter setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"等待回复的人%@",_wait_title ? [NSString stringWithFormat:@"(%@)",_wait_title] : @""]];
        
        [AttributedStr addAttribute:NSFontAttributeName
                              value:DDFitFont(15.f)
                              range:NSMakeRange(0, 6)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:kBgGreenColor
                              range:NSMakeRange(0, 6)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor redColor]
                              range:NSMakeRange(6, AttributedStr.length - 6)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:DDFitFont(12.f)
                              range:NSMakeRange(5, AttributedStr.length - 6)];
        [_btn_wait setAttributedTitle:AttributedStr forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5f animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
            _lbl_line.centerX = sender.centerX;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







