//
//  KKXiaoShiPingPlayView.m
//  KKToydayNews
//
//  Created by finger on 2017/10/15.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKXiaoShiPingPlayView.h"
//#import "KKAuthorInfoView.h"
//#import "KKBottomBar.h"
#import "KKXiaoShiPingPlayer.h"
//#import "KKNewsCommentView.h"
//#import "KKPersonalInfoView.h"

#define VideoCorverHorizPading 20
#define VideoItemWith (Window_W + 0)
#define BottomBarHeight (KKSafeAreaBottomHeight + 44)
#define VideoCorverViewBaseTag 10000

@interface KKXiaoShiPingPlayView()<UIScrollViewDelegate,KKXiaoShiPingPlayerDelegate>
@property(nonatomic)UIScrollView *videoContainer;
@property(nonatomic)UIImageView *animateImageView;//进入播放视图时的动画视图
@property(nonatomic,strong)CAGradientLayer *topGradient;
@property(nonatomic,strong)CAGradientLayer *bottomGradient;
@property(nonatomic,copy)NSArray<id > *videoArray;
@property(nonatomic,assign)NSInteger selIndex;
@property(nonatomic,assign)UIStatusBarStyle barStyle;
@property(nonatomic,assign)BOOL canHideStatusBar;

@end

@implementation KKXiaoShiPingPlayView

- (instancetype)initWithNewsBaseInfo:( id)newsInfo
                          videoArray:(NSArray *)videoArray
                            selIndex:(NSInteger)selIndex{
    self = [super init];
    if(self){
        self.topSpace = 0 ;
        self.enableFreedomDrag = NO ;
        self.enableHorizonDrag = YES ;
        self.enableVerticalDrag = YES ;
        self.navContentOffsetY = 0 ;
        self.videoArray =@[@""];//   self.videoArray =@[@"",@"",@"",@"",@"",@"",@"",@""];
        self.selIndex = selIndex ;
        self.barStyle = [[UIApplication sharedApplication]statusBarStyle];
    }
    return self ;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark -- 视图的显示和消失

- (void)viewWillAppear{
    [super viewWillAppear];
    [self initUI];
    [self startAnimate];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    @STweakify(self);
    [self addTapGestureWithBlock:^(UIView *gestureView) {
        @STstrongify(self);
        self.topGradient.hidden = !self.topGradient.hidden;
        self.bottomGradient.hidden = !self.bottomGradient.hidden;
        [UIApplication sharedApplication].statusBarHidden = self.topGradient.hidden;
        [UIView animateWithDuration:0.3 animations:^{
            self.navTitleView.alpha = 1 - self.navTitleView.alpha;
        }completion:^(BOOL finished) {

        }];

    }];
}

- (void)viewWillDisappear{
    [super viewWillDisappear];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = self.barStyle;
    //关闭视频
    KKXiaoShiPingPlayer *videoView = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex ];
    [videoView destoryVideoPlayer];
    [videoView removeFromSuperview];

    if(self.alphaViewIfNeed){
        self.alphaViewIfNeed(NO);
    }
}

- (void)viewDidAppear{
    [super viewDidAppear];
}

#pragma mark -- 初始化UI

- (void)initUI{
    self.videoContainer.alpha = 1.0 ;
    self.dragContentView.backgroundColor = [UIColor blackColor];
    [self.dragContentView insertSubview:self.videoContainer belowSubview:self.navTitleView];
    [self initNavBar];
    [self.videoContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dragContentView);
        make.left.mas_equalTo(self.dragContentView);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(self.dragContentView);
    }];
    [self initVideoPlayView];
}

- (void)initVideoPlayView{
    NSInteger index = 0 ;
    NSInteger count = self.videoArray.count;
    for(id item in self.videoArray){
        KKXiaoShiPingPlayer *view = [KKXiaoShiPingPlayer new];
        view.playUrl = @"http://mp.youqucheng.com/addons/project/data/uploadfiles/video/1_06257727562426755.mp4?t=0.7643188466880166";
        view.corverImage = IMAGE_NAME(STSystemDefaultImageName);
        view.delegate = self ;
        view.tag = VideoCorverViewBaseTag + index ;
        view.frame = CGRectMake(index * VideoItemWith, 0, Window_W, Window_H);
        [self.videoContainer addSubview:view];
        index ++;
    }
    
    [self.videoContainer setContentSize:CGSizeMake(VideoItemWith * count, 0)];
    [self.videoContainer setContentOffset:CGPointMake(self.selIndex * VideoItemWith, 0) animated:NO];
    
    KKXiaoShiPingPlayer *view = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex];
    [view setCorverImage:IMAGE_NAME(STSystemDefaultImageName)];//防止第一次播放时界面闪烁
    [view startPlayVideo];
}

