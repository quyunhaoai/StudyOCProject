//
//  STHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHomeViewController.h"
//#import <SuperPlayer/SuperPlayer.h>

@interface STHomeViewController ()<SuperPlayerDelegate>
@property (nonatomic,strong) SuperPlayerView *playerView;
@property (strong, nonatomic) UIView *playerContainerView; // 放播放器 视图

@end

@implementation STHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

}


- (void)setupView {

    
    self.playerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_W*0.56)];
    [self.view addSubview:self.playerContainerView];

    _playerView = [[SuperPlayerView alloc] init];

    _playerView.fatherView = self.playerContainerView;//b播放器的父视图
    self.playerView.delegate = self;
    SPWeiboControlView *weiboStly = [[SPWeiboControlView alloc] init];
    weiboStly.moreBtn.hidden = YES;
    weiboStly.muteBtn.hidden = YES;
    self.playerView.controlView = weiboStly;
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    playerModel.videoURL = self.videoUrl.length>0?self.videoUrl:@"http://mp.youqucheng.com/addons/project/data/uploadfiles/video/1_06257727562426755.mp4?t=0.7643188466880166";
    self.playerView.autoPlay = YES;
    self.playerView.loop = YES;
    [_playerView playWithModel:playerModel];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark  -  delegate

/** 返回事件 */
- (void)superPlayerBackAction:(SuperPlayerView *)player {
    [self.playerContainerView removeFromSuperview];
    [self.playerView resetPlayer];
}
/// 全屏改变通知
- (void)superPlayerFullScreenChanged:(SuperPlayerView *)player {

}
/// 播放开始通知
- (void)superPlayerDidStart:(SuperPlayerView *)player {

}
/// 播放结束通知
- (void)superPlayerDidEnd:(SuperPlayerView *)player {

}
/// 播放错误通知
- (void)superPlayerError:(SuperPlayerView *)player errCode:(int)code errMessage:(NSString *)why {

}
// 需要通知到父view的事件在此添加

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)didMoveToParentViewController:(nullable UIViewController *)parent
{
    if (parent == nil) {
        [self.playerView resetPlayer];
    }
}



















@end
