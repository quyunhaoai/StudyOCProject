//
//  STAtFriendView.m
//  StudyOC
//
//  Created by 光引科技 on 2019/12/16.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STAtFriendView.h"
#import "ZJContactViewController.h"
@implementation STAtFriendView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUI];
    }
    
    return self;
}


- (void)setUI {
    self.dragContentView.backgroundColor = color_viewBG_1A1929;
    self.navTitleView.title = @"@好友";
    self.navTitleView.titleLabel.textColor = kWhiteColor;
    self.navTitleView.splitView.hidden = YES;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(startHide) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
    
//    ZJContactViewController *vc = [[ZJContactViewController alloc] init];
//    vc.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT);
//    vc.tableView.tag = KKViewTagPersonInfoScrollView;
//    [self.dragContentView addSubview:vc.view];
    
    
}

@end
