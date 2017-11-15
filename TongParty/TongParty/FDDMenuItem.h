//
//  FDDMenuItem.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FDDMenuItem : NSObject

@property (readwrite, nonatomic, strong) UIImage      *image;
@property (readwrite, nonatomic, strong) NSString     *title;
@property (readwrite, nonatomic, assign) NSInteger     tag;
@property (readwrite, nonatomic, strong) NSDictionary *userInfo;

@property (readwrite, nonatomic, strong) UIFont  *titleFont;
@property (readwrite, nonatomic) NSTextAlignment  alignment;
@property (readwrite, nonatomic, strong) UIColor *foreColor;

@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL      action;



+ (instancetype)menuTitle:(NSString *)title WithIcon:(UIImage *)icon;

+ (instancetype)menuItem:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag userInfo:(NSDictionary *)userInfo;

+ (instancetype)menuItem:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;

- (void)performAction;

- (BOOL)enabled;

@end
