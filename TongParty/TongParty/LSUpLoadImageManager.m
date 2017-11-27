//
//  LSUpLoadImageManager.m
//  _49park
//
//  Created by Ls on 2017/9/3.
//  Copyright © 2017年 ls. All rights reserved.
//

#import "LSUpLoadImageManager.h"

static LSUpLoadImageManager *zxUploadImage = nil;

@implementation LSUpLoadImageManager

+ (LSUpLoadImageManager *)shareUploadImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zxUploadImage = [[LSUpLoadImageManager alloc] init];
    });
    return zxUploadImage;
}
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<LSUpLoadImageManagerDelegate>)aDelegate {
    zxUploadImage.uploadImageDelegate = aDelegate;
    _fatherViewController = fatherVC;
    
    UIAlertAction *alertTakePhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self ablum];
    }];
    
    UIAlertAction *alertAlbum = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    
    UIAlertAction *alertCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"撤！");
    }];
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertControl addAction:alertTakePhoto];
    [alertControl addAction:alertAlbum];
    [alertControl addAction:alertCancle];
    [fatherVC presentViewController:alertControl animated:YES completion:nil];
}

#pragma mark - 头像(相机和从相册中选择)
- (void)camera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType                = UIImagePickerControllerSourceTypeCamera;
        imagePC.delegate                  = self;
        imagePC.editing                   = YES;
        [_fatherViewController presentViewController:imagePC
                                            animated:YES
                                          completion:nil];
    }else {
        [MBProgressHUD showError:@"该设备不支持相机" toView:[UIApplication sharedApplication].keyWindow];
    }
}
//图片库方法(从手机的图片库中查找图片)
- (void)ablum {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType                = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.delegate                  = self;
    imagePC.editing                   = YES;
    [_fatherViewController presentViewController:imagePC
                                        animated:YES
                                      completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadImageToServerWithImage:)]) {
        [self.uploadImageDelegate uploadImageToServerWithImage:image];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
