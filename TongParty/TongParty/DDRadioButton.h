//
//  DDRadioButton.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/15.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDRadioButtonDelegate;

@interface DDRadioButton : UIButton
{
    //    NSString                        *_groupId;
    //    BOOL                            _checked;
    //    id<DDRadioButtonDelegate>       _delegate;
}
@property(nonatomic, assign) id<DDRadioButtonDelegate>   delegate;
@property(nonatomic, copy)   NSString            *groupId;
@property(nonatomic, assign) BOOL checked;
@property(nonatomic, copy)   NSString            *nameString;
- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId;

@end

@protocol DDRadioButtonDelegate <NSObject>

@optional

- (void)didSelectedRadioButton:(DDRadioButton *)radio groupId:(NSString *)groupId;

@end

