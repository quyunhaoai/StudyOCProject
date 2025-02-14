//
//  DDVideoPlayerManager.m
//  DuoDUoAnimateHouse
//
//  Created by 唐天成 on 2018/5/10.
//  Copyright © 2018年 唐天成. All rights reserved.
//

#import "DDVideoPlayerManager.h"
//#import "KTVHCPathTools.h"
#import <AVFoundation/AVFoundation.h>
#import "KTVHCDataUnitPool.h"
#import "KTVHTTPCache.h"
//#import "ZFCommonHelper.h"
//#import "NSString+CustomCategory.h"
//#import "ZFDownloadManager.h"
#import "ZFDouYinPlayerControlView.h"

@interface DDVideoPlayerManager()<ZFPlayerDelegate>

@property (strong, nonatomic) ZFPlayerView *playerView;
@property(nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *playerControllerView;

@end

@implementation DDVideoPlayerManager

- (instancetype)initWithPlayerControllerView:(UIView *)playerControllerView {
    if(self = [super init]) {
        self.playerControllerView = playerControllerView;
        if(self.playerControllerView == nil) {
            self.playerControllerView = [[ZFDouYinPlayerControlView alloc]init];
        }
    }
    return self;
}


- (nonnull instancetype)init {
    if(self = [self initWithPlayerControllerView:[[ZFDouYinPlayerControlView alloc]init]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appReceivedMemoryWarning)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)appReceivedMemoryWarning {
}




#pragma mark - Publick

/**
 *  播放
 */
- (void)play {
    [self.playerView play];
}

/**
 * 暂停
 */
- (void)pause {
    [self.playerView pause];
}

/*
 * 非手动播放
 */
- (void)autoPlay {
    [self.playerView autoPlay];
}

/*
 *非手动暂停
 */
- (void)autoPause {
    [self.playerView autoPause];
}

/**
 *  重置player为nil
 */
- (void)resetPlayer {
    [self.playerView resetPlayer];
}

//开启本地服务器配置
-(void)startServer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [KTVHTTPCache logSetConsoleLogEnable:YES];
        
        [KTVHTTPCache proxyStart:&error];
        if (error) {
            NSLog(@"开启服务失败");
        }else{
            NSLog(@"开启服务成功");
        }

    });
}

/**
 *  在当前页面，设置新的视频时候调用此方法
 */
- (void)resetToPlayNewVideo {//WithplayNowRealType:(BOOL)playNowRealType {
    
    [self startServer];

    [self.playerView resetToPlayNewVideo:self.playerModel];
}

- (NSString *_Nullable)cacheKeyForURL:(NSURL *)url {
    if (!url) {
        return nil;
    }
    return [url absoluteString];
}


#pragma mark - LaztLoad

- (ZFPlayerModel *)playerModel {
    if(!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:self.playerControllerView playerModel:self.playerModel];
        // 设置代理
        _playerView.delegate = self;
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        // 打开预览图
        _playerView.hasPreviewView = YES;
    }
    return _playerView;
}

#pragma mark - ZFPlayerDelegate

/** 返回按钮事件 */
- (void)zf_playerBackAction {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerBackAction)]) {
        [self.managerDelegate zfManager_playerBackAction];
    }
}
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerDownload:)]) {
        [self.managerDelegate zfManager_playerDownload:url];
    }
    
}
/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerControlViewWillShow:isFullscreen:)]) {
        [self.managerDelegate zfManager_playerControlViewWillShow:controlView isFullscreen:fullscreen];
    }
}
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerControlViewWillHidden:isFullscreen:)]) {
        [self.managerDelegate zfManager_playerControlViewWillHidden:controlView isFullscreen:fullscreen];
    }
}
/** 视频播放结束 还需要做什么事 */
- (void)zf_playerFinished:(ZFPlayerModel *)model {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerFinished:)]) {
        [self.managerDelegate zfManager_playerFinished:model];
    }
}
/** 播放下一首 */
- (void)zf_playerNextParter:(ZFPlayerModel *)model {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerNextParter:)]) {
        [self.managerDelegate zfManager_playerNextParter:model];
    }
}
/** 播放到百分之几 */
- (void)zf_playerCurrentSliderValue:(CGFloat)value playerModel:(ZFPlayerModel *)model {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerCurrentSliderValue:playerModel:)]) {
        [self.managerDelegate zfManager_playerCurrentSliderValue:value playerModel:model];
    }
}

/** 播放状态发生改变 */
- (void)zf_playerPlayerStatusChange:(ZFPlayerState)statu {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerPlayerStatusChange:)]) {
        [self.managerDelegate zfManager_playerPlayerStatusChange:statu];
    }
    //如果是本地文件且播放失败
    if(statu == ZFPlayerStateFailed ) {
        if([self.playerModel.videoURL.scheme isEqualToString:@"file"]) {
            //如果是播放的本地文件失败,那么删除掉本地文件然后播放网络资源
            NSRange range= [self.playerModel.videoURL.absoluteString rangeOfString:@"file://"];
            NSString *localString = [self.playerModel.videoURL.absoluteString stringByReplacingCharactersInRange:range withString:@""];
            if([[NSFileManager defaultManager] fileExistsAtPath:localString]) {
                [[NSFileManager defaultManager]  removeItemAtPath:localString error:NULL];
                self.playerModel.videoURL = self.originVideoURL;
                [self resetToPlayNewVideo];//WithplayNowRealType:NO];
            }
        } else {
            //如果播放网络资源失败,那么删除一下本地的KTVHTTPCache.archive中存的数据
            [[KTVHCDataUnitPool pool] deleteUnitWithURL:self.playerModel.videoURL];
        }
    }
}

/** 前往小视频播放界面 */
- (void)zf_playerPushToPlaySmallViewListVC {
    if([self.managerDelegate respondsToSelector:@selector(zfManager_playerPushToPlaySmallViewListVC)]) {
        [self.managerDelegate zfManager_playerPushToPlaySmallViewListVC];
    }
}

- (void)dealloc {
    NSLog(@"销毁");
    [self resetPlayer];
}


@end
