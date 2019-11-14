//
//  LBPGuideView.m
//  立方查
//
//  Created by 杭城小刘 on 2018/4/5.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//
#define GlobalMainColor [UIColor colorWithRed:93/255.0 green:70/255.0 blue:148/255.0 alpha:1]
#define BorderColor COLOR_HEX_RGB(0xe4e4e4)
#import "LBPGuideView.h"

static NSString *const AppVersion = @"AppVersion";

@interface LBPGuideView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation LBPGuideView

#pragma mark -- life cycle

- (instancetype)initWithImageNames:(NSArray<NSString *>*)imageNames{
    if (self == [super initWithFrame:CGRectZero]) {
        self.imageNames = imageNames;
        [self setupUI];
    }
    return self;
}

-(void)dealloc{
    [self unregisterFromKVO];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, Window_H-50, Window_W, 30);
    self.pageControl.hidden = NO;
}

#pragma mark -- private method

-(void)setupUI{
    self.pageControlCurrentColor = GlobalMainColor;
    self.pageControlNormalColor = BorderColor;
    
    [self registerForKVO];
    
    if ([self isFirstLaunch]) {
        UIView *view = [[UIApplication sharedApplication].delegate window].rootViewController.view;
        self.frame = view.bounds;
        [view addSubview:self];
        
        // scrollView
        self.frame = self.bounds;
        self.scrollView.contentSize = CGSizeMake(Window_W*self.imageNames.count, Window_H);
        [self addSubview:self.scrollView];
        for (int i=0; i<self.imageNames.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*Window_W, 0, Window_W, Window_H)];
            imageView.image = [UIImage imageNamed:self.imageNames[i]];
            [self.scrollView addSubview:imageView];
            if (i == self.imageNames.count - 1) {
                if (!self.enterButtonHidden) {
                    
                    UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.4 * Window_W, 0.25 * 0.4 * Window_W)];
                    [enterButton setTitle:@"开启商业探索" forState:UIControlStateNormal];
                    [enterButton setTitleColor:GlobalMainColor forState:UIControlStateNormal];
                    enterButton.layer.borderWidth = 1;
                    enterButton.layer.borderColor = GlobalMainColor.CGColor;
                    enterButton.layer.cornerRadius = 5;
                    enterButton.layer.masksToBounds = YES;
                    enterButton.center = CGPointMake(Window_W / 2, Window_H - 75);
                    [enterButton addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
                    self.enterButton = enterButton;
                    [imageView addSubview:enterButton];
                    imageView.userInteractionEnabled = YES;
                }
            }
        }
        
        // pageControl
        self.pageControl.numberOfPages = self.imageNames.count;
        self.pageControl.pageIndicatorTintColor = self.pageControlNormalColor;
        self.pageControl.currentPageIndicatorTintColor = self.pageControlCurrentColor;
        [self addSubview:self.pageControl];
        
    } else {
        [self removeFromSuperview];
    }
}

-(BOOL)isFirstLaunch{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *previousVersion = [[NSUserDefaults standardUserDefaults] objectForKey:AppVersion];
    if (![previousVersion isEqualToString:currentVersion] ) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:AppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

-(void)hideGuideView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(BOOL)isScrollToLeft:(UIScrollView *)scrollView{
    return [scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0;
}

#pragma mark -- Class method

+(instancetype)showGuideViewWithImages:(NSArray<NSString *> *)imageNames{
    LBPGuideView *guideView = [[LBPGuideView alloc] initWithImageNames:imageNames];
    return guideView;
}

#pragma mark -- response method

-(void)enterAction{
    [self hideGuideView];
}

#pragma mark -- UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    int cuttentIndex = (int)(scrollView.contentOffset.x)/Window_W;
    if (cuttentIndex == self.imageNames.count - 1) {
        if ([self isScrollToLeft:scrollView]) {
            if (!self.enterButtonHidden) {
                return ;
            }
            [self hideGuideView];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int cuttentIndex = (int)(scrollView.contentOffset.x )/Window_W;
    self.pageControl.currentPage = cuttentIndex;
}


#pragma mark -- KVO

-(NSArray *)observableKeypaths{
    return @[@"pageControlCurrentColor",
             @"pageControlNormalColor",
             @"pageControlHidden",
             @"enterButtonHidden"];
}


-(void)registerForKVO{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)unregisterFromKVO{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    }else{
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"pageControlCurrentColor"]) {
        self.pageControl.currentPageIndicatorTintColor = self.pageControlCurrentColor;
    } else if ([keyPath isEqualToString:@"pageControlNomalColor"]) {
        self.pageControl.pageIndicatorTintColor = self.pageControlNormalColor;
    } else if ([keyPath isEqualToString:@"pageControlHidden"]) {
        self.pageControl.hidden = self.pageControlHidden;
    } else if ([keyPath isEqualToString:@"enterButtonHidden"]) {
        self.enterButton.hidden = self.enterButtonHidden;
    }
    
    
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark -- getter && setter

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        _pageControl.defersCurrentPageDisplay = YES;
    }
    return _pageControl;
}


@end
