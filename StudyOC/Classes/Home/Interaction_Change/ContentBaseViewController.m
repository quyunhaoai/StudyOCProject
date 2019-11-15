//
//  BaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ContentBaseViewController.h"
#import "STPowderMaterViewController.h"
#import "JXCategoryIndicatorDotLineView.h"
@interface ContentBaseViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@end

@implementation ContentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = color_viewBG_1A1929;
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, NAVIGATION_BAR_HEIGHT)];
    self.navBarView.backgroundColor = kBlackColor;
    [self.view addSubview:self.navBarView];
    self.categoryView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.view.bounds.size.width-157, NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT);
    self.categoryView.delegate = self;
    self.categoryView.backgroundColor = kBlackColor;
    self.categoryView.selectedAnimationEnabled = YES;
    [self.navBarView addSubview:self.categoryView];
    
    [self.view addSubview:self.listContainerView];

    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.85;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.85;
    titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
    titleCategoryView.titleColor =  COLOR_HEX_RGB(0xB2B2B2);
    titleCategoryView.titleSelectedColor = kWhiteColor;
    titleCategoryView.titleSelectedFont = STFont(17);
    titleCategoryView.titleFont = FONT_14;
    JXCategoryIndicatorDotLineView *lineView = [[JXCategoryIndicatorDotLineView alloc] init];
    lineView.indicatorColor = color_tipYellow_FECE24;
    titleCategoryView.indicators = @[lineView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.listContainerView.frame = CGRectMake(0, [self preferredCategoryViewHeight], self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return NAVIGATION_BAR_HEIGHT;
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [self preferredCategoryView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return self.viewArray[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