#pragma mark -- 导航栏

- (void)initNavBar{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"leftbackicon_white_titlebar_24x24_"] forState:UIControlStateNormal];
    [backButton setImage:[[UIImage imageNamed:@"leftbackicon_white_titlebar_24x24_"] imageWithAlpha:0.5] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(dismissVideoPlayView) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
    self.navTitleView.splitView.hidden = YES ;
    self.navTitleView.contentOffsetY = 5 ;
}

#pragma mark -- 数据刷新

- (void)refreshData{

}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.enableHorizonDrag = NO ;
    self.enableVerticalDrag = NO ;
    self.enableFreedomDrag = NO ;
    
    CGPoint offset = self.videoContainer.contentOffset;
    CGFloat progress = offset.x / (CGFloat)VideoItemWith;
    
    NSInteger nextIndex = self.selIndex + 1 ;
    if(nextIndex < self.videoArray.count){
        [[scrollView viewWithTag:VideoCorverViewBaseTag + nextIndex]setAlpha:fabs(progress-self.selIndex)];
    }
    
    [[scrollView viewWithTag:VideoCorverViewBaseTag + self.selIndex] setAlpha:1 - fabs((progress-self.selIndex))];
    
    NSInteger perIndex = self.selIndex - 1 ;
    if(perIndex >= 0){
        [[scrollView viewWithTag:VideoCorverViewBaseTag + perIndex] setAlpha:fabs((self.selIndex - progress))];
    }
}

//结束拉拽视图
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

//完全停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = self.videoContainer.contentOffset;
    NSInteger index = offset.x / VideoItemWith;
    if(index < 0 || index >= self.videoArray.count){
        return ;
    }
    
    self.enableHorizonDrag = (index == 0);
    self.enableVerticalDrag = YES ;
    self.enableFreedomDrag = NO ;
    
    if(self.selIndex != index){
        
        self.selIndex = index ;
        
        KKXiaoShiPingPlayer *view = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex];
        [view startPlayVideo];
        
        [self refreshData];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(scrollToIndex:callBack:)]){
            [self.delegate scrollToIndex:self.selIndex callBack:^(CGRect oriFrame, UIImage *oriImage) {
                self.oriFrame = oriFrame;
                self.oriImage = oriImage;
            }];
        }
        
    }
    
    NSInteger nextIndex = self.selIndex + 1 ;
    if(nextIndex < self.videoArray.count){
        [[scrollView viewWithTag:VideoCorverViewBaseTag + nextIndex]setAlpha:1.0];
    }
    
    [[scrollView viewWithTag:VideoCorverViewBaseTag + self.selIndex] setAlpha:1.0];
    
    NSInteger perIndex = self.selIndex - 1 ;
    if(perIndex >= 0){
        [[scrollView viewWithTag:VideoCorverViewBaseTag + perIndex] setAlpha:1.0];
    }
}

#pragma mark -- 显示动画

- (void)startAnimate{
    CGFloat imageW = Window_W;
    CGFloat imageH = Window_H;
    CGRect frame = CGRectMake(0, 0, imageW, imageH);

    CGRect fromRect = [self.oriView convertRect:self.oriFrame toView:self.dragContentView];
    self.animateImageView = [YYAnimatedImageView new];
    self.animateImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.animateImageView.layer.masksToBounds = YES ;
    self.animateImageView.image = IMAGE_NAME(STSystemDefaultImageName);
    self.animateImageView.frame = fromRect;
    [self.dragContentView addSubview:self.animateImageView];

    [UIView animateWithDuration:0.3 animations:^{
        self.animateImageView.frame = frame;
    }completion:^(BOOL finished) {
        self.videoContainer.alpha = 1.0 ;
        self.dragContentView.backgroundColor = [UIColor blackColor];
    }];
}

#pragma mark -- 关闭视频并退出界面

- (void)dismissVideoPlayView{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = self.barStyle;
    KKXiaoShiPingPlayer *videoView = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex];
    //关闭视频
    [videoView destoryVideoPlayer];
    [videoView setHidden:YES];
    
    CGRect frame = videoView.frame ;
    frame = [self.videoContainer convertRect:frame toView:self.dragContentView];
    frame = [self.dragContentView convertRect:frame toView:self.oriView];
    
    self.dragViewBg.alpha = 0;
    self.dragContentView.hidden = YES;
    if(self.hideImageAnimate){
        self.hideImageAnimate(self.oriImage,frame,self.oriFrame);
    }
}

