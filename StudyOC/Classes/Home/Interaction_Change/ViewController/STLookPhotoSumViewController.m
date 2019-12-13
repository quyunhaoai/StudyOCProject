//
//  STLookPhotoSumViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLookPhotoSumViewController.h"
#import "STLookPhotoViewController.h"
#import "STXiaoshipinDetailViewController.h"
#import "SmallVideoPlayViewController.h"
#import "INDouyinRefreshViewController.h"
@interface STLookPhotoSumViewController ()<JXCategoryListContentViewDelegate>
{
    BOOL isOff;
}
@property (strong, nonatomic) UIViewController *currentVC;    //
@end

@implementation STLookPhotoSumViewController

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    INDouyinRefreshViewController *vc = [INDouyinRefreshViewController new];
    vc.view.frame = CGRectMake(0, 0, Window_W, Window_H);
    [self.view addSubview:vc.view];
    self.currentVC = vc;
    [self addChildViewController:vc];
    [kNotificationCenter addObserver:self selector:@selector(changeVc:) name:@"2222" object:nil];
}

- (void)changeVc:(NSNotification *)not {
    NSString *obj = (NSString *)not.object;
     if ([obj isEqualToString:@"2"]) {
         [self replaceController:self.currentVC newController:[INDouyinRefreshViewController new] andIndex:0];
     } else {
         [self replaceController:self.currentVC newController:[STLookPhotoViewController new] andIndex:1];
     }  	
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController andIndex:(NSInteger)index {
    if (index == 1) {
        newController.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    } else {
        newController.view.frame = CGRectMake(0, 0, Window_W, Window_H);
    }
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
