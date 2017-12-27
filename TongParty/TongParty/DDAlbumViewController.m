//
//  DDAlbumViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/9.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDAlbumViewController.h"
#import "PhotoViewController.h"
#import "LSAlbumEtity.h"
#import "xiangceCell.h"
#import "ManagerReusableView.h"
#import "UIImageView+WebCache.h"

@interface DDAlbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,LSUpLoadImageManagerDelegate>
@property(nonatomic,strong)UICollectionView *momentCollectionView; //视图
@property(nonatomic,strong)NSMutableArray *allArray;
@property(nonatomic,strong)NSMutableArray *indexArray; //选中数组
@property(nonatomic,strong)NSMutableDictionary *seleDIC; //选中下标
@property(nonatomic,strong)NSMutableDictionary *photoDic; //图片数据
@property(nonatomic,assign)NSInteger type; //选中标识
@property(nonatomic,strong)NSArray *photos;
@end

@implementation DDAlbumViewController{
    UIImageView *showView;
    UIButton * _rBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setConfig];
    [self customNavi];
}

- (void)loadData {
    [super loadData];
    _photos = [NSArray new];
    if (_style == DDAlbumCurrentUserStyle) {
        [DDTJHttpRequest getUserAlbumWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
            _photos = [LSAlbumEtity mj_objectArrayWithKeyValuesArray:dict];
            [_momentCollectionView reloadData];
        } failure:^{
            
        }];
    } else {
        [DDTJHttpRequest getOtherUserAlbumByFid:_fid block:^(NSDictionary *dict) {
            _photos = [LSAlbumEtity mj_objectArrayWithKeyValuesArray:dict];
            [_momentCollectionView reloadData];
        } failure:^{
            
        }];
    }
}

- (void)setConfig {
    _type =1;
    [self _initView];
}

#pragma mark =============创建视图

- (void)_initView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width/3.0-3,[[UIScreen mainScreen] bounds].size.width/3.0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 3;
    layout.sectionInset = UIEdgeInsetsMake(1.f, 1, 1.f, 1);
    
    _momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) collectionViewLayout:layout];
    
    _momentCollectionView.delegate = self;
    _momentCollectionView.dataSource =self;
    _momentCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_momentCollectionView];
    
    [_momentCollectionView registerNib:[UINib nibWithNibName:@"xiangceCell" bundle:nil] forCellWithReuseIdentifier:@"xiangceCell"];
    [_momentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:addidentify];
    
    //背景
    showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-46 , [[UIScreen mainScreen] bounds].size.width, 49)];
    showView.backgroundColor = [UIColor grayColor];
    showView.userInteractionEnabled = YES;
    showView.hidden = YES;
    [self.view addSubview:showView];
    
    
    UIButton *dele_btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,showView.frame.size.width,showView.frame.size.height)];
    [dele_btn setTitle:@"删除" forState:UIControlStateNormal];
    [dele_btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    dele_btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [dele_btn addTarget:self action:@selector(showbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:dele_btn];
    
}


- (void)rightAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _type =2;
        [_rBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        _type=1;
        [_rBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [_momentCollectionView reloadData];
}

//删除
- (void)showbtnAction:(UIButton *)btn{
    UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:@"是否确认删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerview show];
}

#pragma mark - CollectionView
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_style == DDAlbumCurrentUserStyle) {
        return self.photos.count + 1;
    } else {
        return self.photos.count;
    }
}

static NSString *addidentify = @"addCell";
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"xiangceCell";
    
    xiangceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imgview.backgroundColor = [UIColor grayColor];
    if (indexPath.row == self.photos.count) {
        
        UICollectionViewCell *addcell = [collectionView dequeueReusableCellWithReuseIdentifier:addidentify forIndexPath:indexPath];
        UIImageView *iv_add = [UIImageView new];
        [addcell.contentView addSubview:iv_add];
        [iv_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(addcell.contentView);
            make.top.equalTo(addcell.contentView).offset(10.f);
        }];
        iv_add.image = kImage(@"album_add");
        return addcell;
    }
    LSAlbumEtity *model = [self.photos objectAtIndex:indexPath.row];
    cell.imgview.contentMode = UIViewContentModeScaleToFill;
    if([(NSString *)(model.image) rangeOfString:@"http"].location !=NSNotFound) { //网络图片
        [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.image]];//有中文须先转码
    }else{
        cell.imgview.image = [UIImage imageNamed:model.image];
    }
    cell.sele_button.userInteractionEnabled = YES;
    cell.sele_button.tag = [model.id integerValue];
    //选中效果
    if (_type ==1) {
        cell.sele_button.hidden = YES;
    }else{
        cell.sele_button.hidden = NO;
        [cell.sele_button setImage:kImage(@"album_delete") forState:UIControlStateNormal];
    }
    
    //组选 （选中一组）
    if ( [model.indexpath isEqual:indexPath]) {
        [cell.sele_button setImage:kImage(@"album_delete") forState:UIControlStateNormal];
    }else{
        [cell.sele_button setImage:kImage(@"album_delete") forState:UIControlStateNormal];
    }
    [cell.sele_button addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.photos.count) {
        NSLog(@"添加照片");
        [LSUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
        return;
    }
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    NSMutableArray *imageArr = [NSMutableArray new];
    for (LSAlbumEtity *entity in self.photos) {
        [imageArr addObject:entity.image];
    }
    photoVC.urls = imageArr;
    photoVC.index = indexPath.row;
    [self presentViewController:photoVC animated:YES completion:NULL];
    
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [_indexArray enumerateObjectsUsingBlock:^(LSAlbumEtity *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
        [_photoDic removeAllObjects];
        [_indexArray removeAllObjects];
        [_allArray removeAllObjects];
        [_seleDIC removeAllObjects];
        [_momentCollectionView reloadData];
    }
}

#pragma mark - LSUpLoadImageManagerDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    [DDTJHttpRequest uploadUserAlbumWithToken:[DDUserSingleton shareInstance].token images:@[image] block:^(NSDictionary *dict) {
        [self loadData];
    } failure:^{
        
    }];
}


#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender {
    [DDTJHttpRequest deleteUserAlbumWithToken:[DDUserSingleton shareInstance].token photoId:[NSString stringWithFormat:@"%ld",sender.tag] block:^(NSDictionary *dict) {
        [self loadData];
    } failure:^{
        
    }];
}

#pragma mark - 设置导航栏
- (void)customNavi {
    [self navigationWithTitle:@"个人相册"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    //导航栏右键
    if (_style == DDAlbumCurrentUserStyle) {
        _rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _rBtn.titleLabel.font = DDFitFont(14.f);
        _rBtn.frame = CGRectMake(0, 0, DDFitWidth(50.f),DDFitWidth(50.f));
        [_rBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_rBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rBtn];
    }
}

// 编辑照片
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





