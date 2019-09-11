//
//  AppDelegate.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "AppDelegate.h"
#import "STTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {//程序加载完毕
    [self loadWindows];
    return YES;
}

- (void)loadWindows {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [STTabBarViewController new];
    [self.window makeKeyAndVisible];
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
