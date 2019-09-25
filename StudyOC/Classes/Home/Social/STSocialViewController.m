//
//  STSocialViewController
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSocialViewController.h"
#import "STBaseTableViewController.h"
@interface STSocialViewController ()<YNPageViewControllerDataSource,YNPageViewControllerDelegate>


@end

@implementation STSocialViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (instancetype)initWithSocialVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleTop;
    configration.showNavigation = YES;
    configration.showTabbar = YES;
    configration.showBottomLine = YES;
    configration.bottomLineHeight = 0.5;
    configration.bottomLineBgColor = COLOR_e5e5e5;
    configration.showScrollLine = NO;
    configration.showGradientColor = YES;
    configration.selectedItemColor = kRedColor;
    configration.aligmentModeCenter = NO;
    STSocialViewController *vc = [STSocialViewController pageViewControllerWithControllers:[self viewControllerArray] titles:[self titleArray] config:configration];
    vc.delegate = vc;
    vc.dataSource = vc;
    return vc;
    
}

+ (NSArray *)titleArray {
    NSArray *_titleArray = @[@"开放的",
                             @"好友的",
                             @"应用",
                             @"标签"];
    return _titleArray;
}

+ (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[STBaseTableViewController new],
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
