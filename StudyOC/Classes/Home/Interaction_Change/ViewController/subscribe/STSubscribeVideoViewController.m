//
//  STSubscribeVideoViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSubscribeVideoViewController.h"
#import "STVideoChannelModl.h"
#import "KKAVPlayerView.h"
#import "STNoLikeMaskView.h"
#import "STSubscribeVideoTableViewCell.h"

@interface STSubscribeVideoViewController ()<KKCommonDelegate>
{
    BOOL _isShowHeaderView;
}
@property (nonatomic,strong) NSMutableArray *nData;
@property (strong, nonatomic) KKAVPlayerView *videoPlayView; //  视图
@property (assign, nonatomic) BOOL isLoadFinish; //
@property (strong, nonatomic) UITableViewCell *currentTableViewCellView; //  视图

@end

@implementation STSubscribeVideoViewController

- (NSMutableArray *)nData {
    if (!_nData) {
        _nData = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    }
    return _nData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
//    [self requestUrl];
    XYWeakSelf;
    self.tableView.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
//        [weakSelf requestUrl];
        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf refreshData:YES shouldShowTips:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
//        [weakSelf requestUrl];
        [weakSelf.tableView.mj_footer endRefreshing];
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
            BOOL hasmore = [[data objectForKey:@"hasmore"] boolValue];
            if (hasmore) {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];// 没有更多数据
            }
            weakSelf.nData = [data objectForKey:@"video_list"];
            if (!weakSelf.nData.count) {
                weakSelf.isShowNoDataPageView= YES;
            } else {
                weakSelf.isShowNoDataPageView= NO;
            }
            weakSelf.isLoadFinish = YES;
            [weakSelf.tableView reloadData];
//            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.page--;
    }];
}

- (void)refreshTableViewData {
    [self.tableView.mj_header beginRefreshing];
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
    return [STSubscribeVideoTableViewCell techHeightForOjb:videoModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [STSubscribeVideoTableViewCell initializationCellWithTableView:tableView];
    STVideoChannelModl *videoModel = [STVideoChannelModl yy_modelWithDictionary:self.nData[indexPath.row]];
    [(STSubscribeVideoTableViewCell *)cell refreshData:videoModel];
    [(STSubscribeVideoTableViewCell *)cell setDelegate:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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

/**
 cell第一次显示
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_isShowHeaderView) {
//        if (indexPath.section == 1 && indexPath.row == self.dataArray.count-2 && _isLoadFinish) {
////            [self.tableView.mj_footer beginRefreshing];
//
//            NSDictionary *dict = testDataDict()[@"data"];
//            NSArray *arr = (NSArray *)dict[@"content"];
//            [self.dataArray addObjectsFromArray:arr];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//
//            [self.tableView.mj_footer endRefreshing];
//        }
//    } else {
//        if (indexPath.section == 0 && indexPath.row == self.nData.count-2 && _isLoadFinish) {
////            [self.tableView.mj_footer beginRefreshing];
//
//            NSDictionary *dict = testDataDict()[@"data"];
//            NSArray *arr = (NSArray *)dict[@"content"];
//            [self.nData addObjectsFromArray:arr];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//
//            [CATransaction commit];
//
//            [self.tableView.mj_footer endRefreshing];
//        }
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    STHomeViewController *vc = [STHomeViewController new];
//    STVideoChannelModl *videoModel = [STVideoChannelModl yy_modelWithDictionary:self.nData[indexPath.row]];
//    vc.videoUrl = videoModel.video_url;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (cell == self.playTableCellView) {
//        [self.playerView resetPlayer];
//        [(STLocationChannelTableViewCell *)cell resetPlayerView];
//    }
}

#pragma mark  -  CellDelegate
- (void)clickImageWithItem:(id)item rect:(CGRect)rect fromView:(UIView *)fromView image:(UIImage *)image indexPath:(NSIndexPath *)indexPath {
    [self playVideoInSmall:@"" oriView:fromView oriRect:rect smallType:KKSamllVideoTypeVideoCatagory];
}
//小屏播放
- (void)playVideoInSmall:(id )contentItem oriView:(UIView *)oriView oriRect:(CGRect)oriRect smallType:(KKSamllVideoType)smallType{
    NSString *videoId = @"";
    NSString *title = @"最靓丽的视频就在这里，拍摄了几天，容纳了众多美女排";
    NSString *playCount = @"347";
    NSString *url = @"http://mp.youqucheng.com/addons/project/data/uploadfiles/video/1_06257727562426755.jpg";//封面图片
    if(!url.length){
        url =@"http://mp.youqucheng.com/addons/project/data/uploadfiles/video/1_06257727562426755.jpg";
    }
    CGRect frame = [oriView convertRect:oriRect toView:self.tableView];
    [self.videoPlayView destoryVideoPlayer];
    self.videoPlayView = [[KKAVPlayerView alloc]initWithTitle:title playCount:playCount coverUrl:url videoId:videoId smallType:smallType];
    self.videoPlayView.originalFrame = frame ;
    self.videoPlayView.originalView = oriView;
    [self.tableView addSubview:self.videoPlayView];
}



- (void)didSelectWithView:(UIView *)view andCommonCell:(NSIndexPath *)index {
    STChildrenViewController *vc = [STChildrenViewController new];
    if (view.tag == 1) {
        vc.title = @"活动&编剧";
    } else {
        vc.title = @"个人主页";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpBtnClicked:(id)item {
    STNoLikeMaskView *nolikeView = [[STNoLikeMaskView alloc] initWithFrame:CGRectMake(0,
                                                                                      0,
                                                                                      Window_W,
                                                                                      Window_H)];
    [nolikeView showMaskViewIn:[[UIApplication sharedApplication] keyWindow]];
    if ([item isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)item;
        self.currentTableViewCellView = (UITableViewCell *)button.superview.superview.superview;
    }
    XYWeakSelf;
    nolikeView.btnClickedBlock = ^(UIButton * _Nonnull sender,NSMutableDictionary *dict) {
        if ([self.currentTableViewCellView isKindOfClass:[STSubscribeVideoTableViewCell class]]) {
            [(STSubscribeVideoTableViewCell *)weakSelf.currentTableViewCellView setWithdrawDic:[dict mutableCopy]];
            [(STSubscribeVideoTableViewCell *)weakSelf.currentTableViewCellView setIsShowWithdram:YES];
        }
    };
}

- (void)withdrawMothed:(UIButton *)button {
    NSIndexPath *path = [self.tableView indexPathForCell:self.currentTableViewCellView];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)jumpToUserPage:(NSString *)userId {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  -  ScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView){

    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        NSIndexPath * middleIndexPath = [self.tableView  indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + self.tableView.frame.size.height/2)];
        NSLog(@"中间的cell：第 %ld 组 %ld个",middleIndexPath.section, middleIndexPath.row);
        UITableViewCell* liveCell =(UITableViewCell *)[self.tableView cellForRowAtIndexPath:middleIndexPath];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.videoPlayView destoryVideoPlayer];
}

- (void)didMoveToParentViewController:(nullable UIViewController *)parent
{
    if (parent == nil) {
        [self.videoPlayView destoryVideoPlayer];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}


@end
