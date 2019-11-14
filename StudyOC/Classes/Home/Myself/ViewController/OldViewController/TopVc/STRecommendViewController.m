//
//  STRecommendViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRecommendViewController.h"

#import "STRecommendTopTableViewCell.h"
#import "STRecommenVideoTableViewCell.h"
#import "STPopularitylistTableViewCell.h"

#import "STHomeViewController.h"
static NSString *cellIdentifierTop = @"cellIdentifierTop";
static NSString *cellIdentifierVideo = @"cellIdentifierVideo";
static NSString *cellIdentifierPerson = @"cellIdentifierPerson";
@interface STRecommendViewController ()<UITableViewDelegate, UITableViewDataSource,KKCommonDelegate>
@property (assign, nonatomic) BOOL isShowHeaderView;
@property (strong, nonatomic) NSMutableArray *nData;  //  数组
@property (assign, nonatomic) BOOL isLoadFinish; // 是否加载完成
@end

@implementation STRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = testDataDict()[@"data"];
    self.nData = [NSMutableArray arrayWithArray:dict[@"content"]];
    self.isLoadFinish = YES;
    XYWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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

    [self.tableView registerClass:[STRecommendTopTableViewCell class] forCellReuseIdentifier:cellIdentifierTop];
    [self.tableView registerClass:[STRecommenVideoTableViewCell class] forCellReuseIdentifier:cellIdentifierVideo];
    [self.tableView registerClass:[STPopularitylistTableViewCell class] forCellReuseIdentifier:cellIdentifierPerson];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    if (indexPath.row == 0) {
      return [STRecommendTopTableViewCell techHeightForOjb:@""];
    }
    return [STRecommenVideoTableViewCell techHeightForOjb:@""];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (!indexPath.section) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTop];
            [(STRecommendTopTableViewCell *)cell setDelegate:self];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
            [(STRecommenVideoTableViewCell *)cell refreshData:@""];
            [(STRecommenVideoTableViewCell *)cell setDelegate:self];
        }
    } else {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierPerson];
            [(STPopularitylistTableViewCell *)cell setDelegate:self];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
            [(STRecommenVideoTableViewCell *)cell refreshData:@""];
            [(STRecommenVideoTableViewCell *)cell setDelegate:self];
        }
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
    label.text = @"最新加载的位置";
    [label setTextColor:kWhiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
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

- (void)jumpToUserPage:(NSString *)userId {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  -  ScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView){
//        CGFloat sectionHeaderHeight = 30.0;
//        if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
//        }
//        else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
    }
}
@end
