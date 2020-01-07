//
//  BigCommentTableViewCell.m
//  Comment布局
//
//  Created by Geb on 16/2/20.
//  Copyright © 2016年 OE. All rights reserved.
//

#import "BigCommentTableViewCell.h"
#import "SmallSectionHeader.h"
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
    self.smallCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 10) style:UITableViewStylePlain];
    self.smallCommentTableView.delegate = self;
    self.smallCommentTableView.dataSource = self;
    self.smallCommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.smallCommentTableView.scrollEnabled = NO;
    self.smallCommentTableView.bounces = NO;
    self.smallCommentTableView.backgroundColor = kClearColor;
    [self addSubview:self.smallCommentTableView];
}

- (void)setBigCommentModel:(CommentModel *)bigCommentModel {
    _bigCommentModel = bigCommentModel;
    CGFloat height = _bigCommentModel.height;
    for (NSDictionary *dict in _bigCommentModel.recent_replay) {
        CommentModel *model = [CommentModel yy_modelWithDictionary:dict];
        height = height +model.height;
    }
    self.smallCommentTableView.frame = CGRectMake(0, 0, kScreenW, height+(_bigCommentModel.first_hasmore?30:0));
    [self.smallCommentTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bigCommentModel.recent_replay.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *kCommentListCell= @"kCommentListCell";
        CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentListCell];
        if (cell == nil) {
            cell = [[CommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentListCell];
        }
        [cell initData:_bigCommentModel];
        return cell;
    } else {
        static NSString *identifier = @"SmallCommentTableViewCell";
        CommentListReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[CommentListReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell initData:[CommentModel yy_modelWithDictionary:_bigCommentModel.recent_replay[indexPath.row-1]]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return _bigCommentModel.height;
    } else {
        CommentModel *model = [CommentModel yy_modelWithDictionary:_bigCommentModel.recent_replay[indexPath.row-1]];
        return model.height;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [SmallSectionHeader getSmallSectioHeaderHeight:_bigCommentModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SmallSectionHeader *header = [[SmallSectionHeader alloc] init];
    header.smallCommentModel = self.bigCommentModel;
    header.moreBtn.tag = 100+section;
    [header.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return header;		
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        if ([self.delegate respondsToSelector:@selector(didClickBigCommentTableViewCell:andReplyType:)]) {
            _bigCommentModel.indexRow = self.indexRow;
            [self.delegate didClickBigCommentTableViewCell:_bigCommentModel andReplyType:commentType];
        }
    } else {
        CommentModel *model = [CommentModel yy_modelWithDictionary:_bigCommentModel.recent_replay[indexPath.row-1]];
        model.indexRow = self.indexRow;
        if ([self.delegate respondsToSelector:@selector(didClickBigCommentTableViewCell:andReplyType:)]) {
            [self.delegate didClickBigCommentTableViewCell:model andReplyType:replyCommentType];
        }
    }
}

- (void)moreBtnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didMoreDataBigCommentTableViewCell:)]) {
        [self.delegate didMoreDataBigCommentTableViewCell:self.indexRow];
    }
}

@end
