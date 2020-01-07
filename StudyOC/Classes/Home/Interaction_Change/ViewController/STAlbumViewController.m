//
//  STAlbumViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STAlbumViewController.h"

#import "STVideoChannelModl.h"

#import "STHomeVideoTableViewCell.h"

#import "STHomeViewController.h"
#import "STNoLikeMaskView.h"

#import "KKAVPlayerView.h"
#import "STKWWebViewController.h"

#import "STVideoDetailViewController.h"
@interface STAlbumViewController ()<JXCategoryListContentViewDelegate,UITableViewDelegate,UITableViewDataSource,KKAVPlayerViewDelegate,KKCommonDelegate,SDCycleScrollViewDelegate>
{
    UILabel *_messageLabel;
}
@property (assign, nonatomic) BOOL isShowHeaderView;
@property (strong, nonatomic) NSMutableArray *nData;  //  数组
@property (assign, nonatomic) BOOL isLoadFinish; // 是否加载完成
@property (strong, nonatomic) STHomeVideoTableViewCell *currentPlayingCell; //  视图
@property (strong, nonatomic) SDCycleScrollView *headerView; //  视图
@property (strong, nonatomic) KKAVPlayerView *videoPlayView; //  视图
@property (strong, nonatomic) NSIndexPath *currentCellIndexPath;    //
@property (assign, nonatomic) NSInteger currentPlayingIndex;
@property (strong, nonatomic) NSMutableArray *visibleIndexArray;
@property (assign, nonatomic) CGFloat cellHeight;
@end

@implementation STAlbumViewController

- (UIView *)listView{
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    _visibleIndexArray = [NSMutableArray array];
    [self requestUrl];
    XYWeakSelf;
    self.tableView.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
        [weakSelf requestUrl];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestUrl];
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

- (void)requestUrl {
    XYWeakSelf;
    NSDictionary *params = @{@"i":@(1),
                             @"page":@(self.page),
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:@"/video/list"
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = [dic objectForKey:@"data"];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            NSMutableArray *arr = [data objectForKey:@"video_list"];
            if (arr.count) {
                [XXFileManger writeArray:arr ToPlistFileWithName:@"video_list"];
                weakSelf.nData = [arr mutableCopy];
            } else {
                weakSelf.nData = [XXFileManger readArrayFromDocumentWithFileName:@"video_list"];
            }
            [weakSelf.nData addObjectsFromArray:arr];
            [weakSelf.nData addObjectsFromArray:arr];
            if (!weakSelf.nData.count) {
                weakSelf.isShowNoDataPageView= YES;
            } else {
                weakSelf.isShowNoDataPageView= NO;
            }
            weakSelf.isLoadFinish = YES;
            [weakSelf.tableView reloadData];
            BOOL hasmore = [[data objectForKey:@"hasmore"] boolValue];
            if (hasmore) {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];// 没有更多数据
            }
            weakSelf.currentPlayingCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [weakSelf.currentPlayingCell addPlayView];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.page--;
    }];
}

- (void)addheaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            Window_W,
                                                            (Window_W*0.39))];
    [view addSubview:self.headerView];
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(view).mas_offset(10);
        make.right.bottom.mas_equalTo(view).mas_offset(-10);
    }];
    view.backgroundColor = color_cellBg_151420;
    self.tableView.tableHeaderView = view;
}

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip {
    NSInteger total = self.nData.count;
    if(total > 0){
        self.refreshTipLabel.text = [NSString stringWithFormat:@"为你推荐%ld条消息",total];
    }else{
        self.refreshTipLabel.text = @"没有更多更新";
    }
    if(showTip){
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(self.refreshTipLabel.height);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
        
        [self performSelector:@selector(showRefreshTipParam:)
                   withObject:@[@(NO),@(YES)] afterDelay:2.0];
    }
}

- (void)showRefreshTipParam:(NSArray *)array{
    [self showRefreshTip:[[array safeObjectAtIndex:0]boolValue]
                 animate:[[array safeObjectAtIndex:1]boolValue]];
}

