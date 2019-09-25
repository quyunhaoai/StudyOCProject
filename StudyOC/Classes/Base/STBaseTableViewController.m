//
//  STBaseTableViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//
static NSString *CellIdentifier = @"UITableViewCell";
#import "STBaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "STChildrenViewController.h"
@interface STBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,readonly) UITableViewStyle style;
@end

@implementation STBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super self];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self.view addSubview:self.refreshTipLabel];
    [self.refreshTipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@30);
    }];

    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self addTableViewRefresh];
}
#pragma mark  - Get
- (UILabel *)refreshTipLabel{
    if(!_refreshTipLabel){
        _refreshTipLabel = ({
            UILabel *view = [UILabel new];
            view.backgroundColor = KKColor(214, 232, 248, 1.0);
            view.textColor = KKColor(0, 135, 211, 1);
            view.font = [UIFont systemFontOfSize:15];
            view.textAlignment = NSTextAlignmentCenter;
            view ;
        });
    }
    return _refreshTipLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_e5e5e5;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
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
/// 添加下拉刷新
- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 3; i++) {
//                [weakSelf.dataArray addObject:@""];
//            }
            [weakSelf.tableView reloadData];
//            if (kOpenRefreshHeaderViewHeight) {
//                [weakSelf suspendTopReloadHeaderViewHeight];
//            } else {
            [weakSelf.tableView.mj_header endRefreshing];
//            }
            [weakSelf refreshData:YES shouldShowTips:YES];
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 3; i++) {
//                [weakSelf.dataArray addObject:@""];
//            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCellDefultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STChildrenViewController *vc = [STChildrenViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
