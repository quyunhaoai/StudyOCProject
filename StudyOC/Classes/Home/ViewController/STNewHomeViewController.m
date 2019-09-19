//
//  STNewHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STNewHomeViewController.h"
#import "STChildrenViewController.h"
#import "KKSearchBar.h"
#import "KKNavTitleView.h"
CGFloat  const marin=10;
@interface STNewHomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *myScrollView;
@property (nonatomic, weak) UIButton *currelButton;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, weak) UIView *underline;

@property(nonatomic,strong)UIImageView *headView;//导航栏左侧的头像
@property(nonatomic,strong)KKSearchBar *searchBar ;
@property(nonatomic,strong)KKNavTitleView *navTitleView;

//-(void)setupTitleView:(BOOL)isShow;
@end

@implementation STNewHomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    NSLog(@"scrollview:%@",NSStringFromCGRect(self.myScrollView.bounds));
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTitleView];
    //添加自控制器
    [self addchildViews];
    //添加ScrollView
    [self setupContenView];
    //添加titleview
    [self setupTitleView];
    
    //添加第0个控制器View
    [self addVCtoScrollView:0];
    
    UIButton *titleButton = (UIButton *)self.titleView.subviews[1];
    //    [self titleButtonClick:titleButton];
    [self chicktitleButton:titleButton];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupFrame) name:@"setupFrame" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupFrameCancel) name:@"setupFrameCancel" object:nil];
}
- (void)loadNavTitleView {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self.headView setSize:CGSizeMake(27, 27)];
//    [self.headView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:@""];
    self.navTitleView.leftBtns = @[self.headView];
    
    self.searchBar.frame = CGRectMake(50, 0, Window_W - 60, 27);
    self.navTitleView.titleView = self.searchBar;
}

//-(void)setupTitleView:(BOOL)isShow{
//    if (isShow) {
//        self.titleView.qyh_y = 20;
//    }else{
//        self.titleView.qyh_y = 64;
//    }
//}
//-(void)setupFrame
//{
//    self.titleView.qyh_y = 20;
//}
//-(void)setupFrameCancel
//{
//    self.titleView.qyh_y = 64;
//}
-(void)addVCtoScrollView:(NSUInteger )integer
{
    UIViewController *childVc = self.childViewControllers[integer];
    
    if (childVc.isViewLoaded) return;
    
    UIView *childVcview = childVc.view;
    
    CGFloat scrollviewW = self.myScrollView.qyh_width;
    
    childVcview.frame = CGRectMake(scrollviewW * integer, 0, scrollviewW, self.myScrollView.qyh_height);
    [self.myScrollView addSubview:childVcview];
    NSLog(@"scrollviewY:%f",self.myScrollView.frame.origin.y);
}
-(void)addchildViews
{
    [self addChildViewController:[[STChildrenViewController alloc]init]];
    [self addChildViewController:[[STChildrenViewController alloc]init]];
    [self addChildViewController:[[STChildrenViewController alloc]init]];
    [self addChildViewController:[[STChildrenViewController alloc]init]];
    [self addChildViewController:[[STChildrenViewController alloc]init]];
    
}
-(void)setupTitleView {
    NSArray *titles =@[@"我的",
                       @"推荐",
                       @"郑州",
                       @"排行榜",
                       @"标签"];
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                NAVIGATION_BAR_HEIGHT,
                                                                Window_W,
                                                                35)];
    [titleview setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [self.view addSubview:titleview];
    self.titleView = titleview;
    CGFloat titleButtonW = Window_W/5;
    
    for (int i = 0; i < 5; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat titleButtonX = titleButtonW *i;
        titleButton.tag = i;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonW, titleview.frame.size.height);
        [titleButton addTarget:self action:@selector(chicktitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [titleButton setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.titleView addSubview:titleButton];
    }
    
    
    //添加标题下划线
    [self setuptitleunderline];
    
}

-(void)chicktitleButton:(UIButton *)button
{
    NSUInteger index = button.tag;
    self.currelButton.selected = NO;
    button.selected = YES;
    self.currelButton = button;
    NSLog(@"%s",__FUNCTION__);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.underline.qyh_width = button.titleLabel.qyh_width ;
        self.underline.qyh_center_x = button.qyh_center_x ;
        
    }];
    [self addVCtoScrollView:index];
    self.myScrollView.contentOffset = CGPointMake(self.myScrollView.qyh_width*index, 0);
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLayoutSubviews
{
    //    NSLog(@"%s",__FUNCTION__);
}
-(void)setuptitleunderline
{
    UIView *underline = [[UIView alloc] init];
    UIButton *button = (UIButton *)[[self.titleView subviews] firstObject];
    [button.titleLabel sizeToFit];
    CGFloat underlineX = 0;
    CGFloat underlineW = button.titleLabel.qyh_width ;
    NSLog(@"%f",underlineW);
    underline.frame = CGRectMake(underlineX, self.titleView.qyh_height-2, underlineW, 2);
    underline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    button.selected = YES;
    self.currelButton = button;
    underline.qyh_center_x = button.qyh_center_x;
    underline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underline];
    _underline = underline;
}
-(void)setupContenView
{
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+35, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-35-TAB_BAR_HEIGHT);
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.scrollsToTop = NO;
    scrollview.bounces = NO;
    if (@available(iOS 11.0,*)) {
        scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:scrollview];
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollW = scrollview.qyh_width;
    scrollview.contentSize = CGSizeMake(count * scrollW, 0);
    self.myScrollView = scrollview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.qyh_width;
    
    // 点击对应的标题按钮
    UIButton *titleButton = (UIButton *)self.titleView.subviews[index];
    //    [self titleButtonClick:titleButton];
    [self chicktitleButton:titleButton];
}

#pragma mark  -  GET

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
            view.contentOffsetY = 10 ;
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

@end
