//
//  STSocialBaseViewController.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/23.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface STSocialBaseViewController : UIViewController

@property (nonatomic, strong) NSArray *titles;
@property (strong, nonatomic) UIView *navBarView; // 视图
@property (strong, nonatomic) NSArray *viewArray;   //数组

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

@end

NS_ASSUME_NONNULL_END
