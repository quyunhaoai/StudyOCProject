//
//  ViewController.m
//  ZJIndexContacts
//
//  Created by ZeroJ on 16/10/10.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJContactViewController.h"
#import "ZJContact.h"
#import "ZJSearchResultController.h"
#import "ZJProgressHUD.h"
#import "FLJSearchBar.h"
@interface ZJContactViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate> {
    // 所有的indexsTitles
    NSArray *_allIndexTitles;
    // 存放索引对应的下标
    NSMutableArray *_sectionIndexs;
    // dataSource
    NSMutableArray *_data;
}


@property (strong, nonatomic) FLJSearchBar *searchBar;
//@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray<ZJContact *> *allData;
@property (strong, nonatomic) NSArray *resultArray;    //

@end

static CGFloat const kSearchBarHeight = 40.f;
//static CGFloat const kNavigationBarHeight = 64.f;

@implementation ZJContactViewController
- (void)viewWillAppear {
    [super viewWillAppear];
    self.dragContentView.backgroundColor = color_cellBg_151420;
    self.navTitleView.title = @"@好友";
    self.navTitleView.titleLabel.textColor = kWhiteColor;
    self.navTitleView.splitView.hidden = YES;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(startHide) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
    [self.dragContentView addSubview:self.tableView];
    [self.tableView masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dragContentView).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.bottom.equalTo(self.dragContentView);
    }];
    self.tableView.tableHeaderView = self.searchBar;
    NSArray *testArray = @[@"ZeroJ", @"曾晶", @"你好", @"曾晶", @"曾晶" , @"曾晶" , @"曾晶" , @"曾晶" , @"曾晶" , @"曾晶" , @"曾晶",  @"曾好", @"李涵", @"王丹", @"良好", @"124"];
    
    NSMutableArray<ZJContact *> *contacts = [NSMutableArray arrayWithCapacity:testArray.count];
    for (NSString *name in testArray) {
        ZJContact *test = [ZJContact new];
        test.name = name;
        test.icon = [UIImage imageNamed:@"icon"];
        [contacts addObject:test];
    }

    [self setupInitialAllDataArrayWithContacts:contacts];
    NSLog(@"%@", _sectionIndexs);
    NSLog(@"%@", _data);
}
// 设置初始的所有数据
- (void)setupInitialAllDataArrayWithContacts:(NSArray<ZJContact *> *)contacts {
    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    // 获得当前语言下的所有的indexTitles
    _allIndexTitles = localIndex.sectionTitles;
    // 初始化所有数据的数组
    _data = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    // 为每一个indexTitle 生成一个可变的数组
    for (int i = 0; i<_allIndexTitles.count; i++) {
        // 初始化数组
        [_data addObject:[NSMutableArray array]];
    }
    // 初始化有效的sectionIndexs
    _sectionIndexs = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    for (ZJContact *contact in contacts) {
        if (contact == nil) continue;

        // 获取到这个contact的name的首字母对应的indexTitle
        // 注意这里必须使用对象, 这个selector也是有要求的
        // 必须是这个对象中的selector, 并且不能有参数, 必须返回字符串
        // 所以这里直接使用 name 属性的get方法就可以
        NSInteger index = [localIndex sectionForObject:contact collationStringSelector:nameSelector];
        
        // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
        if ([contact.name hasPrefix:@"曾"]) {
            index = [_allIndexTitles indexOfObject:@"Z"];
        }
        // 将这个contact添加到对应indexTitle的数组中去
        [_data[index] addObject:contact];
    }
    
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [_sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
}
// 增加联系人
- (void)addContact:(ZJContact *)contact {
    if (contact == nil) return;

    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    NSInteger index = [localIndex sectionForObject:contact collationStringSelector:nameSelector];

    // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
    if ([contact.name hasPrefix:@"曾"]) {
        index = [_allIndexTitles indexOfObject:@"Z"];
    }
    // 将这个contact添加到对应indexTitle的数组中去
    NSMutableArray *tempContacts = [_data[index] mutableCopy];
    [tempContacts addObject:contact];
    _data[index] = tempContacts;
    // 移除原来的, 便于重新添加
    [_sectionIndexs removeAllObjects];
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [_sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
    
}
// 删除联系人
- (void)removeContact:(ZJContact *)contact {
    if (contact == nil) return;
    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    NSInteger index = [localIndex sectionForObject:contact collationStringSelector:nameSelector];
    
    // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
    if ([contact.name hasPrefix:@"曾"]) {
        index = [_allIndexTitles indexOfObject:@"Z"];
    }
    // 将这个contact从对应indexTitle的数组中删除
    NSMutableArray *tempContacts = [_data[index] mutableCopy];
    [tempContacts removeObject:contact];
    _data[index] = tempContacts;
    
    // 移除原来的, 便于重新添加
    [_sectionIndexs removeAllObjects];
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [_sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
}
#pragma mark  -  TableViewDelete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultArray.count) {
        return 1;
    }
    return _sectionIndexs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.resultArray.count) {
        return self.resultArray.count;
    }
    NSInteger index = [_sectionIndexs[section] integerValue];
    NSArray *temp = _data[index];
    return temp.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {\
    if (self.resultArray.count) {
        static NSString *const kCellId = @"kCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
//        NSArray *temp = _data[index];
        ZJContact *contact = (ZJContact *)self.resultArray[indexPath.row];
        cell.textLabel.text = contact.name;
        cell.textLabel.textColor = kWhiteColor;
        cell.imageView.image = [contact.icon circleImage];
        cell.backgroundColor = color_cellBg_151420;
        return cell;
    } else {
        static NSString *const kCellId = @"kCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
        NSArray *temp = _data[index];
        ZJContact *contact = (ZJContact *)temp[indexPath.row];
        cell.textLabel.text = contact.name;
        cell.textLabel.textColor = kWhiteColor;
        cell.imageView.image = [contact.icon circleImage];
        cell.backgroundColor = color_cellBg_151420;
        return cell;
    }
}
// sectionHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger index = [_sectionIndexs[section] integerValue];
    return _allIndexTitles[index];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor=color_cellBg_151420;
    [header.textLabel setTextColor:kWhiteColor];
}

