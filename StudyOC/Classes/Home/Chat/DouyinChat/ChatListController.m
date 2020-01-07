//
//  ChatListController.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "ChatListController.h"
#import "EmotionHelper.h"
#import "RefreshControl.h"]
#import "ChatTextView.h"
#import "TimeCell.h"
#import "SystemMessageCell.h"
#import "ImageMessageCell.h"
#import "TextMessageCell.h"

NSString * const kTimeCell          = @"TimeCell";
NSString * const kSystemMessageCell = @"SystemMessageCell";
NSString * const kImageMessageCell  = @"ImageMessageCell";
NSString * const kTextMessageCell   = @"TextMessageCell";

@interface ChatListController () <UITableViewDelegate, UITableViewDataSource, ChatTextViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) RefreshControl                      *refreshControl;
@property (nonatomic, strong) UITableView                         *tableView;
@property (nonatomic, strong) NSMutableArray<GroupChat *>         *data;
@property (nonatomic, strong) ChatTextView                        *textView;
@property (nonatomic, assign) NSInteger                           pageIndex;
@property (nonatomic, assign) NSInteger                           pageSize;
@end


@implementation ChatListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavBarwithTitle:@"TEST" andLeftView:@""];
    self.navTitleView.backgroundColor = kBlackColor;
    self.navTitleView.titleLabel.textColor = kWhiteColor;
    self.navTitleView.splitView.backgroundColor = kClearColor;
    
    _data = [NSMutableArray array];
    
    _pageIndex = 0;
    _pageSize = 20;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - 10)];
    _tableView.backgroundColor = kClearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceVertical = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [_tableView registerClass:TimeCell.class forCellReuseIdentifier:kTimeCell];
    [_tableView registerClass:SystemMessageCell.class forCellReuseIdentifier:kSystemMessageCell];
    [_tableView registerClass:ImageMessageCell.class forCellReuseIdentifier:kImageMessageCell];
    [_tableView registerClass:TextMessageCell.class forCellReuseIdentifier:kTextMessageCell];
    [self.view addSubview:_tableView];
    
    _refreshControl = [RefreshControl new];
    __weak __typeof(self) weakSelf = self;
    [_refreshControl setOnRefresh:^{
        [weakSelf loadData:weakSelf.pageIndex pageSize:weakSelf.pageSize];
    }];
    [_tableView addSubview:_refreshControl];
    
    _textView = [ChatTextView new];
    _textView.delegate = self;
    
    [self loadData:_pageIndex pageSize:_pageSize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_textView show];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_textView dismiss];
}

-(void)receiveMessage:(NSNotification *)notification {
    
    BOOL shouldScrollToBottom = NO;
    if(_tableView.visibleCells.lastObject && [_tableView indexPathForCell:_tableView.visibleCells.lastObject].row == _data.count - 1) {
        shouldScrollToBottom = YES;
    }
    
    [UIView setAnimationsEnabled:NO];
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_data.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
    
    if(shouldScrollToBottom) {
        [self scrollToBottom];
    }
}

//load data
- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {

}

- (void)processData:(NSArray<GroupChat *> *)data {
    if(data.count == 0) {
        return;
    }
    NSMutableArray<GroupChat *> *tempArray = [NSMutableArray new];
    for(GroupChat *chat in data) {
        if((![@"system" isEqualToString:chat.msg_type]) &&
           (tempArray.count == 0 || (tempArray.count > 0 && labs([tempArray.lastObject create_time] - chat.create_time) > 60*5))) {
            GroupChat *timeChat = [GroupChat new];
            timeChat.msg_type = @"time";
            timeChat.create_time = chat.create_time;
            timeChat.cellAttributedString = [self cellAttributedString:timeChat];
            timeChat.contentSize = [self cellContentSize:timeChat];
            timeChat.cellHeight = [self cellHeight:timeChat];
            [tempArray addObject:timeChat];
        }
        chat.cellAttributedString = [self cellAttributedString:chat];
        chat.contentSize = [self cellContentSize:chat];
        chat.cellHeight = [self cellHeight:chat];
        [tempArray addObject:chat];
    }
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,[tempArray count])];
    [self.data insertObjects:tempArray atIndexes:indexes];
    [self.tableView reloadData];
}

