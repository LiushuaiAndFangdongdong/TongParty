//
//  LSCouponView.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/6.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LSCouponViewShowType) {
    /** 加入券**/
    DDDeskShowTypeJoinCoupon  = 0,
    /** 邀请券**/
    DDDeskShowTypeInviteCoupon  = 1,
};
@interface LSCouponView : UIView

+(LSCouponView *)shareInstance;
/**
  window上展示

 @param type 类型
 @param doneDict 点击完成回调
 */
- (void)showCouponViewOnWindowWithType:(LSCouponViewShowType)type doneBlock:(void(^)(NSDictionary *dict))doneDict;

/**
  指定view上展示

 @param view 类型
 @param type 点击完成回调
 */
- (void)showCouponViewOnView:(UIView *)view WithType:(LSCouponViewShowType)type doneBlock:(void(^)())done;


/**
  隐藏此优惠券控件
 */
- (void)hiddeCouponView;

@end
