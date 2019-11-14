//
//  STSearchView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/22.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define bigVerticalMargin 10
#define smallVerticalMargin 8
#define bigHorizontalMargin 12
#define smallHorizontalMargin 8
#import "STSearchView.h"
#import "STSearchHotTableViewCell.h"
#import "STSearchHistoryTableViewCell.h"
#import "STSearchTextFildeView.h"
#import "STSearchTableViewSetionHeaderView.h"

#import "STSearchResultTableViewController.h"
#import "FLJSearchBar.h"
@interface STSearchView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate>
@property (strong, nonatomic) UITableView *tableView; //  视图
@property (nonatomic,strong) UIButton *rightNavBtn; //  按钮
@property (strong, nonatomic) STSearchTextFildeView *searchTextField;  // 文本框

@property(nonatomic , strong)NSMutableArray * serverDataArr;

@property (strong, nonatomic) NSMutableArray *recommendModelArray;  // 推荐 数组
@property (strong, nonatomic) NSMutableArray *historyArray;  // 历史 数组

@property (strong, nonatomic) FLJSearchBar *searchBar; //  视图
@property (assign, nonatomic) BOOL isopen1; //
@property (assign, nonatomic) BOOL isopen2; //
@end
@implementation STSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.historyArray = [[defaults objectForKey:@"history"] mutableCopy];
        self.recommendModelArray = [NSMutableArray arrayWithArray:@[@"aaa",@"bbb",@"c",@"aaa",@"bbb",@"c",@"aaa",@"bbb",@"c",@"aaa",@"bbb",@"c"]];
        self.serverDataArr = [NSMutableArray array];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = color_viewBG_1A1929;
    }
    return _tableView;
}

- (void)setupUI {
    self.userInteractionEnabled = YES;
    [self addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.right.left.bottom.mas_equalTo(self);
    }];
    [self customNavBarWithSearchView];
    [self addfootView];
}

- (void)addfootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
    footView.backgroundColor = kClearColor;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 0, Window_W-24, 1)];
    [line setBackgroundColor:COLOR_HEX_RGB(0x424153)];
    [footView addSubview:line];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearBtn addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(footView).mas_offset(0);
        make.top.mas_equalTo(footView).mas_equalTo(1);
    }];
    [clearBtn setTitle:@"清空搜索历史" forState:UIControlStateNormal];
    [clearBtn setImage:IMAGE_NAME(@"deleteHistoryIcon") forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor colorWithRed:105.0f/255.0f green:105.0f/255.0f blue:126.0f/255.0f alpha:1.0f]  forState:UIControlStateNormal];
    [clearBtn.titleLabel setFont:FONT_11];
    [clearBtn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleDefault imageTitlePadding:5];
    self.tableView.tableFooterView = footView;
}
- (void)clearHistory:(UIButton *)button {
    if (self.historyArray.count > 0) {
        [self.historyArray removeAllObjects];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithArray:self.historyArray] forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}
#pragma mark  -  searchBar-delegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    [self endEditing:YES];
    [self dissSearchView];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isNotBlank]) {
        [self searchTitleToPushResultWithString:searchBar.text];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText scope:self.searchBar.scopeButtonTitles[1]];
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.recommendModelArray.count; i++) {
        
        NSString * storeString = self.recommendModelArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        
        if (foundRange.length) {
            
            NSDictionary *dic=@{@"nickName":storeString};
            [tempResults addObject:dic];
        }
    }
    [self.serverDataArr removeAllObjects];
    [self.serverDataArr addObjectsFromArray:tempResults];
    [self.tableView reloadData];
}

#pragma mark  -  textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isNotBlank]) {
        [self searchTitleToPushResultWithString:self.searchTextField.text];
    }
    return YES;
}
- (void)searchTitleToPushResultWithString:(NSString *)string {
    [self addItem:string];
}
-(void)addItem:(NSString *)text{
    if (![self containsText:text]) {
        [self.historyArray insertObject:text atIndex:0];
    } else {
        [self.historyArray removeObject:text];
        [self.historyArray insertObject:text atIndex:0];
    }
//    if (self.historyArray.count > 10) {
//        [self.historyArray removeLastObject];
//    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithArray:self.historyArray] forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)containsText:(NSString *)text {
    @autoreleasepool {
        for (int i = 0; i < self.historyArray.count; i ++) {
            if ([self.historyArray[i] isEqualToString:text]) {
                return YES;
            }
        }
    }
    return NO;
}
#pragma mark  -  搜索框和左右边按钮
- (void)customNavBarWithSearchView {
    //搜索框
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, NAVIGATION_BAR_HEIGHT)];
    [self addSubview:searchView];
    searchView.userInteractionEnabled = YES;
    searchView.backgroundColor = kBlackColor;
    
    FLJSearchBar* searchBar = [[FLJSearchBar alloc] initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT+10, [UIScreen mainScreen].bounds.size.width-20, 25)];
    searchBar.delegate = self;
    searchBar.placeHolderString = @"请输入搜索关键词";
    searchBar.placeHolderStringFont = [UIFont systemFontOfSize:11];
    searchBar.placeHolderStringColor = KKColor(112, 112, 112, 1.0);
    searchBar.placeHolderCenter = NO;
    searchBar.showsCancelButton = YES;
    searchBar.cancelInputDisabled = YES;
    searchBar.titleColor = [UIColor whiteColor];
    [searchBar setCancelBtnTitleColor:kWhiteColor];
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchBar setImage:[UIImage imageNamed:@"icon_search_clear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [searchView addSubview:searchBar];
    self.searchBar = searchBar;
}