//delete chat
- (void)deleteChat:(UITableViewCell *)cell {
    if(!cell) {
        return;
    }
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if(!indexPath) {
        return;
    }
    NSInteger index = indexPath.row;
    
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    if(index-1 < _data.count && [@"time" isEqualToString:_data[index - 1].msg_type]) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:index - 1 inSection:0]];
    }
    if(index < _data.count) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    if(indexPaths.count == 0) {
        return;
    }
}

- (void)scrollToBottom {
    if(self.data.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

//chat textview delegate
-(void)onSendText:(NSString *)text {
    @synchronized(_data) {
        GroupChat *chat = [[GroupChat alloc] initTextChat:text];
        chat.cellAttributedString = [self cellAttributedString:chat];
        chat.contentSize = [self cellContentSize:chat];
        chat.cellHeight = [self cellHeight:chat];
        
        [UIView setAnimationsEnabled:NO];
        [_tableView beginUpdates];
        [_data addObject:chat];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_data.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView endUpdates];
        [UIView setAnimationsEnabled:YES];
        
        [self scrollToBottom];
    }
}

-(void)onSendImages:(NSMutableArray<UIImage *> *)images {
    @synchronized(_data) {
        for(UIImage *image in images) {
            GroupChat *chat = [[GroupChat alloc] initImageChat:image];
            chat.contentSize = [self cellContentSize:chat];
            chat.cellHeight = [self cellHeight:chat];
            
            [UIView setAnimationsEnabled:NO];
            [_tableView beginUpdates];
            [_data addObject:chat];
            [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_data.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [_tableView endUpdates];
            [UIView setAnimationsEnabled:YES];
        }
    }
    [self scrollToBottom];
}

- (void)onEditBoardHeightChange:(CGFloat)height {
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, height, 0);
    [self scrollToBottom];
}

//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupChat *chat = _data[indexPath.row];
    return chat.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupChat *chat = _data[indexPath.row];
    __weak __typeof(self) wself = self;
    if([chat.msg_type isEqualToString:@"system"]){
        SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kSystemMessageCell forIndexPath:indexPath];
        [cell initData:chat];
        return cell;
    }else if([chat.msg_type isEqualToString:@"text"]){
        TextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextMessageCell forIndexPath:indexPath];
        __weak __typeof(cell) wcell = cell;
        cell.onMenuAction = ^(MenuActionType actionType) {
            if(actionType == DeleteAction) {
                [wself deleteChat:wcell];
            }else if(actionType == CopyAction) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = chat.msg_content;
            }
        };
        [cell initData:chat];
        return cell;
    }else  if([chat.msg_type isEqualToString:@"image"]){
        ImageMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageMessageCell forIndexPath:indexPath];
        __weak __typeof(cell) wcell = cell;
        cell.onMenuAction = ^(MenuActionType actionType) {
            if(actionType == DeleteAction) {
                [wself deleteChat:wcell];
            }
        };
        [cell initData:chat];
        return cell;
    }else {
        TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
        [cell initData:_data[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

- (NSMutableAttributedString *)cellAttributedString:(GroupChat *)chat {
    if([chat.msg_type isEqualToString:@"system"]){
        return [SystemMessageCell cellAttributedString:chat];
    }else if([chat.msg_type isEqualToString:@"text"]){
        return [TextMessageCell cellAttributedString:chat];
    }else  if([chat.msg_type isEqualToString:@"image"]){
        return nil;
    }else {
        return [TimeCell cellAttributedString:chat];
    }
}

- (CGFloat)cellHeight:(GroupChat *)chat {
    if([chat.msg_type isEqualToString:@"system"]){
        return [SystemMessageCell cellHeight:chat];
    }else if([chat.msg_type isEqualToString:@"text"]){
        return [TextMessageCell cellHeight:chat];
    }else  if([chat.msg_type isEqualToString:@"image"]){
        return [ImageMessageCell cellHeight:chat];
    }else {
        return [TimeCell cellHeight:chat];
    }
}

- (CGSize)cellContentSize:(GroupChat *)chat {
    if([chat.msg_type isEqualToString:@"system"]){
        return [SystemMessageCell contentSize:chat];
    }else if([chat.msg_type isEqualToString:@"text"]){
        return [TextMessageCell contentSize:chat];
    }else  if([chat.msg_type isEqualToString:@"image"]){
        return [ImageMessageCell contentSize:chat];
    }else {
        return [TimeCell contentSize:chat];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
