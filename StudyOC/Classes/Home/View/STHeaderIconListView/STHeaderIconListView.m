//
//  STHeaderIconListView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHeaderIconListView.h"

@implementation STHeaderIconCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView {
    [self.contentView addSubview:self.coverImage];
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
@end
@interface STHeaderIconListView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation STHeaderIconListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(kWidth(30), kWidth(30));
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[STHeaderIconCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    collectionView.backgroundColor = [UIColor kkColorOrange];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self addSubview:collectionView];
}
#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    STHeaderIconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.coverImage setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
//    cell.nameLab.text = @"娜扎";
    //    if (indexPath.row < self.dataArray.count) {
    //        cell.model = (YHWatchingHistoryModel *)self.dataArray[indexPath.row];
    //    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([self.delegate respondsToSelector:@selector(didSelectCell::)]) {
    //        [self.delegate didSelectCell:indexPath];
    //    }
}

@end
