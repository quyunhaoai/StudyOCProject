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
#import "SLLocationHelp.h"
#import "SLCityListViewController.h"
#import "STLocationThemeTableViewCell.h"
static NSString *CellIdentifier= @"STLocationTableViewController";
@interface STLocationTableViewController ()<JXCategoryListContentViewDelegate,SLCityListViewControllerDelegate>
@property (strong, nonatomic) STLocationHeadView *headView; //  视图
@property (strong, nonatomic) NSMutableArray *themeArray;  //  数组
@property (assign, nonatomic) BOOL isopen1; //
@end

@implementation STLocationTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    XYWeakSelf;
    STLocationHeadView *headView = [[STLocationHeadView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 44)];
    self.headView = headView;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 49)];
    [view addSubview:headView];
    self.tableView.tableHeaderView = view;
    [self.tableView registerNib:[STFollowTableViewCell loadNib] forCellReuseIdentifier:CellIdentifier];
    self.tableView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self locationCity];
    [self.headView addTapGestureWithBlock:^(UIView *gestureView) {
        SLCityListViewController *vc = [SLCityListViewController new];
        vc.delegate = weakSelf;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    [self.headView.changeLocButton addTapGestureWithBlock:^(UIView *gestureView) {
        SLCityListViewController *vc = [SLCityListViewController new];
        vc.delegate = weakSelf;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    self.isopen1 = NO;
}

- (void)sl_cityListSelectedCity:(NSString *)selectedCity Id:(NSInteger)Id {
    self.headView.currentCityLabel.text = selectedCity;
}

- (void)locationCity {
    __weak typeof(self) weakSelf = self;
    [[SLLocationHelp sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        
        if (placemark.locality) {
            weakSelf.headView.currentCityLabel.text = placemark.locality;
        } else {

        }
    } status:^(CLAuthorizationStatus status) {
        if (status != kCLAuthorizationStatusAuthorizedAlways && status != kCLAuthorizationStatusAuthorizedWhenInUse) {
            //定位不能用
            weakSelf.headView.currentCityLabel.text = @"定位失败";
        } else {
            //定位中。。。
            weakSelf.headView.currentCityLabel.text = @"定位中";
        }
    } didFailWithError:^(NSError *error) {
        //定位失败
        weakSelf.headView.currentCityLabel.text = @"定位失败";
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
    if (indexPath.row == 0) {
        STLocationThemeTableViewCell *cel = [STLocationThemeTableViewCell initializationCellWithTableView:tableView];
        cel.isShowAll = self.isopen1;
        cel.categortArray = self.themeArray;
        XYWeakSelf;
        cel.searchHotCellLabelClickButton = ^(NSInteger tag,STLocationThemeTableViewCell *cell) {
            if (tag == BUTTON_TAG(110)) {
                weakSelf.isopen1 = YES;
                cell.isShowAll = YES;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        return cel;
    }
    STFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat height = 0.001f;
        int line = 1;
       @autoreleasepool {
           CGRect lastFrame = CGRectMake(0, 12, 0, 0);
           for (int i = 0; i < self.themeArray.count; i++) {
               CGFloat windth = [NSString calculateFrameWidth:Window_W-12*2 text:self.themeArray[i] height:30 fontsize:13.f];

               UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + CGRectGetMaxX(lastFrame), 10+CGRectGetMaxY(lastFrame), windth + 20, 30.f)];
               if (windth + 20 + 12*2 + CGRectGetMaxX(lastFrame) > Window_W - 20) {
//                   if (self.isopen1 && line<2) {
                       baseLabel.x = 12;
                       baseLabel.y = CGRectGetMaxY(lastFrame) + 15;
//                   } else {
//                       baseLabel.y = CGRectGetMinY(lastFrame);
//                   }
                   if (!self.isopen1 && line>1) {
                       break;
                   } else {
                   }
                   line +=1;
                   line+=1;
               }
               else {
                   baseLabel.y = CGRectGetMinY(lastFrame);
               }
               lastFrame = baseLabel.frame;
               height = baseLabel.y + 0 + 15;
           }
       }
       return height+5;
    }
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
    if (indexPath.row == 0) {
        return;
    }
    STChildrenViewController *vc = [STChildrenViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)themeArray {
    if (!_themeArray) {
        _themeArray =[NSMutableArray arrayWithArray:@[@"ssssss",@"sss",@"ddd",@"ffff",@"sssssssss",@"sss",@"ddd",@"ffff",@"ssssss",@"sss",@"ddd",@"ffff",@"sssssssss",@"sss",@"ddd",@"ffff"]];
    }
    return _themeArray;
}
@end
