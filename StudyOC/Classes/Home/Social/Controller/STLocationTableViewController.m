//
//  STLocationTableViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLocationTableViewController.h"
#import "STLocationHeadView.h"
#import "STFollowTableViewCell.h"
static NSString *CellIdentifier= @"STLocationTableViewController";
@interface STLocationTableViewController ()<JXCategoryListContentViewDelegate>

@end

@implementation STLocationTableViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    STLocationHeadView *headView = [[STLocationHeadView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 44)];
    self.tableView.tableHeaderView = headView;
    [self.tableView registerNib:[STFollowTableViewCell loadNib] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = kBlueColor;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 387;
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
//    STChildrenViewController *vc = [STChildrenViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
