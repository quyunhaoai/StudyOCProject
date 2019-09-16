//
//  STThreeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STThreeViewController.h"
#import "STChildrenViewController.h"
#import "UIButton+RepeatEventInterval.h"
@interface STThreeViewController ()

@end

@implementation STThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"第三页";
//    self.tabBarItem.title = @"123";
//    self.tabBarController.tabBarItem.title = @"第三页";
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    static int i = 0;
    UIButton *button = [UIButton buttonWithClickBlock:^(UIButton *btn) {
        NSLog(@"%d", i++);
        [self sugeToChilderVC:btn];
    }];
    [self.view addSubview:button];
    button.repeatEventInterval = 1;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sugeToChilderVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sugeToChilderVC:(UIButton *)button {
    STChildrenViewController *vc = [[STChildrenViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
