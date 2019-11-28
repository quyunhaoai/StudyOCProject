//
//  STMySelfBaseViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STMySelfBaseViewController.h"

@interface STMySelfBaseViewController ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>

@end

@implementation STMySelfBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = color_viewBG_1A1929;
    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, NAVIGATION_BAR_HEIGHT)];
    navBarView.backgroundColor = kBlackColor;
    self.navBarView = navBarView;
    [self.view addSubview:navBarView];
    self.categoryView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.view.bounds.size.width-157-65, NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT);
    self.categoryView.delegate = self;
    self.categoryView.backgroundColor = kBlackColor;
    [navBarView addSubview:self.categoryView];
    
    [self.view addSubview:self.listContainerView];

    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    

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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
