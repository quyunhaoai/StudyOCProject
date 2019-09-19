//
//  STHomeTopBarViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/16.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHomeTopBarViewController.h"

#import "STBaseTableViewController.h"

#import "UIView+YNPageExtend.h"
@interface STHomeTopBarViewController ()<YNPageViewControllerDelegate,YNPageViewControllerDataSource>

@end

@implementation STHomeTopBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedPageIndex:1];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 0)];
    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    self.navigationController.navigationItem.titleView = headerView;
    self.view.yn_y = NAVIGATION_BAR_HEIGHT;
    self.view.yn_height = Window_H - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 44;
}

+ (instancetype)initWithHomeTopBarVC {
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleTop;
    configration.showNavigation = YES;
    configration.showTabbar = YES;
    configration.showBottomLine = YES;
    configration.bottomLineHeight = 0.5;
    configration.bottomLineBgColor = COLOR_e5e5e5;
    configration.showGradientColor = YES;
    configration.selectedItemColor = kRedColor;
    configration.aligmentModeCenter = NO;
    configration.itemMargin = 20;
    configration.headerViewCouldScrollPage = NO;
    configration.headerViewCouldScale = NO;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    STHomeTopBarViewController *vc = [STHomeTopBarViewController pageViewControllerWithControllers:[self viewControllerArray] titles:[self titleArray] config:configration];
    vc.delegate = vc;
    vc.dataSource = vc;
    vc.pageIndex = 1;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 0)];
    headerView.backgroundColor = [UIColor redColor];
    vc.headerView = headerView;
    vc.view.yn_y = NAVIGATION_BAR_HEIGHT;
    vc.view.yn_height = Window_H - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 44;
    return vc;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

+ (NSArray *)titleArray {
    NSArray *_titleArray = @[@"我的",
                             @"推荐",
                             @"郑州",
                             @"排行榜",
                             @"标签"];
    return _titleArray;
}

+ (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[STBaseTableViewController new],
                                      [STBaseTableViewController new],
                                      [STBaseTableViewController new],
                                      [STBaseTableViewController new],
                                      [STBaseTableViewController new],];
    return _viewControllerArray;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    STBaseTableViewController *baseVC = pageViewController.controllersM[index];
    return [baseVC tableView];
}
@end
