//
//  STPrivateChatViewController.m
//  StudyOC
//
//  Created by 光引科技 on 2019/12/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#import "STFollowTipView.h"
#import "STPrivateChatViewController.h"
#import "ChatListController.h"
@interface STPrivateChatViewController ()<JXCategoryListContentViewDelegate>
@property (strong, nonatomic) STFollowTipView *tipView; //  视图

@end

@implementation STPrivateChatViewController

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tipView];
    [self.tipView masMakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(5);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(20);
    }];
    [self.tipView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.tipView);
        make.left.mas_equalTo(self.tipView).mas_offset(30);
        make.width.mas_equalTo(Window_W - 60);
    }];
    [self.tipView.closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipView.titleLabel.mas_right).mas_offset(7);
        make.centerY.mas_equalTo(self.tipView);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"找人聊两句" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_12;
    [button setBackgroundColor:KKColor(255, 33, 144, 1)];
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
}
- (void)chickBtn:(UIButton *)button {
    ChatListController *vc = [ChatListController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (STFollowTipView *)tipView {
    if (!_tipView) {
        _tipView = ({
            STFollowTipView *view = [STFollowTipView new];
            view.titleLabel.text = @"当前没有私聊记录！";
            view.backgroundColor = KKColor(3, 52, 59, 1);
            view;
        });
    }
    return _tipView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