- (void)rightBtnClick:(UIButton *)button {
    [self.searchTextField resignFirstResponder];

      [UIView animateWithDuration:0.3f
                       animations:^{
                           self.alpha = 0.0;
                       }
                       completion:^(BOOL finished){
                           [self removeFromSuperview];
                       }];
}
#pragma mark - tableview delegate dataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.serverDataArr.count) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
         if (cell == nil) {
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
         }
        cell.backgroundColor = color_cellBg_151420;
        cell.textLabel.textColor = kWhiteColor;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_serverDataArr[indexPath.row][@"nickName"]];
        return cell;
    }else{
        if (indexPath.section == 0) {
            STSearchHotTableViewCell* cell = [STSearchHotTableViewCell initializationCellWithTableView:tableView];
            cell.recommendModelArray = [self.recommendModelArray mutableCopy];
            XYWeakSelf;
            cell.searchHotCellLabelClickButton = ^(NSInteger tag) {
                [weakSelf searchTitleToPushResultWithString:weakSelf.recommendModelArray[tag]];
            };
            return cell;
        } else {
            STSearchHistoryTableViewCell *cell = [STSearchHistoryTableViewCell initializationCellWithTableView:tableView];
            cell.historyArray = [self.historyArray mutableCopy];
            XYWeakSelf;
            cell.searchHotCellLabelClickButton = ^(NSInteger tag) {
                [weakSelf searchTitleToPushResultWithString:weakSelf.historyArray[tag]];
            };
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.serverDataArr.count) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.serverDataArr.count) {
        return 46;
    }else {
    
        if (indexPath.section == 0) {
            CGFloat height = 0.001f;
            @autoreleasepool {
                CGRect lastFrame = CGRectMake(0, 0, 0, 0);
                for (int i = 0; i < self.recommendModelArray.count; i++) {
                    CGFloat windth = [NSString calculateFrameWidth:Window_W-bigHorizontalMargin*2 text:self.recommendModelArray[i] height:30 fontsize:13.f];

                    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(lastFrame), bigVerticalMargin+CGRectGetMaxY(lastFrame), windth + 20, 30.f)];
                    if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(lastFrame) > Window_W - 20) {
                        if (self.isopen1) {
                            baseLabel.x = bigHorizontalMargin;
                            baseLabel.y = CGRectGetMaxY(lastFrame) + 15;
                        } else {
                            baseLabel.y = CGRectGetMinY(lastFrame);
                        }
                    }
                    else {
                        baseLabel.y = CGRectGetMinY(lastFrame);
                    }
                    lastFrame = baseLabel.frame;
                    height = baseLabel.y + 30 + 15;
                }
            }
            return height;
        } else {
            if (self.historyArray.count > 0) {
                CGFloat height = 0.001f;
                @autoreleasepool {
                    CGRect lastFrame = CGRectMake(0, 0, 0, 0);
                    for (int i = 0; i < self.historyArray.count; i++) {
                        CGFloat windth = [NSString calculateFrameWidth:Window_W-bigHorizontalMargin*2 text:self.historyArray[i] height:30 fontsize:13.f];

                        UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(lastFrame), bigVerticalMargin+CGRectGetMaxY(lastFrame), windth + 20, 30.f)];
                        if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(lastFrame) > Window_W - 20) {
                            if (self.isopen2) {
                                baseLabel.x = bigHorizontalMargin;
                                baseLabel.y = CGRectGetMaxY(lastFrame) + 15;
                            } else {
                                baseLabel.y = CGRectGetMinY(lastFrame);
                            }
                        } else {
                            baseLabel.y = CGRectGetMinY(lastFrame);
                        }
                        lastFrame = baseLabel.frame;
                        height = baseLabel.y + 30 + 15;
                    }
                }
                return height;
            }
            else {
                return .00001f;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.serverDataArr.count?0:40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        STSearchTableViewSetionHeaderView *headerView = [[STSearchTableViewSetionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
        headerView.itemLabel.text = @"大家都在搜";
        headerView.itemButton.tag = 1;
        [headerView.itemButton addTarget:self action:@selector(openItem:) forControlEvents:(UIControlEventTouchUpInside)];
        return headerView;
    } else {
        STSearchTableViewSetionHeaderView *headerView = [[STSearchTableViewSetionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
        headerView.itemLabel.text = @"搜索历史";
        headerView.itemButton.tag = 2;
        [headerView.itemButton setBackgroundImage:[UIImage imageNamed:@"search_delete"] forState:(UIControlStateNormal)];
        [headerView.itemButton addTarget:self action:@selector(openItem:) forControlEvents:(UIControlEventTouchUpInside)];
        return headerView;
    }
}
- (void)openItem:(UIButton *)button {
    if (button.tag == 1) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        STSearchHotTableViewCell *hotCell = (STSearchHotTableViewCell *)cell;
        self.isopen1 = !self.isopen1;
        hotCell.searchHotDataTypeView.isShowAll = self.isopen1;
        hotCell.recommendModelArray = self.recommendModelArray;
        [self.tableView reloadData];
    } else {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        STSearchHistoryTableViewCell *historyCell = (STSearchHistoryTableViewCell *)cell;
        self.isopen2 = !self.isopen2;
        historyCell.searchHotDataTypeView.isShowAll = self.isopen2;
        historyCell.historyArray = self.historyArray;
        [self.tableView reloadData];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.serverDataArr.count) {
//        STSearchResultTableViewController *vc = [STSearchResultTableViewController new];
//        UIViewController *currentVc = [[QYHTools sharedInstance] getCurrentVC];
//        [self dissSearchView];
//        [self.currentViewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTextField resignFirstResponder];
}



- (void)dissSearchView {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}












@end
