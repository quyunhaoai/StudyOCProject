//
//  STThreeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STThreeViewController.h"
#import "STChildrenViewController.h"
@interface STThreeViewController ()

@end

@implementation STThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sugeToChilderVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sugeToChilderVC:(UIButton *)button {
    STChildrenViewController *vc = [[STChildrenViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
