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

#import "STRecommendViewController.h"
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTitleView];
    _topTitleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 300, 48) titles:self.titleArray delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    _topTitleView.selectIndex = 1;
    [self.view addSubview:_topTitleView];
    
    _pageView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+48, Window_W, Window_H-48-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) childVCs:self.viewControllerArray parentVC:self delegate:self];
    _pageView.contentViewCurrentIndex = 1;
    [self.view addSubview:_pageView];
}

- (void)loadNavTitleView {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self.headView setSize:CGSizeMake(27, 27)];
    [self.headView setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(@"IMG_0096")];
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
        _viewControllerArray = @[[STChildrenViewController new],
                                 [STRecommendViewController new],
                                 [STChildrenViewController new],
                                 [STChildrenViewController new],
                                 [STChildrenViewController new],];
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
            
            //            [view addTapGestureWithBlock:^(UIView *gestureView) {
            //                KKUserCenterView *centerView = [KKUserCenterView new];
            //                centerView.topSpace = 0 ;
            //                centerView.enableFreedomDrag = NO ;
            //                centerView.enableVerticalDrag = NO ;
            //                centerView.enableHorizonDrag = YES ;
            //
            //                [[UIApplication sharedApplication].keyWindow addSubview:centerView];
            //                [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            //                    make.left.top.mas_equalTo(0);
            //                    make.size.mas_equalTo(CGSizeMake(UIDeviceScreenWidth, UIDeviceScreenHeight));
            //                }];
            //                [centerView pushIn];
            //            }];
            
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
