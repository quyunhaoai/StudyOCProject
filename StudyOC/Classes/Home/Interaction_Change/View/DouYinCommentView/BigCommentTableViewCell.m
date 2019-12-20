//
//  BigCommentTableViewCell.m
//  Comment布局
//
//  Created by Geb on 16/2/20.
//  Copyright © 2016年 OE. All rights reserved.
//

#import "BigCommentTableViewCell.h"
#import "CommentsPopView.h"
#define NAMEFONE 15
#define ADDRESSFONE 17
#define kScreenW [UIScreen mainScreen].bounds.size.width
@implementation BigCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadAllViews];
    }
    return self;
}

- (void)loadAllViews {
    self.backgroundColor = kClearColor;
    self.sectionTagArray = [NSMutableArray array];
    self.smallCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 10) style:UITableViewStylePlain];
    self.smallCommentTableView.delegate = self;
    self.smallCommentTableView.dataSource = self;
    self.smallCommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.smallCommentTableView.scrollEnabled = NO;
    self.smallCommentTableView.backgroundColor = kClearColor;
    [self addSubview:self.smallCommentTableView];
}

- (void)setBigCommentModel:(CommentModel *)bigCommentModel {
    _bigCommentModel = bigCommentModel;
    CGFloat height = _bigCommentModel.height;
    self.smallCommentTableView.frame = CGRectMake(0, 0, kScreenW, height);
    [self.smallCommentTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bigCommentModel.height/75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SmallCommentTableViewCell";
    CommentListReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CommentListReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (void)moreBtnClick:(UIButton *)button {
//    CGFloat height = 200.0;
//    self.smallCommentTableView.frame = CGRectMake(0, 0, kScreenW, height);
//    NSIndexSet *section = [NSIndexSet indexSetWithIndex:button.tag - 100];
//    [self.smallCommentTableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    if ([self.delegate respondsToSelector:@selector(moreBtnDidClickAndRefreshBigCommentTableView)]) {
        [self.delegate moreBtnDidClickAndRefreshBigCommentTableView];
    }
}

@end
