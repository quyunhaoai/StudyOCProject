//
//  INDouyinRefreshPresenter.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INDouyinRefreshView.h"
#import "INDouyinRefreshCell.h"
#import "INDouyinRefreshInteractor.h"
#import "DDVideoPlayerManager.h"
#import "STSmallPlayShopTableViewCell.h"
@interface INDouyinRefreshPresenter : NSObject<ZFManagerPlayerDelegate,SmallVideoPlayCellDlegate,ZFManagerPlayerDelegate>

@property (nonatomic, strong) INDouyinRefreshView *teamAnnounceView;
@property (nonatomic, strong) INDouyinRefreshInteractor *teamAnnounceInteractor;
@property (nonatomic, strong) INDouyinRefreshConfig *teamAnnounceConfig;
@property (nonatomic, assign) NSInteger currentPlayIndex;
@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic, strong) UIView *fatherView;
//这个是播放视频的管理器
@property (nonatomic, strong) DDVideoPlayerManager *videoPlayerManager;
//这个是预加载视频的管理器
@property (nonatomic, strong) DDVideoPlayerManager *preloadVideoPlayerManager;

- (void)loadPaly;
@end
