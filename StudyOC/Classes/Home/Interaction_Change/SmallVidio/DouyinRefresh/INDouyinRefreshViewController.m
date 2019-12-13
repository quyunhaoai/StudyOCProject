//
//  INDouyinRefreshViewController.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshViewController.h"
#import "INDouyinRefreshPresenter.h"
#import "STInteractionViewController.h"
#import "ContentBaseViewController.h"

@interface INDouyinRefreshViewController ()

@property (nonatomic, strong) INDouyinRefreshView *teamAnnounceView;
@property (nonatomic, strong) INDouyinRefreshInteractor *teamAnnounceInteractor;
@property (nonatomic, strong) INDouyinRefreshConfig *teamAnnounceConfig;
@property (nonatomic, strong) INDouyinRefreshPresenter *teamAnnouncePresenter;

@end

@implementation INDouyinRefreshViewController

#pragma mark - Configure NavigationBar
- (void)configureNavigationBar {

}

#pragma mark - loadView
- (void)loadView {
    [super loadView];
    self.view = self.teamAnnounceView;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
- (void)addNotification {
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
/**
 *  应用退到后台
 */
- (void)appDidEnterBackground:(NSNotification *)notifi {
    [self.teamAnnouncePresenter.videoPlayerManager autoPause];
}
//appDidEnterBackground
/**
 *  应用进入前台
 */
- (void)appDidEnterPlayground:(NSNotification *)notifi {
    STBaseNav *vc =(STBaseNav *)self.tabBarController.selectedViewController;
    STInteractionViewController *cc;
    for (UIViewController *vv in vc.childViewControllers) {
        if ([vv isKindOfClass:[STInteractionViewController class]]) {
            cc =(STInteractionViewController *) vv;
        }
    }
    if (cc.currentIndex == 1) {
        [self.teamAnnouncePresenter.videoPlayerManager autoPlay];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeNotification];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.teamAnnouncePresenter.videoPlayerManager autoPause];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addNotification];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.teamAnnouncePresenter.videoPlayerManager autoPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self configureNavigationBar];
    [self configureAssociation];
    [self.teamAnnouncePresenter loadPaly];
    [self.teamAnnounceView.tableView reloadData];
}

#pragma mark - Configure
- (void)configureAssociation {
    //配置view
    self.teamAnnouncePresenter.teamAnnounceView = self.teamAnnounceView;
    
    self.teamAnnouncePresenter.controller = self;
    
    //presenter处理业务逻辑
    self.teamAnnounceView.delegate = self.teamAnnouncePresenter;
    
    //使用同一个配置
    self.teamAnnouncePresenter.teamAnnounceInteractor = self.teamAnnounceInteractor;
    self.teamAnnouncePresenter.teamAnnounceConfig = self.teamAnnounceInteractor.teamAnnounceConfig;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SETTER/GETTER
- (INDouyinRefreshConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INDouyinRefreshConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

- (INDouyinRefreshInteractor *)teamAnnounceInteractor {
    if (!_teamAnnounceInteractor) {
        _teamAnnounceInteractor = [[INDouyinRefreshInteractor alloc] init];
    }
    return _teamAnnounceInteractor;
}

- (INDouyinRefreshPresenter *)teamAnnouncePresenter {
    if (!_teamAnnouncePresenter) {
        _teamAnnouncePresenter = [[INDouyinRefreshPresenter alloc] init];
    }
    return _teamAnnouncePresenter;
}

- (INDouyinRefreshView *)teamAnnounceView {
    if (!_teamAnnounceView) {
        _teamAnnounceView = [[INDouyinRefreshView alloc] initWithFrame:CGRectZero];
    }
    return _teamAnnounceView;
}

@end
