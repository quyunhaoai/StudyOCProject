//
//  STMyCircleViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/15.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STMyCircleViewController.h"
#import "STHeaderPersonView.h"
#import "STFollowTableViewCell.h"
#import "STFollowTipView.h"
#import "AddressBookClass.h"
static NSString *CellIdentifier = @"STMyCircleViewController";
@interface STMyCircleViewController ()<JXCategoryListContentViewDelegate,KKCommonDelegate>
@property (strong, nonatomic) STHeaderPersonView *headerView; //  视图
@property (strong, nonatomic) STFollowTipView *tipView; //  视图

@end

@implementation STMyCircleViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    XYWeakSelf;
    STHeaderPersonView *headerView = [[STHeaderPersonView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    headerView.backgroundColor = color_cellBg_151420;
    headerView.titleLabArray = @[@"家人0",@"亲戚0",@"同学0",@"特别0",@"朋友0"];
    [headerView.addButton setTitle:@"+个人" forState:UIControlStateNormal];
    [headerView.headerIconView addTapGestureWithBlock:^(UIView *gestureView) {
        STChildrenViewController *vc= [STChildrenViewController new];
        vc.title = @"个人主页";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.headerView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(140, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -140);
    self.tableView.height = self.view.height-120;
    [self.tableView registerNib:[STFollowTableViewCell loadNib] forCellReuseIdentifier:CellIdentifier];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 59)];
    head.backgroundColor = color_cellBg_151420;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"通讯录添加" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_12;
    [button setBackgroundColor:KKColor(255, 33, 144, 1)];
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(chickALLPhotoNumber:) forControlEvents:UIControlEventTouchUpInside];
    [head addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(head);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    self.tableView.tableHeaderView = head;

    [self refreshData:YES shouldShowTips:YES];

    self.tableView.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
       
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)chickALLPhotoNumber:(UIButton *)button {
    NSString *allphone =[NSString stringWithFormat:@"%@", [[AddressBookClass sharedObject] chackAllpeopleInfo]];
    
    allphone = [allphone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    allphone = [allphone stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    allphone = [allphone stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    allphone = [allphone stringByReplacingOccurrencesOfString:@" "  withString:@""];
    NSString *content = [NSString stringWithFormat:@"%@('%@')",@"allPhone:",allphone];
    NSLog(@"---%@---",content);
    STChildrenViewController *tableVc = [STChildrenViewController new];
    tableVc.title = @"通讯录";
    [self.navigationController pushViewController:tableVc animated:YES];
    
}
- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip {
    [self.tableView addSubview:self.tipView];
    [self.tipView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@20);
    }];
    [self.tipView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.tipView);
        make.left.mas_equalTo(self.tipView).mas_offset(30);
        make.width.mas_equalTo(Window_W - 60);
    }];
    [self.tipView.closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipView.titleLabel.mas_right).mas_offset(7);
        make.centerY.mas_equalTo(self.tipView);
    }];
    XYWeakSelf;
    [self.tipView.closeButton addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.tableView.contentOffset = CGPointMake(0, -120);
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
        [weakSelf.tipView removeFromSuperview];
    }];
    [self.tipView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.tableView.contentOffset = CGPointMake(0, -120);
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
        [weakSelf.tipView removeFromSuperview];
    }];

//  [self performSelector:@selector(showRefreshTipParam:) withObject:@[@(NO),@(YES)] afterDelay:2.0];
    
}
- (void)showRefreshTipParam:(NSArray *)array{
    [self showRefreshTip:[[array safeObjectAtIndex:0]boolValue] animate:[[array safeObjectAtIndex:1]boolValue]];
}

- (void)showRefreshTip:(BOOL)isShow animate:(BOOL)animate{
    self.tableView.contentOffset = CGPointMake(0, -120);
    self.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    [self.tipView removeFromSuperview];
    if(animate){
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
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
    cell.delegate = self;
    cell.userHeadIcon.image = IMAGE_NAME(STSystemDefaultImageName);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 392;
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
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  -  cell代理
- (void)jumpBtnClicked:(id)item {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}

- (STFollowTipView *)tipView {
    if (!_tipView) {
        _tipView = ({
            STFollowTipView *view = [STFollowTipView new];
            view.titleLabel.text = @"抱歉，当前您还未添加个人粉号！";
            view.backgroundColor = KKColor(3, 52, 59, 1);
            view;
        });
    }
    return _tipView;
}

//- (STRecommonPersonView *)recommonView {
//    if (!_recommonView) {
//        _recommonView = ({
//            STRecommonPersonView *view = [STRecommonPersonView new];
//            view;
//        });
//    }
//    return _recommonView;
//}

@end
