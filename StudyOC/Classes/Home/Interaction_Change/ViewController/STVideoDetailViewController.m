//
//  STVideoDetailViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoDetailViewController.h"
static CGFloat videoPlayViewHeight = 0 ;
@interface STVideoDetailViewController ()<KKAVPlayerViewDelegate>
@property (strong, nonatomic) KKAVPlayerView *videoPlayView; // 视图
@property (strong, nonatomic) UIView *videoContentView; //  视图

@end

@implementation STVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iPhoneX){
        videoPlayViewHeight = (Window_W * 4 / 7.0 ) + NAVIGATION_BAR_HEIGHT;
    }else{
        videoPlayViewHeight = (Window_W * 4 / 7.0 ) ;
    }
    [self.view addSubview:self.videoContentView];
    [self.videoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(videoPlayViewHeight);
    }];
    
}

- (void)addVideoPlayView:(KKAVPlayerView *)playView{
    [playView removeFromSuperview];
    
    self.videoPlayView = playView;
    self.videoPlayView.originalFrame = CGRectMake(0, 0, Window_W, videoPlayViewHeight) ;
    self.videoPlayView.originalView = self.videoContentView;
    self.videoPlayView.delegate = self;
    self.videoPlayView.fullScreen = NO ;
    [self.videoContentView addSubview:self.videoPlayView];
}
- (UIView *)videoContentView{
    if(!_videoContentView){
        _videoContentView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor blackColor];
            view;
        });
    }
    return _videoContentView;
}
#pragma mark -- KKAVPlayerViewDelegate
- (void)enterFullScreen{
    //[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:NO];
}

- (void)quitFullScreen{
    //[[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:NO];
}

- (void)quitVideoDetailView{
//    [self pushOutToRight:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.videoPlayView destoryVideoPlayer];
}
@end
