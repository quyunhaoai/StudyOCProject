//
//  STLocationChannelViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/17.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLocationChannelViewController.h"
#import "STLocationChannelTableViewCell.h"

#import "STHomeViewController.h"
#import "SDRefreshHeader.h"
#import "SLLocationHelp.h"
static NSString *cellIdentifierTop = @"STLocationChannelTableViewCellcellIdentifierTop";
static NSString *cellIdentifierVideo = @"STLocationChannelTableViewCellcellIdentifierVideo";
static NSString *cellIdentifierPerson = @"STLocationChannelTableViewCellcellIdentifierPerson";
@interface STLocationChannelViewController ()<UITableViewDelegate, UITableViewDataSource,KKCommonDelegate,SuperPlayerDelegate,JXCategoryListContentViewDelegate>
{
    WMZDialog *myAlert;
    WMZDialog *openAlert;
    WMZDialog *fillAlert;
    NSString *cityName;
}
@property (assign, nonatomic) BOOL isShowHeaderView;
@property (strong, nonatomic) NSMutableArray *nData;  //  数组
@property (assign, nonatomic) BOOL isLoadFinish; // 是否加载完成
@property (strong, nonatomic) SuperPlayerView *playerView;
@property (strong, nonatomic) STLocationChannelTableViewCell *playTableCellView; //  视图

@end

@implementation STLocationChannelViewController

- (UIView *)listView {
    return self.view;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view).mas_offset(-TAB_BAR_HEIGHT);
    }];
//    [self locationAction:nil];
    [self.refreshTipLabel removeFromSuperview];
    NSDictionary *dict = testDataDict()[@"data"];
    self.nData = [NSMutableArray arrayWithArray:dict[@"content"]];
    self.isLoadFinish = YES;
    XYWeakSelf;
    self.tableView.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
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
//            [weakSelf refreshData:YES shouldShowTips:YES];

        });
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.isLoadFinish = YES;
            if (!weakSelf.isShowHeaderView) {
//                weakSelf.isShowHeaderView = YES;
                NSDictionary *dict = testDataDict()[@"data"];
                NSArray *arr = (NSArray *)dict[@"content"];
                [weakSelf.nData addObjectsFromArray:arr];
            } else {
//                weakSelf.isShowHeaderView = YES;
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

    [self.tableView registerClass:[STLocationChannelTableViewCell class] forCellReuseIdentifier:cellIdentifierVideo];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}


