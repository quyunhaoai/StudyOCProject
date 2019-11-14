//
//  STZhengZhouViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STZhengZhouViewController.h"

@interface STZhengZhouViewController ()

@end

@implementation STZhengZhouViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dict = testDataDict()[@"data"];
    NSArray *arr = (NSArray *)dict[@"content"];
    [self.dataArray addObjectsFromArray:arr];

}

#pragma mark  -  TableDelegate - DataSoureDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kWidth(120);
    }
    return Window_W*0.56+130;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = nil;
//    if (!indexPath.section) {
//        if (indexPath.row == 0) {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTop];
//            [(STRecommendTopTableViewCell *)cell setDelegate:self];
//        } else {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
//            [(STRecommenVideoTableViewCell *)cell refreshData:@""];
//        }
//    } else {
//        if (indexPath.row == 0) {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierPerson];
//            [(STPopularitylistTableViewCell *)cell setDelegate:self];
//        } else {
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierVideo];
//            [(STRecommenVideoTableViewCell *)cell refreshData:@""];
//        }
//    }
//    return cell;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return  _isShowHeaderView && section ? 30.f : 0.0001f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [UIView new];
//    view.backgroundColor = kBlackColor;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Window_W, 30)];
//    [view addSubview:label];
//    label.text = @"最新加载的位置";
//    [label setTextColor:kWhiteColor];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    view.hidden = _isShowHeaderView && section ? NO : YES;
//    return view;
//}

/**
 cell第一次显示
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.dataArray.count-2) {
    
        NSDictionary *dict = testDataDict()[@"data"];
        NSArray *arr = (NSArray *)dict[@"content"];
        [self.dataArray addObjectsFromArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];

//        [CATransaction commit];
        
//        [self.tableView.mj_footer endRefreshing];
    }
    
}
@end
