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
#import "ChatListViewController.h"

#import "STFSHomeTopTabViewController.h"
#import "UITabBar+HNTabber.h"
#import "STVideoHomeViewController.h"
#import "STInteractionViewController.h"

#import "STNewVideoHomeViewController.h"
#import "STChatHomeViewController.h"
#import "STMySelfViewController.h"
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
    [kNotificationCenter addObserver:self selector:@selector(changeVc:) name:@"2222" object:nil];
//    [self showBageMethod];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:ColorWhiteAlpha20 size:CGSizeMake(Window_W, 0.7)]];
}
- (void)changeVc:(NSNotification *)not {
    NSString *obj = (NSString *)not.object;
    if ([obj isEqualToString:@"2"]) {
        self.tabBar.backgroundColor = kClearColor;
        self.tabBar.backgroundImage = [UIImage imageWithColor:kClearColor];
        [self.tabBar setShadowImage:[UIImage imageWithColor:ColorWhiteAlpha20 size:CGSizeMake(Window_W, 0.7)]];
    } else {
        self.tabBar.backgroundColor = kBlackColor;
        self.tabBar.backgroundImage = [UIImage imageWithColor:kBlackColor];
        [self.tabBar setShadowImage:[UIImage imageWithColor:kBlackColor size:CGSizeMake(Window_W, 0.7)]];
    }
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
    self.tabBar.backgroundColor = kBlackColor;
    self.tabBar.backgroundImage = [UIImage imageWithColor:kBlackColor];
    STMySelfViewController *navTabVC = [STMySelfViewController new];
    navTabVC.tabBarItem
    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"我的"]
                                    image:[[UIImage imageNamed:@"navigation_video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"navigation_video_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STSocialViewController *collectionFoundVC = [[STSocialViewController alloc] init];
    collectionFoundVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"主页"]
                                    image:[[UIImage imageNamed:@"navigationpowder"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"navigationpowder_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    STInteractionViewController *interactionVC = [STInteractionViewController new];
    interactionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"频道"]
                                    image:[[UIImage imageNamed:@"navigationinteraction"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"navigationinteraction_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    STChatHomeViewController *chatVC = [[STChatHomeViewController alloc] init];
    chatVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"消息"]
                                    image:[[UIImage imageNamed:@"navigationmessage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"navigationmessage_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STPersonalCenterViewController *personalCenterVC = [[STPersonalCenterViewController alloc] init];
    personalCenterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"应用"]
                                    image:[[UIImage imageNamed:@"navigate_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"navigate_my_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = COLOR_HEX_RGB(0xB2B2B2);
 
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = kWhiteColor;
    
    
    NSArray *viewCtrlArray = @[interactionVC, collectionFoundVC,  navTabVC,   chatVC, personalCenterVC];
    // 创建可变数组，存放导航控制器
    NSMutableArray *navCtrls = [NSMutableArray array];
    // 遍历视图控制器数组
    @autoreleasepool {
        for (UIViewController *viewCtrl in viewCtrlArray) {
            // 为视图控制器添加导航栏
            [viewCtrl.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            [viewCtrl.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            STBaseNav *navCtrl = [[STBaseNav alloc] initWithRootViewController:viewCtrl];
            [navCtrls addObject:navCtrl];
        }
    }
    self.viewControllers = navCtrls;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([item.title isEqualToString:@"频道"]) {
        self.tabBar.backgroundColor = kClearColor;
        self.tabBar.backgroundImage = [UIImage imageWithColor:kClearColor];
        [self.tabBar setShadowImage:[UIImage imageWithColor:ColorWhiteAlpha20 size:CGSizeMake(Window_W, 0.7)]];
    } else {
        self.tabBar.backgroundColor = kBlackColor;
        self.tabBar.backgroundImage = [UIImage imageWithColor:kBlackColor];
        [self.tabBar setShadowImage:[UIImage imageWithColor:kBlackColor size:CGSizeMake(Window_W, 0.7)]];
    }
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