// 这个方法是返回索引的数组, 我们需要根据之前获取到的两个数组来取到我们需要的
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:_sectionIndexs.count];
    // 遍历索引的下标数组, 然后根据下标取出_allIndexTitles对应的索引字符串
    for (NSNumber *number in _sectionIndexs) {
        NSInteger index = number.integerValue;
        [indexTitles addObject:_allIndexTitles[index]];
    }
    return indexTitles;
}

// 可以相应点击的某个索引, 也可以为索引指定其对应的特定的section, 默认是 section == index
// 返回点击索引列表上的索引时tableView应该滚动到那一个section去
// 这里我们的tableView的section和索引的个数相同, 所以直接返回索引的index即可
// 如果不相同, 则需要自己相应的返回自己需要的section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSLog(@"%@---%ld", title, index);
    // 显示正在点击的indexTitle ZJProgressHUD这个小框架是我们已经实现的
    [ZJProgressHUD showStatus:title andAutoHideAfterTime:0.5];
    return index;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
    NSArray *temp = _data[index];
    ZJContact *contact = (ZJContact *)temp[indexPath.row];
    // 删除
    [self removeContact:contact];
    // 刷新 当然数据比较大的时候可能就需要只刷新删除的对应的section了
    [tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除联系人";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZJContact *contact = nil;
    if (self.resultArray.count) {
        contact = (ZJContact *)self.resultArray[indexPath.row];
    } else {
        NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
        NSArray *temp = _data[index];
        contact = (ZJContact *)temp[indexPath.row];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnPersonName:)]) {
        [self.delegate returnPersonName:contact.name];
    }
    [self startHide];
}
#pragma mark  -  SearchDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // 更新数据 并且刷新数据
    self.resultArray = [ZJContact searchText:searchText inDataArray:self.allData];
    NSLog(@"results:%@",self.resultArray);
    [self.tableView reloadData];
}


// 这个方法在searchController 出现, 消失, 以及searchBar的text改变的时候都会被调用
// 我们只是需要在searchBar的text改变的时候才查询数据, 所以没有使用这个代理方法, 而是使用了searchBar的代理方法来处理
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSLog(@"%@", searchController.searchBar.text);
//    ZJSearchResultController *resultController = (ZJSearchResultController *)searchController.searchResultsController;
//    resultController.data = [ZJContact searchText:searchController.searchBar.text inDataArray:_allData];
//    [resultController.tableView reloadData];

}

// 这个代理方法在searchController消失的时候调用, 这里我们只是移除了searchController, 当然你可以进行其他的操作
- (void)didDismissSearchController:(UISearchController *)searchController {
    // 销毁
//    self.searchController = nil;
}

//- (UISearchController *)searchController {
//    if (!_searchController) {
//        // ios8+才可用 否则使用 UISearchDisplayController
//        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:[ZJSearchResultController new]];
//        searchController.delegate = self;
////        searchController.searchResultsUpdater = self;
//        searchController.searchBar.delegate = self;
//        searchController.searchBar.placeholder = @"搜索联系人姓名/首字母缩写";
//        _searchController = searchController;
//    }
//    return _searchController;
//}

-(NSArray<ZJContact *> *)allData {
    NSMutableArray<ZJContact *> *allData = [NSMutableArray array];
    for (NSArray *contacts in _data) {// 获取所有的contact
        if (contacts.count != 0) {
            for (ZJContact *contact in contacts) {
                [allData addObject:contact];
            }
        }
    }
    return allData;
}
- (FLJSearchBar *)searchBar {
    if (!_searchBar) {
        FLJSearchBar *searchBar = [[FLJSearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, self.dragContentView.bounds.size.width, kSearchBarHeight)];
        searchBar.delegate = self;
        searchBar.placeHolderString = @"搜索联系人姓名";
        searchBar.placeHolderStringFont = [UIFont systemFontOfSize:13];
        searchBar.placeHolderStringColor = KKColor(112, 112, 112, 1.0);
        searchBar.placeHolderCenter = NO;
        searchBar.titleColor = [UIColor whiteColor];
        searchBar.cornerRadius = 2.f;
        searchBar.borderWidth = 0.f;
        searchBar.barStyle = UISearchBarStyleProminent;
        searchBar.backgroundImage = [UIImage imageWithColor:color_cellBg_151420 size:CGSizeMake(100, kSearchBarHeight)];
        [searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:color_cellBg_151420 size:CGSizeMake(100, kSearchBarHeight)] forState:UIControlStateNormal];
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.dragContentView.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        // 行高度
        tableView.rowHeight = 64.f;
        // sectionHeader 的高度
        tableView.sectionHeaderHeight = 28.f;
        // sectionIndexBar上的文字的颜色
        tableView.sectionIndexColor = [UIColor lightGrayColor];
        // 普通状态的sectionIndexBar的背景颜色
        tableView.sectionIndexBackgroundColor = kClearColor;
        // 选中sectionIndexBar的时候的背景颜色
//        tableView.sectionIndexTrackingBackgroundColor = [UIColor yellowColor];
        tableView.backgroundColor = color_viewBG_1A1929;
        
        _tableView = tableView;
    }
    return _tableView;
}

- (NSArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSArray new];
    }
    return _resultArray;
}
@end
