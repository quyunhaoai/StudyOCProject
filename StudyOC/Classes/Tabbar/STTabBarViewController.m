//
//  STTabBarViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STTabBarViewController.h"
#import "STBaseViewController.h"
#import "STBaseNav.h"

#import "STHomeViewController.h"
#import "STPersonalCenterViewController.h"
#import "STSocialViewController.h"
#import "STChatViewController.h"

#import "STFSHomeTopTabViewController.h"
#import "UITabBar+HNTabber.h"
@interface STTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) STBaseNav *navTabVC;
@end

@implementation STTabBarViewController

+ (instancetype)getTabBarController {
    static STTabBarViewController *tabbar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tabbar == nil) {
            tabbar = [[STTabBarViewController alloc] init];
        }
    });
    return tabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self builderTabbarView];
    
    [self showBageMethod];
}

- (void)showBageMethod {
//    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        @strongify(self);
        [self.tabBar showBadgeOnItemIndex:0 andWithBadgeNumber:15];
    });
}
- (void)builderTabbarView {
    self.delegate = self;
    self.tabBar.backgroundColor = kWhiteColor;
    STFSHomeTopTabViewController *navTabVC = [STFSHomeTopTabViewController new];
    navTabVC.title = @"首页";
//    navTabVC.view.backgroundColor = kRedColor;
//    navTabVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"首页"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STSocialViewController *collectionFoundVC = [STSocialViewController initWithSocialVC];
    collectionFoundVC.title = @"粉号";
//    collectionFoundVC.view.backgroundColor = kOrangeColor;
    
//    collectionFoundVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"服务"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STChatViewController *chatVC = [[STChatViewController alloc] init];
    chatVC.title = @"消息";
//    singVC.view.backgroundColor = kYellowColor;
//    singVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"发现"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STPersonalCenterViewController *personalCenterVC = [[STPersonalCenterViewController alloc] init];
    personalCenterVC.title = @"我的";
//    personalCenterVC.view.backgroundColor = kWhiteColor;
//    personalCenterVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"我"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 设置文字的样式
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = COLOR_666666;
//
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = COLOR_F42415;
    
    
    NSArray *viewCtrlArray = @[navTabVC, collectionFoundVC, chatVC, personalCenterVC];
    // 创建可变数组，存放导航控制器
    NSMutableArray *navCtrls = [NSMutableArray array];
    // 遍历视图控制器数组
    @autoreleasepool {
        for (UIViewController *viewCtrl in viewCtrlArray) {
            // 为视图控制器添加导航栏
//            [viewCtrl.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//            [viewCtrl.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            STBaseNav *navCtrl = [[STBaseNav alloc] initWithRootViewController:viewCtrl];
//            navCtrl.delegate = self;
            [navCtrls addObject:navCtrl];
        }
    }
    self.navTabVC = navCtrls[0];
    self.viewControllers = navCtrls;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (self.selectedViewController == viewController && self.selectedViewController == _navTabVC) {
//        if ([_swappableImageView.layer animationForKey:@"rotationAnimation"]) {
//            return YES;
//        }
//        _homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabber_loading_32*32_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        _homeNav.tabBarItem.image = [[UIImage imageNamed:@"home_tabber_loading_32*32_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [kNotificationCenter postNotificationName:STRefreshTableViewTopData object:nil];
        [self addAnnimation];
        
    }else {
//        _homeNav.tabBarItem.image = [[UIImage imageNamed:@"home_tabbar_32x32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        _homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_press_32x32_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [_swappableImageView stopRotationAnimation];
    }
    
    if (self.selectedViewController == viewController) {
//        STBaseNav *nav = (STBaseNav *)viewController;
//        if ([nav.viewControllers.firstObject respondsToSelector:@selector(needRefreshTableViewData)]) {
//            [nav.viewControllers.firstObject needRefreshTableViewData];
//        }
    }
    return YES;
}

- (void)addAnnimation {
    // 这里使用了 私有API 但是审核仍可以通过 有现成的案例
//    UIControl *tabBarButton = [_homeNav.tabBarItem valueForKey:@"view"];
//    UIImageView *tabBarSwappableImageView = [tabBarButton valueForKey:@"info"];
//    [tabBarSwappableImageView rotationAnimation];
//    _swappableImageView = tabBarSwappableImageView;
    [self.tabBar hideBadgeOnItemIndex:0];
}
@end
