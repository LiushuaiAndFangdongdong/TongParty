//
//  TSActionDemoView.h
//  TSAlertActionDemo
//
//  Created by Dylan Chen on 2017/8/15.
//  Copyright © 2017年 Dylan Chen. All rights reserved.
//

#import "TSActionAlertView.h"

@interface TSActionDemoView : TSActionAlertView

@property (strong,nonatomic)TSActionAlertViewStringHandler stringHandler;
@property (nonatomic, copy) NSString *ploceHolderString;
@property (nonatomic, copy) NSString *titleString;
@end
