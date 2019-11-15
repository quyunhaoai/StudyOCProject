//
//  STChatHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/23.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STChatHomeViewController.h"
#import "STPowderMaterViewController.h"
#import "JXCategoryIndicatorDotLineView.h"
@interface STChatHomeViewController ()

@end
//120
@implementation STChatHomeViewController

- (void)viewDidLoad {
    self.titles = [self titleArray];
    self.viewArray = [self viewControllerArray];
    [super viewDidLoad];
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.85;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.85;
    titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
    titleCategoryView.titleColor =  COLOR_HEX_RGB(0xB2B2B2);
    titleCategoryView.titleSelectedColor = kWhiteColor;
    titleCategoryView.titleSelectedFont = STFont(17);
    titleCategoryView.titleFont = FONT_14;
    JXCategoryIndicatorDotLineView *lineView = [[JXCategoryIndicatorDotLineView alloc] init];
    lineView.indicatorColor = color_tipYellow_FECE24;
    titleCategoryView.indicators = @[lineView];
    titleCategoryView.titles = [self titleArray];
    
    
}

- (NSArray *)titleArray {
    NSArray *_titleArray = @[@"私聊",
                             @"群聊",
                             ];
    return _titleArray;
}

- (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[STPowderMaterViewController new],
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
