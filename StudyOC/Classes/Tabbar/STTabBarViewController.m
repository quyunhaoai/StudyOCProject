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
#import "STKWWebViewController.h"
#import "STTwoViewController.h"
#import "STThreeViewController.h"
@interface STTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate>

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
}

- (void)builderTabbarView {
    self.delegate = self;
    self.tabBar.backgroundColor = kWhiteColor;
    STHomeViewController *navTabVC = [STHomeViewController alloc];
//    navTabVC.view.backgroundColor = kRedColor;
//    navTabVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"首页"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STTwoViewController *collectionFoundVC = [[STTwoViewController alloc] init];
//    collectionFoundVC.view.backgroundColor = kOrangeColor;
    
//    collectionFoundVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"服务"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STThreeViewController *singVC = [[STThreeViewController alloc] init];
//    singVC.view.backgroundColor = kYellowColor;
//    singVC.tabBarItem
//    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"发现"]
//                                    image:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                            selectedImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    STKWWebViewController *personalCenterVC = [[STKWWebViewController alloc] init];
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
    
    
    NSArray *viewCtrlArray = @[navTabVC, collectionFoundVC, singVC, personalCenterVC];
    // 创建可变数组，存放导航控制器
    NSMutableArray *navCtrls = [NSMutableArray array];
    // 遍历视图控制器数组
    @autoreleasepool {
        for (UIViewController *viewCtrl in viewCtrlArray) {
            // 为视图控制器添加导航栏
//            [viewCtrl.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//            [viewCtrl.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            STBaseNav *navCtrl = [[STBaseNav alloc] initWithRootViewController:viewCtrl];
            navCtrl.delegate = self;
            [navCtrls addObject:navCtrl];
        }
    }
    self.viewControllers = navCtrls;
}


@end
