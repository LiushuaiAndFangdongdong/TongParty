//
//  DDEditAddrView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDEditAddrView.h"
#import "DDTagView.h"
#import "TSActionDemoView.h"
//#import "HexColors.h"

#define kRowHeight  55

@interface DDEditAddrView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *keyAddr;
@property (nonatomic, strong) UILabel *valueAddr;
@property (nonatomic, strong) UIImageView *accessView;
@property (nonatomic, strong) UILabel *detailAddr;
@property (nonatomic, strong) UITextField *detailTxt;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) DDTagView *tagView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, assign) NSUInteger originalButtonCount;
@property (strong, nonatomic) NSArray *colors;
@property (nonatomic, strong) DDAddressModel *saveModel;
@property (nonatomic, strong) NSArray *tagsArray;
-(void)tj_configTag:(DDTag*)tag withIndex:(NSUInteger)index;
@end

@implementation DDEditAddrView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _saveModel = [[DDAddressModel alloc] init];
        [self initFrame:frame];
    }
    return self;
}

- (void)initFrame:(CGRect)frame{
//    self.colors = @[@"#7ecef4", @"#84ccc9", @"#88abda", @"#7dc1dd", @"#b6b8de"];
    float width = frame.size.width;
    float height = frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,width, height)];
    _scrollView.backgroundColor = kBgWhiteGrayColor;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight +5);
    
    _keyAddr = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 90, kRowHeight)];
    _keyAddr.backgroundColor = kWhiteColor;
    _keyAddr.text = @"所在地区：";
    _keyAddr.textColor = kBlackColor;
    _keyAddr.font = kFont(15);
    _keyAddr.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_keyAddr];
    
    _accessView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 28, (kRowHeight-18)/2, 18, 18)];
    _accessView.backgroundColor = kWhiteColor;
    _accessView.image = kImage(@"usercenter_access");
    [_scrollView addSubview:_accessView];
    
    _valueAddr = [[UILabel alloc] initWithFrame:CGRectMake(_keyAddr.x+_keyAddr.width, _keyAddr.y, kScreenWidth - _accessView.width - _keyAddr.width, _keyAddr.height)];
