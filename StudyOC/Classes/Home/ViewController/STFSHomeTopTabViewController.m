//
//  STFSHomeTopTabViewController.m
//  
//
//  Created by 研学旅行 on 2019/9/19.
//

#import "STFSHomeTopTabViewController.h"
#import "FSScrollContentView.h"
#import "STChildrenViewController.h"
#import "KKSearchBar.h"
#import "KKNavTitleView.h"
#import "UIButton+Badge.h"

#import "STRecommendViewController.h"
#import "STMyHomeViewController.h"
#import "STZhengZhouViewController.h"
#import "STRankingListViewController.h"
#import "STTagHomeTopViewController.h"
@interface STFSHomeTopTabViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (strong, nonatomic) NSArray *titleArray;            // 标题数组
@property (strong, nonatomic) NSArray *viewControllerArray;   // 控制器数组

@property (strong, nonatomic) FSSegmentTitleView *topTitleView;    // 顶部View
@property (strong, nonatomic) FSPageContentView *pageView;

@property(nonatomic,strong)UIImageView *headView;//导航栏左侧的头像
@property(nonatomic,strong)KKSearchBar *searchBar ;
@property(nonatomic,strong)KKNavTitleView *navTitleView;
@end

@implementation STFSHomeTopTabViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTitleView];
    _topTitleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 300, 48) titles:self.titleArray delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    _topTitleView.selectIndex = 1;
    [self.view addSubview:_topTitleView];
    
    _pageView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+48, Window_W, Window_H-48-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) childVCs:self.viewControllerArray parentVC:self delegate:self];
    _pageView.contentViewCurrentIndex = 1;
    [self.view addSubview:_pageView];
    [kNotificationCenter addObserver:self selector:@selector(homeIconAction) name:STRefreshTableViewTopData object:nil];
    
    UIButton *fristItme = (UIButton *)[self.topTitleView viewWithTag:666];
    fristItme.badgeValue = XYIntToString(20);
    fristItme.badgeBGColor = [UIColor colorWithRed:0.95 green:0.35 blue:0.35 alpha:1.0];
    fristItme.badgeOriginY = 5;
    fristItme.badgeOriginX = WIDTH(fristItme)-20-2;
}

- (void)homeIconAction {
    STBaseTableViewController *vc =(STBaseTableViewController *)self.viewControllerArray[self.pageView.contentViewCurrentIndex];
    
    [vc refreshTableViewData];
    
    UIButton *fristItme = (UIButton *)[self.topTitleView viewWithTag:666];
    fristItme.badgeValue = XYIntToString(0);
    [fristItme shouldHideBadgeAtZero];
}

- (void)loadNavTitleView {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self.headView setSize:CGSizeMake(27, 27)];
    [self.headView setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(@"IMG_0096")];
    XYWeakSelf;
    [self.headView addTapGestureWithBlock:^(UIView *gestureView) {
        STChildrenViewController *vc = [STChildrenViewController new];
        vc.title = @"个人主页";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        NSLog(@"点击了头像！");
    }];
    self.navTitleView.leftBtns = @[self.headView];
    
    self.searchBar.frame = CGRectMake(50, 0, Window_W - 140, 27);
    self.navTitleView.titleView = self.searchBar;
    
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn1 setTitle:@"扫一扫" forState:UIControlStateNormal];
    [rightBtn2 setTitle:@"发布" forState:UIControlStateNormal];
    rightBtn1.titleLabel.font = FONT_10;
    rightBtn2.titleLabel.font = FONT_10;
    [rightBtn2 setSize:CGSizeMake(35, 27)];
    [rightBtn1 setSize:CGSizeMake(35, 27)];
    self.navTitleView.rightBtns = @[rightBtn1,rightBtn2];
}

#pragma mark  -  Get

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"我的",
                        @"推荐",
                        @"郑州",
                        @"排行榜",
                        @"标签"];
    }
    return _titleArray;
}

- (NSArray *)viewControllerArray {
    if (!_viewControllerArray) {
        _viewControllerArray = @[[STMyHomeViewController new],
                                 [[STRecommendViewController alloc] initWithStyle:UITableViewStyleGrouped],
                                 [STZhengZhouViewController new],
                                 [STRankingListViewController new],
                                 [STTagHomeTopViewController new],];
    }
    return _viewControllerArray;
}

- (KKSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = ({
            KKSearchBar *view = [[KKSearchBar alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.masksToBounds = YES ;
            view.layer.cornerRadius = 5 ;
            view;
        });
    }
    return _searchBar;
}

- (KKNavTitleView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = ({
            KKNavTitleView *view = [KKNavTitleView new];
            view.contentOffsetY = (STATUS_BAR_HEIGHT-(13.5))/2 ;
            view.backgroundColor = KKColor(212, 60, 61, 1.0);
            view ;
        });
    }
    return _navTitleView;
}

- (UIImageView *)headView{
    if(!_headView){
        _headView = ({
            UIImageView *view = [[UIImageView alloc]init];
            view.layer.masksToBounds =  YES ;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.userInteractionEnabled = YES ;
            view;
        });
    }
    return _headView;
}

#pragma mark  -  FSTitleDeleGate
/**
 切换标题
 
 @param titleView FSSegmentTitleView
 @param startIndex 切换前标题索引
 @param endIndex 切换后标题索引
 */
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.pageView.contentViewCurrentIndex = endIndex;
}

/**
 将要开始滑动
 
 @param titleView FSSegmentTitleView
 */
- (void)FSSegmentTitleViewWillBeginDragging:(FSSegmentTitleView *)titleView {
    
}

/**
 将要停止滑动
 
 @param titleView FSSegmentTitleView
 */
- (void)FSSegmentTitleViewWillEndDragging:(FSSegmentTitleView *)titleView {
    
}

#pragma mark  -  FSContenViewDelegate

/**
 FSPageContentView开始滑动
 
 @param contentView FSPageContentView
 */
- (void)FSContentViewWillBeginDragging:(FSPageContentView *)contentView {
    
}

/**
 FSPageContentView滑动调用
 
 @param contentView FSPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress {
    
}

/**
 FSPageContentView结束滑动
 
 @param contentView FSPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.topTitleView.selectIndex = endIndex;
}

/**
 scrollViewDidEndDragging
 
 @param contentView FSPageContentView
 */
- (void)FSContenViewDidEndDragging:(FSPageContentView *)contentView {
    
}
@end
