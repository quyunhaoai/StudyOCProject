//
//  STAlbumSumViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STAlbumSumViewController.h"
#import "STAlbumViewController.h"
#import "STVideoDetailViewController.h"
@interface STAlbumSumViewController ()<JXCategoryListContentViewDelegate>
{
    BOOL isOff;
}
@property (strong, nonatomic) UIViewController *currentVC;
@end

@implementation STAlbumSumViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    STVideoDetailViewController *vc =[[STVideoDetailViewController alloc] init];
    vc.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    self.currentVC = vc;
    [kNotificationCenter addObserver:self selector:@selector(changeVc:) name:@"1111" object:@""];
    self.tabBarController.tabBar.backgroundColor = kClearColor;
    self.tabBarController.tabBar.layer.backgroundColor = kClearColor.CGColor;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:kClearColor];
}

- (void)changeVc:(NSNotification *)not {
     isOff = !isOff;
    if (!isOff) {
        [self replaceController:self.currentVC newController:[STVideoDetailViewController new] andIndex:0];
    } else {
        [self replaceController:self.currentVC newController:[STAlbumViewController new] andIndex:1];
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController andIndex:(NSInteger)index {
    newController.view.frame =  CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    [self addChildViewController:newController];
    XYWeakSelf;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self transitionFromViewController:oldController
                      toViewController:newController
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
                                if (finished) {
                                    [newController didMoveToParentViewController:self];
                                    [oldController willMoveToParentViewController:nil];
                                    [oldController removeFromParentViewController];
                                    weakSelf.currentVC = newController;
                                } else {
                                    weakSelf.currentVC = oldController;
                                }
                            }];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

@end
