//
//  INDouyinRefreshPresenter.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshPresenter.h"
static NSString * const STSmallPlayShopTableViewCellIdentifier = @"STSmallPlayShopTableViewCellIdentifier";
@implementation INDouyinRefreshPresenter

- (void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.teamAnnounceView.tableView reloadData];
        [self.teamAnnounceView endRefreshingSuccess];
    });
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.teamAnnounceConfig addMoreData];
        [self.teamAnnounceView.tableView reloadData];
        [self.teamAnnounceView endRefreshingSuccess];
    });
}

#pragma mark DFMeetUserViewDelegate
/**
 刷新加载数据
 */
- (void)refreshLoadingData {
    [self refreshData];
}

/**
 加载更多数据
 */
- (void)moreLoadingData {
    [self loadMoreData];
}
#pragma mark  -  init
- (void)loadPaly {
    [self.teamAnnounceView.tableView registerNib:STSmallPlayShopTableViewCell.loadNib forCellReuseIdentifier:STSmallPlayShopTableViewCellIdentifier];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playIndex:self.currentPlayIndex];
        if(self.teamAnnounceConfig.groupDatasources.count > (self.currentPlayIndex + 1)) {
            [self preLoadIndex:self.currentPlayIndex + 1];
        }
    });
}
#pragma mark TableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamAnnounceConfig.groupDatasources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STSmallPlayShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:STSmallPlayShopTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.model = self.teamAnnounceConfig.groupDatasources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0.0, 0.0)];
    } else {
        // 向上拖动，向上拖动的指定位置后加载更多数据
        NSLog(@"向上拖动，向上拖动的指定位置后加载更多数据");
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"快点播放下一个");
    NSInteger currentIndex = round(self.teamAnnounceView.tableView.contentOffset.y / SCREEN_HEIGHT);
    if(self.currentPlayIndex != currentIndex) {
        if(self.currentPlayIndex > currentIndex) {
            [self preLoadIndex:currentIndex-1];
        } else if(self.currentPlayIndex < currentIndex) {
            [self preLoadIndex:currentIndex+1];
        }
        self.currentPlayIndex = currentIndex;
        NSLog(@"播放下一个");
        [self playIndex:self.currentPlayIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat currentIndex = self.teamAnnounceView.tableView.contentOffset.y / SCREEN_HEIGHT;
    if(fabs(currentIndex - self.currentPlayIndex)>1) {
        [self.videoPlayerManager resetPlayer];
        [self.preloadVideoPlayerManager resetPlayer];
    }
}

- (void)playIndex:(NSInteger)currentIndex {
    NSLog(@"播放下一个");
    SmallVideoPlayCell *currentCell = [self.teamAnnounceView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]];
    
    NSString *artist = nil;
    NSString *title = nil;
    NSString *cover_url = nil;
    NSURL *videoURL = nil;
    NSURL *originVideoURL = nil;
    BOOL useDownAndPlay = NO;
    AVLayerVideoGravity videoGravity = AVLayerVideoGravityResizeAspect;
    
    //关注,推荐
    SmallVideoModel *currentPlaySmallVideoModel = self.teamAnnounceConfig.groupDatasources[currentIndex];
    
    artist = currentPlaySmallVideoModel.artist;
    title = currentPlaySmallVideoModel.name;
    cover_url = currentPlaySmallVideoModel.cover_url;
    videoURL = [NSURL URLWithString:currentPlaySmallVideoModel.video_url];
    originVideoURL = [NSURL URLWithString:currentPlaySmallVideoModel.video_url];
    useDownAndPlay = YES;
    if(currentPlaySmallVideoModel.aspect >= 1.4) {
        videoGravity = AVLayerVideoGravityResizeAspectFill;
    } else {
        videoGravity = AVLayerVideoGravityResizeAspect;
    }
    
    self.fatherView = currentCell.playerFatherView;
    self.videoPlayerManager.playerModel.videoGravity = videoGravity;
    self.videoPlayerManager.playerModel.fatherView       = self.fatherView;
    self.videoPlayerManager.playerModel.title            = title;
    self.videoPlayerManager.playerModel.artist = artist;
    self.videoPlayerManager.playerModel.placeholderImageURLString = cover_url;
    self.videoPlayerManager.playerModel.videoURL = videoURL;
    self.videoPlayerManager.originVideoURL = originVideoURL;
    self.videoPlayerManager.playerModel.useDownAndPlay = YES;
    //如果设备存储空间不足200M,那么不要边下边播
    if([self deviceFreeMemorySize] < 200) {
        self.videoPlayerManager.playerModel.useDownAndPlay = NO;
    }
    [self.videoPlayerManager resetToPlayNewVideo];
}

