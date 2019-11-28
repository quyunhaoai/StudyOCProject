//
//  AppDelegate.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "AppDelegate.h"
#import "STTabBarViewController.h"
#import "STBaseNav.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LBPGuideView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {//程序加载完毕
    [self loadWindows];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
          
//    [LBPGuideView showGuideViewWithImages:@[@"IMG_1",@"IMG_2",@"IMG_3",@"IMG_4",@"IMG_5"]];
    
    
    return YES;
}

- (void)loadWindows {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    STTabBarViewController *vc = [STTabBarViewController new];
//    STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
    self.window.rootViewController = vc;
    self.window.backgroundColor = kWhiteColor;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationMaskPortrait;
}

- (void)addADLaunchController
{
//    UIViewController *rootViewController = self.window.rootViewController;
//    LPADLaunchController *launchController = [[LPADLaunchController alloc]init];
//    [rootViewController addChildViewController:launchController];
//    launchController.view.frame = rootViewController.view.frame;
//    [rootViewController.view addSubview:launchController.view];
}
#pragma mark - 注意：收到内存警告时调用，
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2. 清除缓存
    [(SDImageCache *)[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {//- 程序失去焦点
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {//- 程序进入后台

}


- (void)applicationWillEnterForeground:(UIApplication *)application {//- 程序从后台回到前台
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {//- 作为从后台到活动状态转换的一部分调用

}


- (void)applicationWillTerminate:(UIApplication *)application {//- 应用程序即将终止时调用。
    
}


@end
