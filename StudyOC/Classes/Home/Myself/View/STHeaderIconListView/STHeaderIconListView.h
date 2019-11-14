//
//  STHeaderIconListView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//
//static NSString *identifier = @"STheaderIconListView";
#import <UIKit/UIKit.h>
#import "STBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface STHeaderIconCollectionViewCell : STBaseCollectionViewCell


@end
@interface STHeaderIconListView : UIView
@property (strong, nonatomic) UICollectionView *collectionView; //  视图

@end

NS_ASSUME_NONNULL_END
