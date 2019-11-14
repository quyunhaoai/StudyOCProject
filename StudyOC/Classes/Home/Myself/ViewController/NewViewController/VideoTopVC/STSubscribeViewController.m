//
//  STSubscribeViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoChannelTableViewCell.h"
#import "STLocationChannelTableViewCell.h"
#import "STMultigraphTableViewCell.h"
#import "STTextSinglegraphTableViewCell.h"
#import "STAdChannelTableViewCell.h"

#import "STHomeViewController.h"
#import "STNoLikeMaskView.h"

#import "STSubscribeViewController.h"
#import "SDRefreshHeader.h"
@interface STSubscribeViewController ()<UITableViewDelegate, UITableViewDataSource,KKCommonDelegate,SuperPlayerDelegate,JXCategoryListContentViewDelegate>
@property (assign, nonatomic) BOOL isShowHeaderView;
@property (strong, nonatomic) NSMutableArray *nData;  //  数组
@property (assign, nonatomic) BOOL isLoadFinish; // 是否加载完成
@property (strong, nonatomic) UITableViewCell *currentTableViewCellView; //  视图
@property (strong, nonatomic) SuperPlayerView *playerView;
@property (strong, nonatomic) STLocationChannelTableViewCell *playTableCellView; //  视图
@end

@implementation STSubscribeViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = testDataDict()[@"data"];
    self.nData = [NSMutableArray arrayWithArray:dict[@"content"]];
    self.isLoadFinish = YES;
    XYWeakSelf;
    self.tableView.mj_header = [SDRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.isLoadFinish = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary *dict = testDataDict()[@"data"];
            self.nData = [NSMutableArray arrayWithArray:dict[@"content"]];
            if (weakSelf.nData.count) {
                weakSelf.isShowHeaderView = YES;
                NSDictionary *dict = testDataDict()[@"data"];
                NSArray *arr = (NSArray *)dict[@"content"];
                NSRange ran = NSMakeRange(0, arr.count);
                [weakSelf.dataArray insertObjects:arr atIndexes:[NSIndexSet indexSetWithIndexesInRange:ran]];
            } else {
                weakSelf.isShowHeaderView = NO;
            }
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [weakSelf.tableView reloadData];
            [CATransaction commit];
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf refreshData:YES shouldShowTips:YES];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.isLoadFinish = YES;
            if (!weakSelf.isShowHeaderView) {
                NSDictionary *dict = testDataDict()[@"data"];
                NSArray *arr = (NSArray *)dict[@"content"];
                [weakSelf.nData addObjectsFromArray:arr];
            } else {
                NSDictionary *dict = testDataDict()[@"data"];
                NSArray *arr = (NSArray *)dict[@"content"];
                [weakSelf.dataArray addObjectsFromArray:arr];
            }
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [weakSelf.tableView reloadData];
            [CATransaction commit];
            
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

- (void)refreshTableViewData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip {
    NSInteger total = self.nData.count;
    if(total > 0){
        self.refreshTipLabel.text =[NSString stringWithFormat:@"为你推荐%ld条消息",total];
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
        
        [self performSelector:@selector(showRefreshTipParam:) withObject:@[@(NO),@(YES)] afterDelay:2.0];
    }
}

