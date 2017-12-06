//
//  DDCaptchaTimerManager.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/5.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDCaptchaTimerManager.h"

@implementation DDCaptchaTimerManager

+ (id)sharedTimerManager{
    static DDCaptchaTimerManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager ==nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (void)countDown{
    
    if (_timeout >0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(_timeout<=0){//倒计时结束，关闭
                dispatch_source_cancel(_timer);
            }else{
                _timeout--;
            }
        });
        dispatch_resume(_timer);
    }
}
@end






