//
//  DDBannerViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//轮播图cell

#import <UIKit/UIKit.h>

@interface DDBannerViewCell : UICollectionViewCell
/** 图片链接*/
@property (nonatomic, copy) NSString *url;
/** 标题*/
@property (nonatomic, copy) NSString *title;
@end
