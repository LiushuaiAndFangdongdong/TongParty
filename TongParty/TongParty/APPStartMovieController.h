//
//  APPStartMovieController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/8/17.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPStartMovieController : UIViewController

@property(nonatomic,strong)NSURL *movieURL;

@property (nonatomic, copy) void(^buttonEnterBlcok)();
@end
