//
//  UIButton+DDEvent.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "UIButton+DDEvent.h"
#import <objc/runtime.h>

@interface UIButton ()
@property (nonatomic, assign) NSTimeInterval temp_timeInterval;
@end

@implementation UIButton (DDEvent)
+ (void)load {
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method DDMethod = class_getInstanceMethod(self, @selector(SG_sendAction:to:forEvent:));
    SEL SGSEL = @selector(dd_sendAction:to:forEvent:);
    
    BOOL addMethod = class_addMethod(self, SGSEL, method_getImplementation(DDMethod), method_getTypeEncoding(DDMethod));
    if (addMethod) {
        class_replaceMethod(self, sysSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, DDMethod);
    }
}

- (void)dd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.temp_timeInterval >= self.dd_timeInterval);
    
    if (self.dd_timeInterval > 0) {
        self.temp_timeInterval = NSDate.date.timeIntervalSince1970;
    }
    
    if (needSendAction) {
        [self dd_sendAction:action to:target forEvent:event];
    }
}

#pragma mark - - - set、get
- (void)setDd_timeInterval:(NSTimeInterval)dd_timeInterval {
    objc_setAssociatedObject(self, "UIButton_DD_timeInterval", @(dd_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)dd_timeInterval {
    return [objc_getAssociatedObject(self, "UIButton_DD_timeInterval") doubleValue];
}

- (void)setTemp_timeInterval:(NSTimeInterval)temp_timeInterval {
    objc_setAssociatedObject(self, "UIButton_temp_timeInterval", @(temp_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)temp_timeInterval {
    return [objc_getAssociatedObject(self, "UIButton_temp_timeInterval") doubleValue];
}

@end
