//
//  STNewVideoHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/23.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STNewVideoHomeViewController.h"

#import "STVideoChannelViewController.h"
#import "STLocationChannelViewController.h"
#import "STSubscribeViewController.h"
#import "STScanViewController.h"
#import "STLoginViewController.h"

#import "STSearchView.h"
#import "JMDropMenu.h"

#import "LFMessageAlertView.h"
@interface STNewVideoHomeViewController ()<JMDropMenuDelegate>
{
    UILabel *_messageLabel;
}
@end

@implementation STNewVideoHomeViewController

- (void)viewDidLoad {
    self.titles = [self titleArray];
    self.viewArray = [self viewControllerArray];
    [super viewDidLoad];
    [(JXCategoryTitleView *)self.categoryView setTitles:[self titleArray]];
    [self topMuenAddButton];

}

- (NSArray *)titleArray {
    NSArray *_titleArray = @[@"推荐区",
                             @"本地区",
                             @"订阅区",
                             ];
    return _titleArray;
}

- (NSArray *)viewControllerArray {
    NSArray *_viewControllerArray = @[[[STVideoChannelViewController alloc] initWithStyle:UITableViewStyleGrouped],
                                      [[STLocationChannelViewController alloc] initWithStyle:UITableViewStyleGrouped],
                                      [STSubscribeViewController new],
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    UIView *view = [[UIView alloc] init];
    
    UIView *textBgView = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:textBgView];
    textBgView.layer.cornerRadius = 4.0f;
    textBgView.layer.backgroundColor = [[UIColor colorWithRed:28.0f/255.0f green:28.0f/255.0f blue:28.0f/255.0f alpha:1.0f] CGColor];
    textBgView.layer.shadowOpacity = 0.1f;
    textBgView.layer.shadowOffset = CGSizeZero;
    textBgView.layer.shadowRadius = 4.0f;

    _messageLabel = [[UILabel alloc] init];
    [textBgView addSubview:_messageLabel];
    _messageLabel.font = [UIFont boldSystemFontOfSize:10.f];
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = @"小丽看世界订阅了您的频道";
    [_messageLabel setTextColor:kWhiteColor];
    SetAnthorRichTextLabel(self->_messageLabel, FONT_10, @"小丽看世界", color_tipYellow_FECE24);
    _messageLabel.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width-50, 0);
    [_messageLabel sizeToFit];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    imageView.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    imageView.layer.borderWidth = 1;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 25;
    [imageView setCornerImage:IMAGE_NAME(STSystemDefaultImageName)];

    view.frame = CGRectMake(0, 0, _messageLabel.bounds.size.width+70, _messageLabel.bounds.size.height+20);
    textBgView.frame = CGRectMake(40, 8, _messageLabel.bounds.size.width+30, _messageLabel.bounds.size.height+24);
    _messageLabel.y = 12;

    [LFMessageAlertView showView:view ShowType:(LFMessageAlertViewShowLeft) Duration:3 TapBlock:^{
    }];
}

@end