- (void)showRefreshTipParam:(NSArray *)array{
    [self showRefreshTip:[[array safeObjectAtIndex:0]boolValue] animate:[[array safeObjectAtIndex:1]boolValue]];
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
    if (indexPath.row == 0) {
        return [STLocationChannelTableViewCell techHeightForOjb:@""];
    } else if(indexPath.row == 1){
        return [STLocationChannelTableViewCell techHeightForOjb:@""];
    } else if(indexPath.row == 2){
        return [STMultigraphTableViewCell techHeightForOjb:@""];
    } else if (indexPath.row == 3){
        return [STTextSinglegraphTableViewCell techHeightForOjb:@""];
    } else if (indexPath.row == 4){
        return [STAdChannelTableViewCell techHeightForOjb:@""];
    } else {
        return [STAdChannelTableViewCell techHeightForOjb:@""];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [STLocationChannelTableViewCell initializationCellWithTableView:tableView];
        [(STLocationChannelTableViewCell *)cell refreshData:@""];
        [(STLocationChannelTableViewCell *)cell setDelegate:self];
    } else if(indexPath.row == 1){
        cell = [STLocationChannelTableViewCell initializationCellWithTableView:tableView];
        [(STLocationChannelTableViewCell *)cell refreshData:@""];
        [(STLocationChannelTableViewCell *)cell setDelegate:self];
    } else if(indexPath.row == 2){
        cell = [STMultigraphTableViewCell initializationCellWithTableView:tableView];
        [(STMultigraphTableViewCell *)cell setDelegate:self];
        [(STMultigraphTableViewCell *)cell refreshData:@""];
    } else if (indexPath.row == 3){
        cell = [STTextSinglegraphTableViewCell initializationCellWithTableView:tableView];
        [(STTextSinglegraphTableViewCell *)cell setDelegate:self];
        [(STTextSinglegraphTableViewCell *)cell refreshData:@""];
    } else if (indexPath.row == 4){
        cell = [STAdChannelTableViewCell initializationCellWithTableView:tableView];
        [(STAdChannelTableViewCell *)cell setDelegate:self];
        [(STAdChannelTableViewCell *)cell refreshData:@""];
    } else {
        cell = [STAdChannelTableViewCell initializationCellWithTableView:tableView];
        [(STAdChannelTableViewCell *)cell setDelegate:self];
        [(STAdChannelTableViewCell *)cell refreshData:@""];
    }
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
    if (_isShowHeaderView) {
        if (indexPath.section == 1 && indexPath.row == self.dataArray.count-2 && _isLoadFinish) {
//            [self.tableView.mj_footer beginRefreshing];
            
            NSDictionary *dict = testDataDict()[@"data"];
            NSArray *arr = (NSArray *)dict[@"content"];
            [self.dataArray addObjectsFromArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            [self.tableView.mj_footer endRefreshing];
        }
    } else {
        if (indexPath.section == 0 && indexPath.row == self.nData.count-2 && _isLoadFinish) {
//            [self.tableView.mj_footer beginRefreshing];

            NSDictionary *dict = testDataDict()[@"data"];
            NSArray *arr = (NSArray *)dict[@"content"];
            [self.nData addObjectsFromArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            [CATransaction commit];
            
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STHomeViewController *vc = [STHomeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell == self.playTableCellView) {
        [self.playerView resetPlayer];
        [(STLocationChannelTableViewCell *)cell resetPlayerView];
    }
}

#pragma mark  -  CellDelegate

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
        if ([self.currentTableViewCellView isKindOfClass:[STLocationChannelTableViewCell class]]) {
//            STLocationChannelTableViewCell *cell = (STLocationChannelTableViewCell *)self.currentTableViewCellView;
//            [cell.smallWindosView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//            }];
        }
    }
    XYWeakSelf;
    nolikeView.btnClickedBlock = ^(UIButton * _Nonnull sender,NSMutableDictionary *dict) {
        if ([self.currentTableViewCellView isKindOfClass:[STVideoChannelTableViewCell class]]) {
            [(STVideoChannelTableViewCell *)weakSelf.currentTableViewCellView setWithdrawDic:[dict mutableCopy]];
            [(STVideoChannelTableViewCell *)weakSelf.currentTableViewCellView setIsShowWithdram:YES];
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
        if ([liveCell isKindOfClass:[STLocationChannelTableViewCell class]] ) {
            self.playTableCellView = (STLocationChannelTableViewCell *)liveCell;
            self.playerView.fatherView = self.playTableCellView.smallWindosView;
            self.playTableCellView.smallWindosView.hidden = NO;
            SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
            playerModel.videoURL = @"http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4";
            self.playerView.autoPlay = YES;
            self.playerView.loop = YES;
            [_playerView playWithModel:playerModel];
        }
    }
}

#pragma mark  -  superPlay
- (SuperPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[SuperPlayerView alloc] init];
        _playerView.layoutStyle = SuperPlayerLayoutStyleCompact;
        // 设置代理
        _playerView.delegate = self;
        [_playerView.controlView setHidden:YES];
        _playerView.disableGesture = NO;
    }
    return _playerView;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playerView resetPlayer];
    if (self.playTableCellView) {
        self.playTableCellView.smallWindosView.hidden = YES;
    }
}

- (void)didMoveToParentViewController:(nullable UIViewController *)parent
{
//    if (parent == nil) {
        [self.playerView resetPlayer];
//    }
    if (self.playTableCellView) {
        self.playTableCellView.smallWindosView.hidden = YES;
    }
}


@end
