//
//  STMyHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STMyHomeViewController.h"
#import "KKLoadingView.h"
@interface STMyHomeViewController ()
@property (strong, nonatomic) KKLoadingView *loadingView; // 视图

@end

@implementation STMyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.loadingView];
    [self.loadingView masMakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.loadingView setHidden:NO];
}


#pragma  mark  --  加载中 懒加载
- (KKLoadingView *)loadingView {
    
    if (!_loadingView) {
        _loadingView =({
            KKLoadingView *view = [[KKLoadingView alloc] init];
            
            
            
            
            view;
        });
    }
    return _loadingView;
}

@end