#pragma mark -- KKXiaoShiPingPlayerDelegate

- (void)videoDidPlaying{
    [self.animateImageView removeFromSuperview];
}

#pragma mark -- KKAuthorInfoViewDelegate

- (void)setConcern:(BOOL)isConcern callback:(void (^)(BOOL))callback{
    if(callback){
        callback(YES);
    }
}

- (void)clickedUserHeadWithUserId:(NSString *)userId{

}

#pragma mark -- KKBottomBarDelegate

- (void)sendCommentWidthText:(NSString *)text{
    NSLog(@"%@",text);
}

- (void)favoriteNews:(BOOL)isFavorite callback:(void (^)(BOOL))callback{
    if(callback){
        callback(YES);
    }
}

- (void)shareNews{
    
}

- (void)showCommentView{

}

#pragma mark -- 开始、拖拽中、结束拖拽

- (void)dragBeginWithPoint:(CGPoint)pt{
    self.enableFreedomDrag = NO ;
    CGFloat offsetY = self.videoContainer.contentOffset.y;
    if(offsetY <=0 || offsetY >= self.videoContainer.contentSize.height){
        self.enableFreedomDrag = YES ;
    }
    
    if(self.alphaViewIfNeed){
        self.alphaViewIfNeed(self.enableFreedomDrag&&!self.defaultHideAnimateWhenDragFreedom);
    }
}

- (void)dragingWithPoint:(CGPoint)pt{
    KKXiaoShiPingPlayer *videoView = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex ];
    if(self.enableFreedomDrag){
        self.navTitleView.alpha = 0;
        videoView.layer.transform = CATransform3DMakeScale(self.dragViewBg.alpha,self.dragViewBg.alpha,0);
    }
    
    self.topGradient.hidden = YES ;
    self.videoContainer.scrollEnabled = NO ;
    self.dragContentView.backgroundColor = [UIColor clearColor];
}

- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView{
    if(self.enableFreedomDrag){
        if(!hideView){
            KKXiaoShiPingPlayer *videoView = [self.videoContainer viewWithTag:VideoCorverViewBaseTag + self.selIndex ];
            [UIView animateWithDuration:0.3 animations:^{
                videoView.layer.transform = CATransform3DIdentity;
            }completion:^(BOOL finished) {
                self.dragContentView.backgroundColor = [UIColor blackColor];
            }];
        }else{
            [self dismissVideoPlayView];
        }
    }else{
        if(self.alphaViewIfNeed){
            self.alphaViewIfNeed(!hideView);
        }
        self.dragContentView.backgroundColor = [UIColor blackColor];
    }
    
    self.enableFreedomDrag = NO ;
    self.enableHorizonDrag = (self.selIndex == 0) ;
    self.enableVerticalDrag = YES ;
    self.videoContainer.scrollEnabled = YES ;
}

#pragma mark -- @property getter

- (UIScrollView *)videoContainer{
    if(!_videoContainer){
        _videoContainer = ({
            UIScrollView *view = [UIScrollView new];
            view.showsVerticalScrollIndicator = NO ;
            view.showsHorizontalScrollIndicator = NO ;
            view.pagingEnabled = YES ;
            view.delegate = self ;
            view.bounces = NO ;
            view.layer.masksToBounds = NO ;
            view.backgroundColor = [UIColor clearColor];
            view.userInteractionEnabled = YES ;
            view ;
        });
    }
    return _videoContainer;
}

- (CAGradientLayer *)topGradient{
    if(!_topGradient){
        _topGradient = [CAGradientLayer layer];
        _topGradient.colors = @[(__bridge id)[[UIColor blackColor]colorWithAlphaComponent:0.5].CGColor, (__bridge id)[UIColor clearColor].CGColor];
        _topGradient.startPoint = CGPointMake(0, 0);
        _topGradient.endPoint = CGPointMake(0.0, 1.0);
    }
    return _topGradient;
}

- (CAGradientLayer *)bottomGradient{
    if(!_bottomGradient){
        _bottomGradient = [CAGradientLayer layer];
        _bottomGradient.colors = @[(__bridge id)[[UIColor blackColor]colorWithAlphaComponent:0.5].CGColor, (__bridge id)[UIColor clearColor].CGColor];
        _bottomGradient.startPoint = CGPointMake(0, 1.0);
        _bottomGradient.endPoint = CGPointMake(0.0, 0.0);
    }
    return _bottomGradient;
}

@end
