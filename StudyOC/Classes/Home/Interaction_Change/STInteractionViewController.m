//
//  STInteractionViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/15.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STInteractionViewController.h"
#import "JXCategoryIndicatorDotLineView.h"
#import "JXCategoryIndicatorLineView.h"

#import "STAlbumViewController.h"
#import "STLookPhotoViewController.h"
#import "STSubscribeViewsController.h"

#import "STAlbumSumViewController.h"
#import "STLookPhotoSumViewController.h"
#import "STLocationChannelViewController.h"
@interface STInteractionViewController()

@end
@implementation STInteractionViewController

-(void)viewDidLoad {
    if (self.titles == nil) {
        self.titles =@[@"专辑",@"随拍",@"订阅"];
    }
    if (self.viewArray == nil) {
        self.viewArray =@[[STAlbumSumViewController new],
                          [STLookPhotoSumViewController new],
                          [[STLocationChannelViewController alloc] initWithStyle:UITableViewStyleGrouped],
                            ];
    }
    [super viewDidLoad];
    [(JXCategoryTitleView *)self.categoryView setTitles:@[@"专辑",
                                                          @"随拍",
                                                          @"直播"]];
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark  -  private method
- (void)dropMenu:(UIButton *)button {
    if ([self.titles[self.currentIndex] isEqualToString:@"专辑"]) {
        button.selected = !button.isSelected;
        [kNotificationCenter postNotificationName:@"1111" object:@""];
    } else if ([self.titles[self.currentIndex] isEqualToString:@"随拍"]){
    button.selected = !button.isSelected;
        if (!button.isSelected) {
            self.tabBarController.tabBar.backgroundColor = kClearColor;
            self.tabBarController.tabBar.layer.backgroundColor = kClearColor.CGColor;
            self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:kClearColor];
            [kNotificationCenter postNotificationName:@"2222" object:@"2"];
        } else {
            self.tabBarController.tabBar.backgroundColor = kBlackColor;
            self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:kBlackColor];
            [kNotificationCenter postNotificationName:@"2222" object:@"1"];
        }
    }
}

- (void)seachVc:(UIButton *)button {
    STSearchView *searchVC = [[STSearchView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_H)];
    searchVC.currentViewController = self;
    [[UIApplication sharedApplication].keyWindow addSubview:searchVC];
    [UIView animateWithDuration:0.3 animations:^{
        searchVC.alpha = 1.0;
        searchVC.frame = CGRectMake(0, 0, Window_W, Window_H);
    } completion:nil];
}
@end
