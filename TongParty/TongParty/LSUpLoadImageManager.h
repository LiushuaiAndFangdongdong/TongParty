//
//  LSUpLoadImageManager.h
//  _49park
//
//  Created by Ls on 2017/9/3.
//  Copyright © 2017年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LSUPLOAD_IMAGE [LSUpLoadImageManager shareUploadImage]
//写了一个代理方法
@protocol LSUpLoadImageManagerDelegate <NSObject>
@optional
- (void)uploadImageToServerWithImage:(UIImage *)image;
@end
@interface LSUpLoadImageManager : NSObject < UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
{
    //如果您调不出来UIViewController,请添加UIKit头文件
    UIViewController *_fatherViewController;
}
@property (nonatomic, weak) id <LSUpLoadImageManagerDelegate> uploadImageDelegate;
//单例方法
+ (LSUpLoadImageManager *)shareUploadImage;

//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<LSUpLoadImageManagerDelegate>)aDelegate;


@end