- (CGFloat)deviceFreeMemorySize {
    /// 总大小
    float totalsize = 0.0;
    /// 剩余大小
    float freesize = 0.0;
    /// 是否登录
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
        freesize = [_free unsignedLongLongValue]*1.0/(1024);
        
        NSNumber *_total = [dictionary objectForKey:NSFileSystemSize];
        totalsize = [_total unsignedLongLongValue]*1.0/(1024);
    } else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return freesize/1024.0;
}

//预加载
- (void)preLoadIndex:(NSInteger)index {
    [self.preloadVideoPlayerManager resetPlayer];
    if(self.teamAnnounceConfig.groupDatasources.count <= index || [self deviceFreeMemorySize] < 200  || index<0) {
        return;
    }
    NSString *artist = nil;
    NSString *title = nil;
    NSString *cover_url = nil;
    NSURL *videoURL = nil;
    NSURL *originVideoURL = nil;
    BOOL useDownAndPlay = NO;
    
    //关注,推荐
    SmallVideoModel *currentPlaySmallVideoModel = self.teamAnnounceConfig.groupDatasources[index];
    artist = currentPlaySmallVideoModel.artist;
    title = currentPlaySmallVideoModel.name;
    cover_url = currentPlaySmallVideoModel.cover_url;
    videoURL = [NSURL URLWithString:currentPlaySmallVideoModel.video_url];
    originVideoURL = [NSURL URLWithString:currentPlaySmallVideoModel.video_url];
    useDownAndPlay = YES;
    
    self.preloadVideoPlayerManager.playerModel.title            = title;
    self.preloadVideoPlayerManager.playerModel.artist = artist;
    self.preloadVideoPlayerManager.playerModel.placeholderImageURLString = cover_url;
    self.preloadVideoPlayerManager.playerModel.videoURL         = videoURL;
    self.preloadVideoPlayerManager.originVideoURL = originVideoURL;
    self.preloadVideoPlayerManager.playerModel.useDownAndPlay = YES;
    self.preloadVideoPlayerManager.playerModel.isAutoPlay = NO;
    [self.preloadVideoPlayerManager resetToPlayNewVideo];
}

#pragma mark - SETTER/GETTER
- (INDouyinRefreshConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INDouyinRefreshConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

- (INDouyinRefreshInteractor *)teamAnnounceInteractor {
    if (!_teamAnnounceInteractor) {
        _teamAnnounceInteractor = [[INDouyinRefreshInteractor alloc] init];
    }
    return _teamAnnounceInteractor;
}

- (INDouyinRefreshView *)teamAnnounceView {
    if (!_teamAnnounceView) {
        _teamAnnounceView = [[INDouyinRefreshView alloc] initWithFrame:CGRectZero];
    }
    return _teamAnnounceView;
}
#pragma mark - SmallVideoPlayCellDlegate

//评论
- (void)handleCommentVidieoModel:(SmallVideoModel *)smallVideoModel {
    [[QYHTools sharedInstance] showCommentView:smallVideoModel.uid];
}
//分享
- (void)handleShareVideoModel:(SmallVideoModel *)smallVideoModel {
    KKShareObject *obj = [KKShareObject new];
    [[QYHTools sharedInstance] shareVideo:obj];
}
//喜欢
- (void)handleFavoriteVdieoModel:(SmallVideoModel *)smallVdeoModel {
    
}
//不喜欢
-(void)handleDeleteFavoriteVdieoModel:(SmallVideoModel *)smallVdeoModel {
    
}
//头像
- (void)handleClickPersonIcon:(SmallVideoModel *)smallVideoModel {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.controller.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Action
- (void) backToPreviousView:(id)sender;{
    [self.videoPlayerManager resetPlayer];
    [self.preloadVideoPlayerManager resetPlayer];
    [self.controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LazyLoad

- (DDVideoPlayerManager *)videoPlayerManager {
    if(!_videoPlayerManager) {
        _videoPlayerManager = [[DDVideoPlayerManager alloc] init];
        _videoPlayerManager.managerDelegate = self;
    }
    return _videoPlayerManager;
}

- (DDVideoPlayerManager *)preloadVideoPlayerManager {
    if(!_preloadVideoPlayerManager) {
        NSLog(@"%@",self);
        _preloadVideoPlayerManager = [[DDVideoPlayerManager alloc] init];
    }
    return _preloadVideoPlayerManager;
}

#pragma mark - dealloc
- (void)dealloc {
    [self.videoPlayerManager resetPlayer];
    [self.preloadVideoPlayerManager resetPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
