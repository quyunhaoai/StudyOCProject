//
//  STSubscribeVideoViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/11.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSubscribeViewsController.h"
#import "STSubscribeVideoViewController.h"
#import "STSubscribeLookPhotoViewController.h"
@interface STSubscribeViewsController ()<JXCategoryListContentViewDelegate>
@property (nonatomic,strong) UIButton *subscribeButton; //  按钮
@property (nonatomic,strong) UIButton *lookPhotoButton; //  按钮
@property (strong, nonatomic) UIViewController *currentVC; //  视图

@end

@implementation STSubscribeViewsController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(8);
        make.top.mas_equalTo(self.view).mas_offset(5);
        make.width.mas_equalTo((Window_W-32)/2);
        make.height.mas_equalTo(29);
    }];
    button1.layer.cornerRadius = 1;
    button1.layer.masksToBounds = YES;
    [button1 setTitle:@"订阅的专辑" forState:UIControlStateNormal];
    [button1.titleLabel setFont:FONT_11];
    [button1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button1 setBackgroundColor:KKColor(0, 166, 193, 1)];
    [button1 setTag:BUTTON_TAG(101)];
    [button1 addTarget:self
                action:@selector(buttonClickMethod:)
      forControlEvents:UIControlEventTouchUpInside];
    self.subscribeButton = button1;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button1.mas_right).mas_offset(16);
        make.top.mas_equalTo(self.view).mas_offset(5);
        make.width.mas_equalTo((Window_W-32)/2);
        make.height.mas_equalTo(29);
    }];
    button2.layer.cornerRadius = 1;
    button2.layer.masksToBounds = YES;
    [button2 setTitle:@"订阅的随拍" forState:UIControlStateNormal];
    [button2.titleLabel setFont:FONT_11];
    [button2 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button2 setBackgroundColor:KKColor(58, 58, 68, 1)];
    [button2 setTag:BUTTON_TAG(102)];
    [button2 addTarget:self
                action:@selector(buttonClickMethod:)
      forControlEvents:UIControlEventTouchUpInside];
    self.lookPhotoButton = button2;
    
    STSubscribeVideoViewController *vc = [STSubscribeVideoViewController new];
    vc.view.frame = CGRectMake(0, 40, Window_W, self.view.height-40);
    [self.view addSubview:vc.view];
    self.currentVC = vc;
    [self addChildViewController:vc];
}

- (void)buttonClickMethod:(UIButton *)button {
    if (button.tag == BUTTON_TAG(101)) {
        [button setBackgroundColor:KKColor(0, 166, 193, 1)];
        [self.lookPhotoButton setBackgroundColor:KKColor(58, 58, 68, 1)];
        [self replaceController:self.currentVC newController:[STSubscribeVideoViewController new] andIndex:1];
    } else {
        [button setBackgroundColor:KKColor(0, 166, 193, 1)];
        [self.subscribeButton setBackgroundColor:KKColor(58, 58, 68, 1)];
        [self replaceController:self.currentVC newController:[STSubscribeLookPhotoViewController new] andIndex:0];
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController andIndex:(NSInteger)index {
    newController.view.frame = CGRectMake(0, 40, Window_W, self.view.height-40);
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
                                }
                                else {
                                    weakSelf.currentVC = oldController;
                                }
                            }];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

@end
