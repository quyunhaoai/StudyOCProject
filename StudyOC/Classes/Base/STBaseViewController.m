//
//  STBaseViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseViewController.h"

@interface STBaseViewController ()


@end

@implementation STBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_viewBG_1A1929;
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma  mark  --  显示加载错误页面 懒加载
- (void)setIsShowErrorPageView:(BOOL)isShowErrorPageView {
    _isShowErrorPageView = isShowErrorPageView;
    
}
//- (BOOL)isShowErrorPageView {
//
//    if (!_isShowErrorPageView) {
//        _isShowErrorPageView =({
//            UIView *view = [UIView new];
//            view;
//
//
//
//        });
//    }
//    return _isShowErrorPageView;
//}
- (void)setIsShowNoDataPageView:(BOOL)isShowNoDataPageView {
    _isShowNoDataPageView = isShowNoDataPageView;
    if (_isShowNoDataPageView) {
        [self.view addSubview:self.noDataView];
        [self.noDataView masMakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(0);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
        [self.view bringSubviewToFront:self.noDataView];
    } else {
        [self.noDataView removeFromSuperview];
    }
}
#pragma  mark  --  noData 懒加载
- (KKNoDataView *)noDataView {
    
    if (!_noDataView) {
        _noDataView = ({
            KKNoDataView *view = [KKNoDataView new];
            view.tipImage = [UIImage imageNamed:@"not_found_loading_226x119_"];
            view.tipText = @"在这个星球找不到你需要的信息";
            view.backgroundColor = color_viewBG_1A1929;
            view ;
        });
    }
    return _noDataView;
}

- (void)customNavBarWithTitle:(NSString *)title {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleLabel.text = title;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backButton setImage:IMAGE_NAME(@"nav_backIcon") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"nav_backIcon") forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
}

- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName {
    [self customNavBarWithTitle:title];
    if (imageName.length>0) {
//        [self.navTitleView.leftBtns reverseObjectEnumerator];
        for (UIButton *btn in self.navTitleView.leftBtns) {
            [btn removeFromSuperview];
        }
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:imageName forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [backButton setImage:IMAGE_NAME(@"close_navIcon2") forState:UIControlStateNormal];
        [backButton setImage:IMAGE_NAME(@"close_navIcon2") forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [backButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
        [backButton sizeToFit];

        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    } else {

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
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark  -  Get

- (KKNavTitleView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = ({
            KKNavTitleView *view = [KKNavTitleView new];
            view.contentOffsetY = STATUS_BAR_HEIGHT >20 ? (STATUS_BAR_HEIGHT-(13.5))/2 : 10 ;
            view.backgroundColor = kWhiteColor;
            view ;
        });
    }
    return _navTitleView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}
@end
