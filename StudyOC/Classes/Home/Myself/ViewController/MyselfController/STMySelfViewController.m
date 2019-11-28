//
//  STMySelfViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STMySelfViewController.h"
#import "STPowderMaterViewController.h"
#import "JXCategoryIndicatorDotLineView.h"
#import "STMyCircleViewController.h"
@interface STMySelfViewController ()<JMDropMenuDelegate>

@end

@implementation STMySelfViewController

- (void)viewDidLoad {
    self.titles = [self titleArray];
    self.viewArray = [self viewControllerArray];
    [super viewDidLoad];
    [self topMuenAddButton];
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.35;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.35;
    titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
    titleCategoryView.titleColor =  COLOR_HEX_RGB(0xB2B2B2);
    titleCategoryView.titleSelectedColor = kWhiteColor;
    titleCategoryView.titleFont = FONT_14;
    titleCategoryView.titleSelectedFont = STFont(17);
    JXCategoryIndicatorDotLineView *lineView = [[JXCategoryIndicatorDotLineView alloc] init];
    lineView.indicatorColor = color_tipYellow_FECE24;
    titleCategoryView.indicators = @[lineView];
    titleCategoryView.titles = [self titleArray];
}

- (NSArray *)titleArray {
    NSArray *_titleArray = @[@"圈子",
                             @"管理",
                             ];
    return _titleArray;
}

- (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[STMyCircleViewController new],
                                      [STPowderMaterViewController new],
                                     ];
    return _viewControllerArray;
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
- (void)topMuenAddButton {
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn1 setImage:IMAGE_NAME(@"search_home") forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(seachVc:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn2 setImage:IMAGE_NAME(@"camera") forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn1.titleLabel.font = FONT_10;
    rightBtn2.titleLabel.font = FONT_10;
    [rightBtn2 setTitleColor:kBlackColor forState:UIControlStateNormal];
    [rightBtn1 setTitleColor:kBlackColor forState:UIControlStateNormal];
    rightBtn2.frame = CGRectMake(Window_W-25-20, NAVIGATION_BAR_HEIGHT-31, 25, 25);
    rightBtn1.frame = CGRectMake(Window_W-25*2-30, NAVIGATION_BAR_HEIGHT-31, 25, 25);
    [self.navBarView addSubview:rightBtn1];
    [self.navBarView addSubview:rightBtn2];
}

#pragma mark  -  private method
- (void)dropMenu:(UIButton *)button {
    JMDropMenu *menuView =  [[JMDropMenu  alloc]initWithFrame:CGRectMake(Window_W - 128, NAVIGATION_BAR_HEIGHT, 123, 88)
                                                  ArrowOffset:92.f TitleArr:@[@"发布视频",@"发布图文"]
                                                     ImageArr:@[@"upload_video_home",@"live_home"]
                                                         Type:JMDropMenuTypeWeChat
                                                   LayoutType:JMDropMenuLayoutTypeNormal
                                                    RowHeight:40.f
                                                     Delegate:self];
    menuView.lineColor = [UIColor colorWithRed:26.0f/255.0f green:26.0f/255.0f blue:38.0f/255.0f alpha:1.0f];
    menuView.titleColor = kWhiteColor;
}

- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
    if (index ==0) {//发视频
        STLoginViewController *vc = [[STLoginViewController alloc] init];
        vc.barStyle = [UIApplication sharedApplication].statusBarStyle;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else {//发图文
        STLoginViewController *vc = [[STLoginViewController alloc] init];
        vc.barStyle = [UIApplication sharedApplication].statusBarStyle;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
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