- (void)showRefreshTip:(BOOL)isShow animate:(BOOL)animate{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(isShow ? self.refreshTipLabel.height : 0);
    }];
    if(animate){
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}
#pragma mark  -  TableDelegate - DataSoureDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isShowHeaderView ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        return self.dataArray.count;
    }
    return self.nData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    STVideoChannelModl *videoModel = [STVideoChannelModl yy_modelWithDictionary:self.nData[indexPath.row]];
    _cellHeight = [STHomeVideoTableViewCell techHeightForOjb:videoModel];
    return [STHomeVideoTableViewCell techHeightForOjb:videoModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [STHomeVideoTableViewCell initializationCellWithTableView:tableView];
    STVideoChannelModl *videoModel = [STVideoChannelModl yy_modelWithDictionary:[self.nData safeObjectAtIndex:indexPath.row]];
    [(STHomeVideoTableViewCell *)cell refreshData:videoModel];
    [(STHomeVideoTableViewCell *)cell setDelegate:self];
    [(STHomeVideoTableViewCell *)cell setIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  _isShowHeaderView && section ? 30.f : 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = kBlackColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Window_W, 30)];
    [view addSubview:label];
    label.text = @"刚刚看到这里，点击刷新";
    label.font = FONT_10;
    [label setTextColor:kWhiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setUserInteractionEnabled:YES];
    XYWeakSelf;
    [label addTapWithGestureBlock:^(UITapGestureRecognizer *gesture) {
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    view.hidden = _isShowHeaderView && section ? NO : YES;
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self addOneIndexPathToVisibleIndexArrayWithValue:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_visibleIndexArray removeObject:indexPath];
    if(_currentPlayingIndex==indexPath.row){
        if(_currentPlayingCell){
            [_currentPlayingCell removeFromSuperview];
            _currentPlayingCell = nil;
        }
    }
}
#pragma mark  -  CellDelegate
- (void)clickImageWithItem:(id)item rect:(CGRect)rect fromView:(UIView *)fromView image:(UIImage *)image indexPath:(NSIndexPath *)indexPath {
    self.currentCellIndexPath = indexPath;
    self.currentPlayingCell = [self.tableView cellForRowAtIndexPath:self.currentCellIndexPath];
    [self playVideoInSmall:item
                   oriView:fromView
                   oriRect:rect
                 smallType:KKSamllVideoTypeVideoCatagory];
}
//小屏播放
- (void)playVideoInSmall:(id )contentItem oriView:(UIView *)oriView oriRect:(CGRect)oriRect smallType:(KKSamllVideoType)smallType{
    STVideoChannelModl *model = (STVideoChannelModl *)contentItem;
    NSString *videoId =model.video_url;
    NSString *title = model.video_title;
    NSString *playCount = STRING_FROM_INTAGER(model.play_volume);
    NSString *url = model.video_thumb;//封面图片
    CGRect frame = [oriView convertRect:oriRect toView:self.tableView];
    [self.videoPlayView destoryVideoPlayer];
    self.videoPlayView = [[KKAVPlayerView alloc]initWithTitle:title
                                                    playCount:playCount
                                                     coverUrl:url
                                                      videoId:videoId
                                                    smallType:smallType];
    self.videoPlayView.originalFrame = frame;
    self.videoPlayView.originalView = oriView;
    self.videoPlayView.delegate = self;
    [self.tableView addSubview:self.videoPlayView];
}

#pragma mark  -  cellDelegate
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    if (type == KKBarButtonTypeComment) {
        STVideoChannelModl *model = (STVideoChannelModl *)item;
        KKShareObject *obj = [KKShareObject new];
        obj.title = model.video_title;
        obj.dataUrl = model.video_url;
        obj.desc = model.video_desc;
        obj.shareContent = model.video_desc;
        obj.linkUrl = model.video_thumb;
        [[QYHTools sharedInstance] showCommentView:model.video_id];
    }
}
- (void)jumpBtnClicked:(id)item {
    STVideoChannelModl *model = (STVideoChannelModl *)item;
    KKShareObject *obj = [KKShareObject new];
    obj.title = model.video_title;
    obj.dataUrl = model.video_url;
    obj.desc = model.video_desc;
    obj.shareContent = model.video_desc;
    obj.linkUrl = model.video_thumb;
    [[QYHTools sharedInstance] shareVideo:obj];
}

