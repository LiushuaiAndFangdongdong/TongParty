//
//  PhotoCell.h
//  WXMovie
//

//

#import <UIKit/UIKit.h>
#import "BJtableView.h"

#define kImgClickNotification @"kImgClickNotification" 

@interface PhotoCell : UICollectionViewCell<UIScrollViewDelegate,BJtableViewDelegate> {
    
    UIScrollView *_scrollView;
    UIImageView *_imgView;
    BJtableView *_bjTB;
}


@property(nonatomic,weak)id delegate;


@property(nonatomic,copy)NSString *urlstring;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger index;




@end
