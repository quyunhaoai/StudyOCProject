//
//  STVideoHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/15.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoHomeViewController.h"
#import "FSScrollContentView.h"
#import "STChildrenViewController.h"
#import "KKSearchBar.h"
#import "KKNavTitleView.h"
#import "UIButton+Badge.h"
#import "JMDropMenu.h"

#import "STRecommendViewController.h"
#import "STMyHomeViewController.h"
#import "STZhengZhouViewController.h"
#import "STRankingListViewController.h"
#import "STTagHomeTopViewController.h"

#import "STVideoChannelViewController.h"
#import "STLocationChannelViewController.h"
#import "STSubscribeViewController.h"
#import "STScanViewController.h"

#import "STSearchView.h"
@interface STVideoHomeViewController ()<YNPageViewControllerDelegate,YNPageViewControllerDataSource,YNPageScrollMenuViewDelegate,JMDropMenuDelegate>


@end

@implementation STVideoHomeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
+ (instancetype)initWithHomeVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleNavigation;
    configration.showNavigation = YES;
    configration.showTabbar = YES;
    configration.showBottomLine = YES;
    configration.bottomLineHeight = 0.5;
    configration.bottomLineBgColor = kBlackColor;
    configration.scrollViewBackgroundColor = kBlackColor;
    configration.showScrollLine = YES;
    configration.showGradientColor = YES;
    configration.selectedItemColor = kWhiteColor;
    configration.normalItemColor = COLOR_HEX_RGB(0xB2B2B2);
    configration.aligmentModeCenter = NO;
    configration.lineHeight = 4;
    configration.itemFont = STFont(17);
    configration.selectedItemFont = STBoldFont(17);
    configration.lineBottomMargin = 10;
//    configration.lineLeftAndRightAddWidth = 5;
    configration.lineColor = color_tipYellow_FECE24;
    STVideoHomeViewController *vc = [STVideoHomeViewController pageViewControllerWithControllers:[self viewControllerArray] titles:[self titleArray] config:configration];
    vc.delegate = vc;
    vc.dataSource = vc;
    return vc;
    
}

+ (NSArray *)titleArray {
    NSArray *_titleArray = @[@"频道区",
                             @"本地区",
                             @"订阅区",
                             ];
    return _titleArray;
}

+ (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[STVideoChannelViewController new],
                                      [STLocationChannelViewController new],
                                      [STSubscribeViewController new],
                                     ];
    return _viewControllerArray;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    STBaseTableViewController *baseVC = pageViewController.controllersM[index];
    return [baseVC tableView];
}
#pragma mark  -  ynp delegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffsetY
                  progress:(CGFloat)progress{
    NSLog(@"contentOffsetY:%f  progress:%f",contentOffsetY,progress);
}

- (void)pagescrollMenuViewAddButtonAction:(UIButton *)button {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topMuenAddButton];
    /*小红点
    UIButton *oneTitleButton =(UIButton *)self.scrollMenuView.itemsArrayM[0];
    [oneTitleButton setBadgeValue:@"1"];
    [oneTitleButton setBadgeBGColor:kRedColor];
    [oneTitleButton setBadgeTextColor:kRedColor];
    [oneTitleButton setBadgeMinSize:3];*/
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
    rightBtn2.frame = CGRectMake(Window_W-35-30, 8, 35, 27);
    rightBtn1.frame = CGRectMake(Window_W-35*2-40, 8, 35, 27);
    [self.scrollMenuView addSubview:rightBtn1];
    [self.scrollMenuView addSubview:rightBtn2];
}

#pragma mark  -  private method
- (void)dropMenu:(UIButton *)button {
    [JMDropMenu showDropMenuFrame:CGRectMake(Window_W - 128, NAVIGATION_BAR_HEIGHT, 123, 86) ArrowOffset:92.f TitleArr:@[@"发布视频",@"发布图文"] ImageArr:@[@"upload_video_home",@"live_home"] Type:JMDropMenuTypeWeChat LayoutType:JMDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self];
}

- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
//    if (index == 3) {
//        [self scanMethod];
//    }
}
/**
 扫一扫
 */
- (void)scanMethod {
    STScanViewController *vc = [STScanViewController new];
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.colorAngle = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
    style.animationImage = imgLine;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    vc.style = style;
    vc.isOpenInterestRect = YES;
    
    vc.libraryType = 0;//Native
    vc.scanCodeType = 0;//QR二维码
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)seachVc:(UIButton *)button {
    STSearchView *searchVC = [[STSearchView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_H)];
//    [self.view addSubview:searchVC.view];
    [[UIApplication sharedApplication].keyWindow addSubview:searchVC];
//    [kAppWindow addSubview:searchVC.view];
//    [view addSubview:];
//    [view addSubview:_contentView];
    
//    [_contentView setFrame:CGRectMake(0, Window_H, Window_W, maskHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        searchVC.alpha = 1.0;
        searchVC.frame = CGRectMake(0, 0, Window_W, Window_H);
//        [self->_contentView setFrame:CGRectMake(0, Window_H - maskHeight , Window_W, maskHeight)];
        
    } completion:nil];
    
//    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark  -  Get








@end
