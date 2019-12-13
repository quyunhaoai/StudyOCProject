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
//    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if([keyPath isEqualToString:@"currentIndex"]) {
//        if(self.currentIndex == 1 ){
//            UIButton *button = [self.navBarView viewWithTag:BUTTON_TAG(112)];
//            if (!button.isSelected) {
////                self.tabBarController.tabBar.backgroundColor = kClearColor;
////                self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:kClearColor];
//                [self.tabBarController.tabBar setShadowImage:[UIImage imageWithColor:kClearColor size:CGSizeMake(Window_W, 0.7)]];
//            }
//        }else {
////            self.tabBarController.tabBar.backgroundColor = kBlackColor;
////            self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:kBlackColor];
//            [self.tabBarController.tabBar setShadowImage:[UIImage imageWithColor:kClearColor size:CGSizeMake(Window_W, 0.7)]];
//        }
//    }else {
//        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//
//}
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark  -  private method
- (void)dropMenu:(UIButton *)button {
    if ([self.titles[self.currentIndex] isEqualToString:@"专辑"]) {
        button.selected = !button.isSelected;
        [kNotificationCenter postNotificationName:@"1111" object:@""];
    } else if ([self.titles[self.currentIndex] isEqualToString:@"随拍"]){
    button.selected = !button.isSelected;
        if (!button.isSelected) {//底部导航透明白色
            [kNotificationCenter postNotificationName:@"2222" object:@"2"];
        } else {
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
