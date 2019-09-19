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
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self addTableViewRefresh];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_e5e5e5;
    }
    return _tableView;
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

@end