- (void)jumpToUserPage:(NSString *)userId {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  -  计算可播放cell
- (BOOL)judgeOneIndexPathIsExistInVisibleIndexArrayWithValue:(NSIndexPath *)indexPath
{
    NSInteger visibleCount = [_visibleIndexArray count];
    for(int i=0;i<visibleCount;i++){
        NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
        if(oneIndexPath.row==indexPath.row){
            return YES;
        }
    }
    return NO;
}
//添加有效的cell
- (void)addOneIndexPathToVisibleIndexArrayWithValue:(NSIndexPath *)indexPath
{
    BOOL isExist = [self judgeOneIndexPathIsExistInVisibleIndexArrayWithValue:indexPath];
    if(!isExist){
        [_visibleIndexArray addObject:indexPath];
    }
}

- (NSInteger)getCurrentCellIndexShouldBePlaying
{
    NSInteger visibleCount = [_visibleIndexArray count];
    if(visibleCount==2){
        CGFloat offsetY = self.tableView.contentOffset.y;
        CGFloat totalCount = self.tableView.height/_cellHeight;
        CGFloat offsetIndex = offsetY/_cellHeight;
        CGFloat firstShowValue = ceilf(offsetIndex)-offsetIndex;
        CGFloat secondShowValue = totalCount-firstShowValue;
        NSIndexPath *firstIndexPath = [_visibleIndexArray firstObject];
        NSIndexPath *lastIndexPath = [_visibleIndexArray lastObject];
        if(offsetY==0 || (secondShowValue<=firstShowValue)){
            return firstIndexPath.row;
        }
        else{
            return lastIndexPath.row;
        }
    }
    else if(visibleCount==3){
        NSIndexPath *firstIndexPath = [_visibleIndexArray firstObject];
        NSInteger smallIndex = firstIndexPath.row;
        for(int i=1;i<visibleCount;i++){
            NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
            if(oneIndexPath.row<=smallIndex){
                smallIndex=oneIndexPath.row;
            }
        }
        return smallIndex+1;
    } else if (visibleCount == 4){
        NSIndexPath *firstIndexPath = [_visibleIndexArray firstObject];
        NSInteger smallIndex = firstIndexPath.row;
        for(int i=1;i<visibleCount;i++){
            NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
            if(oneIndexPath.row<=smallIndex){
                smallIndex=oneIndexPath.row;
            }
        }
        return smallIndex+1;
    }
    return 0;
}

- (BOOL)judgeCurrentFullScreenPlayingCellIfOutOfScreen
{
    NSInteger visibleCount = [_visibleIndexArray count];
    for(int i=0;i<visibleCount;i++){
        NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
        if(_currentPlayingIndex==oneIndexPath.row){
            return NO;
        }
    }
    return YES;
}

- (void)setCurrentPlayingIndex:(NSInteger)currentPlayingIndex
{
    if(_currentPlayingIndex!=currentPlayingIndex){
        _currentPlayingIndex=currentPlayingIndex;
        _currentPlayingCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPlayingIndex inSection:0]];
        if(_currentPlayingCell){
            NSLog(@"duang duang new index is %ld",currentPlayingIndex);
            [_currentPlayingCell addPlayView];
        }
    }
}
#pragma mark  -  ScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.2];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    BOOL isOutOfScreen = [self judgeCurrentFullScreenPlayingCellIfOutOfScreen];
    if(isOutOfScreen){
        if(_currentPlayingCell){
            [_currentPlayingCell removeFromSuperview];
            _currentPlayingCell = nil;
        }
    }
    
    self.currentPlayingIndex = [self getCurrentCellIndexShouldBePlaying];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
//        NSIndexPath * middleIndexPath = [self.tableView  indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + self.tableView.frame.size.height/2)];
//        NSLog(@"中间的cell：第 %ld 组 %ld个",middleIndexPath.section, middleIndexPath.row);
//        UITableViewCell* liveCell =(UITableViewCell *)[self.tableView cellForRowAtIndexPath:middleIndexPath];
//        if ([liveCell isKindOfClass:[STLocationChannelTableViewCell class]] ) {
//            if (self.playTableCellView) {
//                [self.playerView resetPlayer];
//                self.playTableCellView.smallWindosView.hidden = YES;
//            }
//            SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
//            playerModel.videoURL = @"http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4";
//            self.playerView.autoPlay = YES;
//            self.playerView.loop = YES;
//            STLocationChannelTableViewCell *sssCell = (STLocationChannelTableViewCell *)liveCell;
//            self.playerView.fatherView = sssCell.smallWindosView;
//            sssCell.smallWindosView.hidden = NO;
//            [_playerView playWithModel:playerModel];
//            self.playTableCellView = sssCell;
//        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.videoPlayView destoryVideoPlayer];
    [self.videoPlayView removeFromSuperview];
    self.videoPlayView = nil;
}

#pragma  mark  --  headerView 懒加载
- (SDCycleScrollView *)headerView {
    
    if (!_headerView) {
        _headerView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                        delegate:self
                                                placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
        _headerView.localizationImageNamesGroup = @[IMAGE_NAME(STSystemDefaultImageName),
                                                    IMAGE_NAME(STSystemDefaultImageName),
                                                    IMAGE_NAME(STSystemDefaultImageName)];
        _headerView.titlesGroup= @[@"本周活动开始，开始报名打卡",
                                   @"本周活动开始，开始报名打卡2",
                                   @"本周活动开始，开始报名打卡3"];
        _headerView.titleLabelTextColor = kWhiteColor;
        _headerView.titleLabelTextFont = FONT_14;
        _headerView.titleLabelTextAlignment = NSTextAlignmentLeft;
        _headerView.titleLabelBackgroundColor = kClearColor;
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = 3;
        _headerView.alpha = 1;
    }
    return _headerView;
}

#pragma mark  -  cyscrollview-Delegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"你点击了第%ld个图片",index);
    STKWWebViewController *vc = [STKWWebViewController new];
    vc.title = @"活动";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  -  播放器代理
- (void)quitFullScreen {
    
}

- (void)enterFullScreen {
    
}

- (void)videoFinishPlay {
    if (self.currentCellIndexPath.row == self.nData.count-2) {
        self.currentPlayingIndex = self.nData.count-1;
        return;
    }
    if (self.currentCellIndexPath.row>=self.nData.count-1) {
        return;
    }
    self.currentPlayingIndex = self.currentCellIndexPath.row;
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.currentCellIndexPath.row+1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark  -  Get
- (NSMutableArray *)nData {
    if (!_nData) {
        _nData = [NSMutableArray arrayWithCapacity:0];
    }
    return _nData;
}
@end
