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
    self.navBarView.backgroundColor = kClearColor;
    [self.view addSubview:self.navBarView];
    self.categoryView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.view.bounds.size.width-157, NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT);
    self.categoryView.delegate = self;
    self.categoryView.backgroundColor = kClearColor;
    self.categoryView.selectedAnimationEnabled = YES;
    [self.navBarView addSubview:self.categoryView];
    
    [self.view addSubview:self.listContainerView];

    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    [self.view bringSubviewToFront:self.navBarView];
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.35;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.35;
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
    [self topMuenAddButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0, 0, Window_W, Window_H);
}

- (void)topMuenAddButton {
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.tag = BUTTON_TAG(111);
    rightBtn2.tag = BUTTON_TAG(112);
    [rightBtn1 setImage:IMAGE_NAME(@"search_home") forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(seachVc:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn2 setImage:IMAGE_NAME(@"pageOff") forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn1.titleLabel.font = FONT_10;
    rightBtn2.titleLabel.font = FONT_10;
    [rightBtn2 setTitleColor:kBlackColor forState:UIControlStateNormal];
    [rightBtn1 setTitleColor:kBlackColor forState:UIControlStateNormal];
    rightBtn2.frame = CGRectMake(Window_W-25-20, NAVIGATION_BAR_HEIGHT-31, 25, 25);
    rightBtn1.frame = CGRectMake(Window_W-25*2-30, NAVIGATION_BAR_HEIGHT-31, 25, 25);
    self.rightButton1 = rightBtn1;
    self.rightButton2 = rightBtn2;
    [self.navBarView addSubview:rightBtn1];
    [self.navBarView addSubview:rightBtn2];
}

#pragma mark  -  private method
- (void)seachVc:(UIButton *)button {
    
}
- (void)dropMenu:(UIButton *)button {

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
    self.currentIndex = index;
    if (self.currentIndex == 2) {
        [self.rightButton2 setImage:IMAGE_NAME(@"openLive") forState:UIControlStateNormal];
    } else if(self.currentIndex == 1){
        [self.rightButton2 setImage:IMAGE_NAME(@"pageOpen") forState:UIControlStateNormal];
    } else {
        [self.rightButton2 setImage:IMAGE_NAME(@"pageOff") forState:UIControlStateNormal];
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
    self.currentIndex = index;
    if (self.currentIndex == 2) {
        [self.rightButton2 setImage:IMAGE_NAME(@"openLive") forState:UIControlStateNormal];
    } else if(self.currentIndex == 1){
        [self.rightButton2 setImage:IMAGE_NAME(@"pageOpen") forState:UIControlStateNormal];
    } else {
        [self.rightButton2 setImage:IMAGE_NAME(@"pageOff") forState:UIControlStateNormal];
    }
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
