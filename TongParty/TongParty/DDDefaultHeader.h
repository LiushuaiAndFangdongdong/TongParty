//
//  NHDefaultHeader.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#ifndef NHDefaultHeader_h
#define NHDefaultHeader_h

typedef NS_ENUM(NSUInteger, DDHomeAttentionListType) {
    /** 推荐的关注列表*/
    DDHomeAttentionListTypeRecommend,
    /** 当前用户的关注用户列表*/
    DDHomeAttentionListTypeNormal
};
 
/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kUpdateUserInfoNotification (@"kUpdateUserInfoNotification")


#pragma mark - 颜色
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kRandomColor      [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];
#define kCommonGrayTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]
#define kCommonRedColor [UIColor colorWithRed:0.91f green:0.33f blue:0.33f alpha:1.00f]
#define kBgColor kRGBColor(243,245,247)
#define kLineBgColor [UIColor colorWithRed:0.86f green:0.88f blue:0.89f alpha:1.00f]
#define kMainTextColor [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f]
#define kCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]
#define kSeperatorColor kRGBColor(234,237,240)
#define kMainDetailTextColor [UIColor colorWithRed:0.56f green:0.60f blue:0.62f alpha:1.00f]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f] 
#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]
#define kLabelBgBlackColor kRGBColor(62,50,80)
#define kBgWhiteGrayColor  kRGBColor(249,249,249)
#define kBgGrayColor  kRGBColor(117,117,117)
#define kDarkGreenColor kRGBColor(71,207,133)
#define kLightGreenColor kRGBColor(1,216,105)
#define kBgGreenColor  kRGBColor(0,214,103)
#define kTongBiBgColor  kRGBColor(43,212,117)
#define kLeftMargin 15
//随机色
#define kDDRandColor kRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)

/***  图片 */
#define kImage(image) [UIImage imageNamed:image]

//默认头像
#define kDefaultAvatar kImage(@"avatar_default")


// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define kStatusBarHeight (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define kNavigationBarHeight (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define kTabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#pragma mark - 系统UI
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kContentHeight (kScreenHeight - kNavigationBarHeight)
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736


#pragma mark  -  设备型号
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(kScreenWidth, kScreenHeight))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#pragma mark - 字符串转化
#define kEmptyStr @""
#define kIntToStr(i) [NSString stringWithFormat: @"%d", i]
#define kIntegerToStr(i) [NSString stringWithFormat: @"%ld", i]
#define kValidStr(str) [DDUtils validString:str]


#define DDUserDefault [NSUserDefaults standardUserDefaults]

#define DDFitFont(font) [UIFont systemFontOfSize:(font/667.f)*kScreenHeight]
#define DDFitWidth(w) (w/375.f)*kScreenWidth
#define DDFitHeight(h) (h/667.f)*kScreenHeight


//第三方服务的key
#define GaoDeMapApiKey  @"ed78efbeface6d3dc1a04a6cd0f82f75"
//#define UmengAppKey @"596c7ee4677baa2f4c00018f"//友盟分享appKey
#define UmengAppKey @"5971a3ed99f0c738f1000ff3"//友盟分享appKey
#define ShareQQAppID @"" //腾讯appID
#define ShareQQAppKey @"" //腾讯appKey
#define WetChatAppId @"wx6c456aa37d56cec1" //微信appID
#define WetChatAppSecret @"e504fbccc592263b650f48f0ffbf74d5" //微信appSecret
#define SinaWeiboAppId   @""
#define SinaWeiboAppSecret @""
#define SMSMobAppKey @"" //MobAppKey
#define SMSMobAppSecret @""
#define SMSMobAppKeyTest @"" //MobAppKey--测试使用
#define SMSMobAppSecretTest @""
#define BuglyKey @""

#define AMapKey @"ceb5cd0e123e1b54347117883f0365a0" //高德地图key







#endif /* NHDefaultHeader_h */














