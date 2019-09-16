//
//  STHomeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHomeViewController.h"
#import <SuperPlayer/SuperPlayer.h>

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
    self.title = @"首页";
    self.playerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_W*0.56)];
    [self.view addSubview:self.playerContainerView];
    
    _playerView = [[SuperPlayerView alloc] init];
    _playerView.fatherView = self.playerContainerView;//b播放器的父视图
    self.playerView.delegate = self;
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    playerModel.videoURL = @"http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4";
    self.playerView.autoPlay = YES;
    self.playerView.loop = YES;
    [_playerView playWithModel:playerModel];
    
    
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
