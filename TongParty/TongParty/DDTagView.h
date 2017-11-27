//
//  DDTagView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTag.h"
#import "DDTagButton.h"

@interface DDTagView : UIView

@property (assign, nonatomic) UIEdgeInsets padding;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;
@property (assign, nonatomic) CGFloat preferredMaxLayoutWidth;
@property (assign, nonatomic) BOOL singleLine;
@property (copy, nonatomic, nullable) void (^didTapTagAtIndex)(NSMutableArray * _Nullable tags,NSUInteger index);

- (void)addTag: (nonnull DDTag *)tag;
- (void)insertTag: (nonnull DDTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag: (nonnull DDTag *)tag;
- (void)removeTagAtIndex: (NSUInteger)index;
- (void)removeAllTags;

@end