- (void)refreshTableViewData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip {
    NSInteger total = 10;
    if(total > 0){
        self.refreshTipLabel.text = @"为你推荐10条消息";
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
//    if (indexPath.row == 0) {
//      return [STRecommendTopTableViewCell techHeightForOjb:@""];
//    }
    return [STLocationChannelTableViewCell techHeightForOjb:@""];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (!indexPath.section) {
//        if (indexPath.row == 0) {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTop];
//            [(STRecommendTopTableViewCell *)cell setDelegate:self];
//        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
            [(STLocationChannelTableViewCell *)cell refreshData:@""];
            [(STLocationChannelTableViewCell *)cell setDelegate:self];
//        }
    } else {
//        if (indexPath.row == 0) {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierPerson];
//            [(STPopularitylistTableViewCell *)cell setDelegate:self];
//        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
            [(STLocationChannelTableViewCell *)cell refreshData:@""];
            [(STLocationChannelTableViewCell *)cell setDelegate:self];
//        }
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
- (void)jumpBtnClicked:(id)item {
    KKShareObject *obj = [KKShareObject new];
    [[QYHTools sharedInstance] shareVideo:obj];
    
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
        if (self.playTableCellView) {
            self.playTableCellView.smallWindosView.hidden = YES;
            [self.playerView resetPlayer];
            self.playerView = nil;
        }
        STLocationChannelTableViewCell* videoCell =(STLocationChannelTableViewCell *)[self.tableView cellForRowAtIndexPath:middleIndexPath];
        videoCell.smallWindosView.hidden = NO;
        self.playerView.fatherView = videoCell.smallWindosView;
        SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
        playerModel.videoURL = @"http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4";
        self.playerView.autoPlay = YES;
        self.playerView.loop = YES;
        [_playerView playWithModel:playerModel];
        self.playTableCellView = videoCell;
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

#pragma mark  -  resetplayView

- (void)resetPlayerView {
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playerView resetPlayer];
    self.playerView = nil;
    if (self.playTableCellView) {
        self.playTableCellView.smallWindosView.hidden = YES;
        self.playTableCellView = nil;
    }
}

- (void)didMoveToParentViewController:(nullable UIViewController *)parent
{
    if (parent == nil) {
        [self.playerView resetPlayer];
        self.playerView = nil;
    }
    if (self.playTableCellView) {
        self.playTableCellView.smallWindosView.hidden = YES;
    }
}

#pragma mark  -  WMZDailog
//优酷自定义方法
- (void)youkuAction:(UIButton*)sender{
    NSLog(@"优酷点击");
    //关闭
    [myAlert closeView];
    if (sender.tag == 100) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
- (void)fillAction:(UIButton *)button {
    [fillAlert closeView];
    if (button.tag == 100) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
- (void)openAction:(UIButton *)button {
    [openAlert closeView];
    if (button.tag == 100) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
- (void)wmzdailogView {
    __weak STLocationChannelViewController *WEAK = self;
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlert = nil;
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        mainView.backgroundColor = KKColor(66, 177, 230, 1.0);
        UIView *view= [[UIView alloc] init];
        view.backgroundColor =kWhiteColor;
        view.frame = CGRectMake(0, 0, WIDTH(mainView), 199);
        [mainView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.frame = CGRectMake(14, 13, 14, 14);
        
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"close_nav_icon"];
        image.frame = CGRectMake(14, 13, 14, 14);
        [view addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:15.0f];
        la.text = @"您当前的城市为";
        la.textAlignment = NSTextAlignmentCenter;
        la.numberOfLines = 0;
        la.frame = CGRectMake(10, CGRectGetMaxY(image.frame)+37, mainView.frame.size.width-20, 21);
        [view addSubview:la];
        
        UILabel *la1 = [UILabel new];
        la1.font = [UIFont systemFontOfSize:15.0f];
        la1.text = cityName;
        la1.textAlignment = NSTextAlignmentCenter;
        la1.numberOfLines = 0;
        la1.frame = CGRectMake(10, CGRectGetMaxY(la.frame)+27, mainView.frame.size.width-20, 21);
        [view addSubview:la1];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        know.frame = CGRectMake(47, MaxY(view.frame)+15, mainView.frame.size.width-94, 31);
        [know setTitle:@"确定" forState:UIControlStateNormal];
        [know setTitleColor:kWhiteColor forState:UIControlStateNormal];
        know.layer.cornerRadius = 15;
        know.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
        know.layer.borderWidth = 1;
        [know addTarget:WEAK action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}
/// 定位
- (void)locationAction:(id )cityLocationView {
    __weak typeof(self) weakSelf = self;
    [[SLLocationHelp sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        
        if (placemark.locality) {

            cityName = placemark.locality;
            [weakSelf wmzdailogView];
            
        } else {

        }
        
    } status:^(CLAuthorizationStatus status) {
        
        if (status != kCLAuthorizationStatusAuthorizedAlways && status != kCLAuthorizationStatusAuthorizedWhenInUse) {
            //定位不能用
            [weakSelf wmzdailogOpenView];
            
        } else {
            //定位中。。。
        }
        
        
    } didFailWithError:^(NSError *error) {
        //定位失败
        [weakSelf wmzdailogFillView];
    }];
}

- (void)wmzdailogOpenView {
    __weak STLocationChannelViewController *WEAK = self;
    openAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        openAlert = nil;
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        mainView.backgroundColor = KKColor(66, 177, 230, 1.0);
        UIView *view= [[UIView alloc] init];
        view.backgroundColor =kWhiteColor;
        view.frame = CGRectMake(0, 0, WIDTH(mainView), 199);
        [mainView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.frame = CGRectMake(14, 13, 14, 14);
        
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"close_nav_icon"];
        image.frame = CGRectMake(14, 13, 14, 14);
        [view addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:20.0f];
        la.text = @"请开启定位功能";
        la.textAlignment = NSTextAlignmentCenter;
        la.numberOfLines = 0;
        la.frame = CGRectMake(10, CGRectGetMaxY(image.frame)+91, mainView.frame.size.width-20, 21);
        [view addSubview:la];
        
        UILabel *la1 = [UILabel new];
        la1.font = [UIFont systemFontOfSize:15.0f];
        la1.text = @"观看您所在的城市视频";
        la1.textAlignment = NSTextAlignmentCenter;
        la1.numberOfLines = 0;
        la1.frame = CGRectMake(10, CGRectGetMaxY(la.frame)+9, mainView.frame.size.width-20, 21);
        [view addSubview:la1];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        know.frame = CGRectMake(47, MaxY(view.frame)+15, mainView.frame.size.width-94, 31);
        [know setTitle:@"开启" forState:UIControlStateNormal];
        know.tag = 100;
        [know setTitleColor:kWhiteColor forState:UIControlStateNormal];
        know.layer.cornerRadius = 15;
        know.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
        know.layer.borderWidth = 1;
        [know addTarget:WEAK action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}
- (void)wmzdailogFillView {
    __weak STLocationChannelViewController *WEAK = self;
    fillAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        fillAlert = nil;
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        mainView.backgroundColor = KKColor(66, 177, 230, 1.0);
        UIView *view= [[UIView alloc] init];
        view.backgroundColor =kWhiteColor;
        view.frame = CGRectMake(0, 0, WIDTH(mainView), 199);
        [mainView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(fillAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.frame = CGRectMake(14, 13, 14, 14);
        
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"close_nav_icon"];
        image.frame = CGRectMake(14, 13, 14, 14);
        [view addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:20.0f];
        la.text = @"抱歉，无法定位";
        la.textAlignment = NSTextAlignmentCenter;
        la.numberOfLines = 0;
        la.frame = CGRectMake(10, CGRectGetMaxY(image.frame)+91, mainView.frame.size.width-20, 21);
        [view addSubview:la];
        
        UILabel *la1 = [UILabel new];
        la1.font = [UIFont systemFontOfSize:15.0f];
        la1.text = @"请开启定位功能";
        la1.textAlignment = NSTextAlignmentCenter;
        la1.numberOfLines = 0;
        la1.frame = CGRectMake(10, CGRectGetMaxY(la.frame)+9, mainView.frame.size.width-20, 21);
        [view addSubview:la1];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        know.frame = CGRectMake(47, MaxY(view.frame)+15, mainView.frame.size.width-94, 31);
        [know setTitle:@"开启" forState:UIControlStateNormal];
        know.tag = 100;
        [know setTitleColor:kWhiteColor forState:UIControlStateNormal];
        know.layer.cornerRadius = 15;
        know.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
        know.layer.borderWidth = 1;
        [know addTarget:WEAK action:@selector(fillAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}
@end
