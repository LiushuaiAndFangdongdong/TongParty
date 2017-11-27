
//
//  DDTagView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTagView.h"
#import "DDTagButton.h"

@interface DDTagView()
@property (strong, nonatomic, nullable) NSMutableArray *tags;
@property (assign, nonatomic) BOOL didSetup;
@property (nonatomic,assign)BOOL outOfBounds;
@property (nonatomic,strong) UIButton *selectedBtn;    //中间值,选中btn
@end

@implementation DDTagView

#pragma mark - Lifecycle

-(CGSize)intrinsicContentSize {
    if (!self.tags.count) {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    currentX += size.width;
                } else {
                    lineCount ++;
                    currentX = leftPadding + size.width;
                    intrinsicHeight += size.height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightPadding);
        }
        
        intrinsicHeight += bottomPadding + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
    
    [self layoutTags];
}

#pragma mark - Custom accessors

- (NSMutableArray *)tags {
    if(!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        _didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Private

- (void)layoutTags {
    self.frame = CGRectMake(90, 113, kScreenWidth -90, kScreenHeight);
    if (self.didSetup || !self.tags.count) {
        return;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        if (self.outOfBounds) return;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    if (CGRectGetMaxY(previousView.frame) + lineSpacing < self.bounds.size.height - bottomPadding) {
                        view.frame = CGRectMake(currentX, CGRectGetMinY(previousView.frame), size.width, size.height);
                        currentX += size.width;
                    }else{
                        [view removeFromSuperview];
                        self.outOfBounds = YES;
                        break;
                    }
                    
                } else {
                    CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                    if (CGRectGetMaxY(previousView.frame) + lineSpacing < self.bounds.size.height - bottomPadding) {
                        view.frame = CGRectMake(leftPadding, CGRectGetMaxY(previousView.frame) + lineSpacing, width, size.height);
                        currentX = leftPadding + width;
                    }else{
                        [view removeFromSuperview];
                        self.outOfBounds = YES;
                        break;
                    }
                }
            } else {
                CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, size.height);
                currentX += width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            view.frame = CGRectMake(currentX, topPadding, size.width, size.height);
            currentX += size.width;
            currentX += itemSpacing;
            
            previousView = view;
        }
    }
    NSLog(@"previousView==------%f,%f",previousView.frame.size.width,previousView.frame.size.height);
    NSLog(@"previousView==%@",NSStringFromCGRect(previousView.frame));
    
    self.didSetup = YES;
    
    self.frame = CGRectMake(90, 113, kScreenWidth -90 , previousView.frame.origin.y + previousView.frame.size.height + 10);
    
}

#pragma mark - IBActions

- (void)onTag: (UIButton *)btn {
    //取反
    btn.selected = !btn.selected;
    //第一个按钮为添加an'niu不参与
    if ([self.subviews indexOfObject: btn] != 0) {
            //选中变色
        if (btn.selected) {
            [btn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
            btn.layer.borderColor = kBgGreenColor.CGColor;
        }else{
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
            btn.layer.borderColor = kBgGrayColor.CGColor;
        }
        
        //只能选中其一
        if (btn != self.selectedBtn) {
            [self.selectedBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
            self.selectedBtn.layer.borderColor = kBgGrayColor.CGColor;
            self.selectedBtn.selected = NO;
            btn.selected = YES;
            [btn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
            btn.layer.borderColor = kBgGreenColor.CGColor;
            self.selectedBtn = btn;
        }else{
            self.selectedBtn.selected = YES;
        }
    }


    //点击回调
    if (self.didTapTagAtIndex) {
        self.didTapTagAtIndex(self.tags,[self.subviews indexOfObject: btn]);
    }
}


#pragma mark - Public

- (void)addTag: (DDTag *)tag {
    if (self.outOfBounds) return;
    
    NSParameterAssert(tag);
    DDTagButton *btn = [DDTagButton buttonWithTag: tag];
    [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: btn];
    [self.tags addObject: tag];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)insertTag: (DDTag *)tag atIndex: (NSUInteger)index {
    if(self.outOfBounds) return;
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) {
        [self addTag: tag];
    } else {
        DDTagButton *btn = [DDTagButton buttonWithTag: tag];
        [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
        [self insertSubview: btn atIndex: index];
        [self.tags insertObject: tag atIndex: index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)removeTag: (DDTag *)tag {
    NSParameterAssert(tag);
    NSUInteger index = [self.tags indexOfObject: tag];
    if (NSNotFound == index) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
        self.outOfBounds = NO;
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeTagAtIndex: (NSUInteger)index {
    if (index + 1 > self.tags.count) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags {
    [self.tags removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

@end