//    _valueAddr.text = @"北京望京";
    _valueAddr.backgroundColor = kWhiteColor;
    _valueAddr.textColor = kGrayColor;
    _valueAddr.font = kFont(15);
    _valueAddr.textAlignment = NSTextAlignmentLeft;
    _valueAddr.userInteractionEnabled =  YES;
    [_scrollView addSubview:_valueAddr];
    [_valueAddr addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLocationAddrClick:)]];
    
    _detailAddr = [[UILabel alloc] initWithFrame:CGRectMake(_keyAddr.x, _keyAddr.y+_keyAddr.height+1, _keyAddr.width, _keyAddr.height)];
    _detailAddr.backgroundColor = kWhiteColor;
    _detailAddr.text = @"详细地址：";
    _detailAddr.textColor = kBlackColor;
    _detailAddr.font = kFont(15);
    _detailAddr.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_detailAddr];
    
    _detailTxt = [[UITextField alloc] initWithFrame:CGRectMake(_detailAddr.x+_detailAddr.width, _detailAddr.y, kScreenWidth - _detailAddr.width, _detailAddr.height)];
    _detailTxt.textColor = kGrayColor;
    _detailTxt.placeholder  = @"请输入详细地址";
    _detailTxt.backgroundColor = kWhiteColor;
    [_detailTxt setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [_detailTxt setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_scrollView addSubview:_detailTxt];
    
    
    _keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_detailAddr.x, _detailAddr.y+_detailAddr.height+1, _detailAddr.width, _detailAddr.height)]
    ;
    _keyLabel.text = @"标签：";
    _keyLabel.backgroundColor = kWhiteColor;
    _keyLabel.textColor = kBlackColor;
    _keyLabel.font = kFont(15);
    _keyLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_keyLabel];
    
    _tagView = [[DDTagView alloc] initWithFrame:CGRectMake(_keyLabel.x+_keyLabel.width, _keyLabel.y, kScreenWidth - _keyLabel.x - _keyLabel.width, _keyLabel.height)];
    [_scrollView addSubview:_tagView];
    _tagView.backgroundColor=  kWhiteColor;
    _tagView.padding = UIEdgeInsetsMake(16, 5, 16, 10);
    _tagView.interitemSpacing = 15;
    _tagView.lineSpacing = 10;
    _tagView.didTapTagAtIndex = ^(NSMutableArray *tags,NSUInteger index){
        
        //点击添加
        if (index == 0) {
            TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
            demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
            demoAlertView.isAutoHidden = YES;
            demoAlertView.titleString = @"标签名称";
            demoAlertView.ploceHolderString = @"请输入标签名称";
            
            typeof(TSActionDemoView) __weak *weakView = demoAlertView;
            [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
                typeof(TSActionDemoView) __strong *strongView = weakView;
                
                NSLog(@"Get string: %@",string);
                DDTag *tag = [DDTag tagWithText:string];
                [self tj_configTag:tag withIndex:self.originalButtonCount];
                [self.tagView insertTag:tag atIndex:1];
                self.originalButtonCount ++ ;
                [strongView dismissAnimated:YES];
            }];
            [demoAlertView show];
        }else{
            DDTag *tag = tags[index];
            _saveModel.label = tag.text;
            NSLog(@"点击标签--->%@",tag.text);
        }

    };
    
    _tagsArray = @[@" + ",@"家", @"公司"];
    self.originalButtonCount = _tagsArray.count;
    [_tagsArray enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
        DDTag *tag = [DDTag tagWithText: text];
        if (idx == 0) {
//            tag.textColor = [UIColor hx_colorWithHexString: self.colors[idx % self.colors.count]];
            tag.textColor = kBlackColor;
//            tag.borderColor = tag.textColor;
            tag.borderColor = kBgGrayColor;
            tag.borderWidth = 1;
            tag.fontSize = 15;
            tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
            tag.nrmColor = [UIColor clearColor];
            tag.cornerRadius = 5;
        }else{
            [self tj_configTag:tag withIndex:idx];
        }
        [self.tagView addTag:tag];
    }];
    
    
    _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, height - kNavigationBarHeight - kTabBarHeight - 5, kScreenWidth, kTabBarHeight)];
    [_saveBtn addTarget:self action:@selector(didSelectedToSaveNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _saveBtn.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    _saveBtn.titleLabel.font = DDFitFont(16.f);
    [_scrollView addSubview:_saveBtn];
}

-(void)tj_configTag:(DDTag *)tag withIndex:(NSUInteger)index
{
    tag.textColor = kBlackColor;
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
//    tag.nrmColor = [UIColor hx_colorWithHexString: self.colors[index % self.colors.count]];
    tag.cornerRadius = 5;
    tag.borderColor = kBgGrayColor;
    tag.borderWidth = 1;
}

- (void)selectLocationAddrClick:(UITapGestureRecognizer *)tap{
    NSLog(@"定位选择地址");
    if (_locationAddrBlcok) {
        _locationAddrBlcok();
    }
}

- (void)tempEditValueWith:(DDAddressModel *)model{
    _valueAddr.text = model.addr;
    _detailTxt.text = model.detail;
    
    _saveModel.addr = model.addr;
    _saveModel.detail = model.detail;
    _saveModel.longitude = model.longitude;
    _saveModel.latitude = model.latitude;
    _saveModel.label = model.label;
}

- (void)updateWithMap:(AMapPOI *)map{
    _valueAddr.text = map.name;
    _saveModel.addr = map.name;
    _saveModel.longitude = [NSString stringWithFormat:@"%f",map.location.longitude];
    _saveModel.latitude = [NSString stringWithFormat:@"%f",map.location.latitude];
}

- (void)didSelectedToSaveNewAddress:(UIButton*)sender{
    _saveModel.detail = _detailTxt.text;
    NSLog(@"保存地址");
    if (_saveAddrBlcok) {
        _saveAddrBlcok(_saveModel);
    }
}

@end















