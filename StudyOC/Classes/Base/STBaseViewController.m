//
//  STBaseViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseViewController.h"
@interface STBaseViewController ()
@property (strong, nonatomic) KKNavTitleView *navTitleView; //  视图

@end

@implementation STBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
    
}

- (void)customNavBarWithTitle:(NSString *)title {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleLabel.text = title;
    
}

- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName {
    [self customNavBarWithTitle:title];
    if (imageName.length>0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [backButton setImage:IMAGE_NAME(imageName) forState:UIControlStateNormal];
        [backButton setImage:IMAGE_NAME(imageName) forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    } else {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        //        [backButton setImage:@"" forState:UIControlStateNormal];
        //        [backButton setImage:@"" forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    }
}

- (void)customNavBarWithtitle:(NSString *)title andLeftView:(NSString *)imageName andRightView:(NSArray *)array {
    [self customNavBarwithTitle:title andLeftView:imageName];
    self.navTitleView.rightBtns = array;
}

- (void)customNavBarwithTitle:(NSString *)title andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews {
    [self customNavBarWithTitle:title];
    self.navTitleView.leftBtns = leftViews;
    self.navTitleView.rightBtns = rightViews;
}

- (void)customNavBarWithTitleView:(UIView *)titleView andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleView = titleView;
    self.navTitleView.leftBtns = leftViews;
    self.navTitleView.rightBtns = rightViews;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  -  Get

- (KKNavTitleView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = ({
            KKNavTitleView *view = [KKNavTitleView new];
            view.contentOffsetY = (STATUS_BAR_HEIGHT-(13.5))/2 ;
            view.backgroundColor = kWhiteColor;
            view ;
        });
    }
    return _navTitleView;
}

@end
