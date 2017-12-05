//
//  PhotoCollectionView.h
//  WXMovie
//
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *urls;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)NSInteger index;



@end
