//
//  CommentsPopView.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "CommentsPopView.h"
#import "EmotionHelper.h"
#import "LoadMoreControl.h"
#import "EmotionSelector.h"
#import "STEmotionChatTextView.h"
#import "BigCommentTableViewCell.h"
#import "LCActionSheet.h"
NSString * const kCommentListCell     = @"CommentListCell";
NSString * const kCommentHeaderCell   = @"CommentHeaderCell";
NSString * const kCommentFooterCell   = @"CommentFooterCell";
static NSString * const commentReplyCell = @"commentReplyCell";
static NSString * const commentMoreCell = @"LKMoreReplyContentTableViewCell";
@interface CommentsPopView () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate,UIScrollViewDelegate, ChatTextViewDelegate,BigCommentTableViewRefreshDelegate>
@property (nonatomic, assign) NSString                         *awemeId;

@property (nonatomic, assign) NSInteger                        pageIndex;
@property (nonatomic, assign) NSInteger                        pageSize;
@property (nonatomic, assign) NSInteger                        replyPageIndex;
@property (nonatomic, strong) UIView                           *container;
@property (nonatomic, strong) UITableView                      *tableView;
@property (nonatomic, strong) NSMutableArray                   *data;
@property (nonatomic, strong) STEmotionChatTextView            *textView;
@property (nonatomic, strong) LoadMoreControl                  *loadMore;
@property (nonatomic, copy) NSString                           *commentID;
@property (nonatomic, copy) NSString                           *toUserID;
@property (nonatomic, copy) NSString                           *replayID;
@property (assign, nonatomic) replayType                       replayTTT;
@property (assign, nonatomic) NSInteger                        currentIndex;
@end


@implementation CommentsPopView

- (instancetype)initWithAwemeId:(NSString *)awemeId {
    self = [super init];
    if (self) {
        self.frame = SCREEN_BOUNDS;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
        _awemeId = awemeId;
        
        _pageIndex = 1;
        _pageSize = 10;
        _replyPageIndex = 1;
        _data = [[NSMutableArray alloc] init];
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*3/4)];
        _container.backgroundColor = ColorBlackAlpha60;
        [self addSubview:_container];
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight*3/4) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0f;
        [_container addSubview:visualEffectView];
        
        
        _label = [[UILabel alloc] init];
        _label.textColor = color_text_AFAFB1;
        _label.text = @"0条评论";
        _label.font = FONT_10;
        _label.textAlignment = NSTextAlignmentCenter;
        [_container addSubview:_label];
        
        _close = [[UIImageView alloc] init];
        _close.image = [UIImage imageNamed:@"close_follow"];
        _close.contentMode = UIViewContentModeCenter;
        [_close addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        [_container addSubview:_close];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.container);
            make.height.mas_equalTo(35);
        }];
        [_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.label);
            make.right.equalTo(self.label).inset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight*3/4 - 35 - 50 - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = kClearColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = YES;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:CommentListCell.class forCellReuseIdentifier:kCommentListCell];
        [_tableView registerClass:CommentListMoreCell.class forCellReuseIdentifier:commentMoreCell];
        [_tableView registerClass:BigCommentTableViewCell.class forCellReuseIdentifier:commentReplyCell];
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _loadMore = [[LoadMoreControl alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50) surplusCount:10];
        [_loadMore setLoadingType:LoadStateLoading];
        __weak __typeof(self) wself = self;
        [_loadMore setOnLoad:^{
            [wself loadData:wself.pageIndex pageSize:wself.pageSize];
        }];
        [_tableView addSubview:_loadMore];

        [_container addSubview:_tableView];
        [self loadData:_pageIndex pageSize:_pageSize];
        _textView = [STEmotionChatTextView new];
        _textView.delegate = self;
        
        [kNotificationCenter addObserver:self selector:@selector(refreshTableView:) name:@"refreshCommentTableView" object:nil];
    }
    return self;
}

- (void)refreshTableView:(NSNotification *)not {
    [self loadData:_pageIndex-1 pageSize:_pageSize];
}

#pragma mark  -  ChattextDel
- (void)onEditBoardHeightChange:(CGFloat)height {
    if (height< 200) {
        self.commentID = @"";
        self.textView.placeholderLabel.text = @"有爱评论，说点儿好听的~";
    }
}

-(void)onSendImages:(NSMutableArray<UIImage *> *)images {
    
}

// comment textView delegate
-(void)onSendText:(NSString *)text {
    
    XYWeakSelf;
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    if ([self.commentID isNotBlank]) {
        NSDictionary *params = @{@"i":@(1),
                                 @"message":text,
                                 @"topic_id":self.awemeId,
                                 @"key":key,
                                 @"comment_id":self.commentID,
                                 @"reply_id":self.replayTTT==commentType?self.commentID:self.replayID,
                                 @"to_uid":self.toUserID,
                                 @"reply_type":self.replayTTT==commentType?@(1):@(2),
        };
        [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/video_comment_member/reply_publish" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            NSDictionary *data = [dic objectForKey:@"data"];
            if(status == 200){
                NSDictionary *returnDict = data[@"return_data"];
                CommentModel *model = [CommentModel yy_modelWithDictionary:self.data[self.currentIndex]];
                if (model.recent_replay==nil) {
                    model.recent_replay = [NSMutableArray arrayWithCapacity:1];
                }
                [model.recent_replay insertObject:returnDict atIndex:0];
                [weakSelf.data replaceObjectAtIndex:weakSelf.currentIndex withObject:model.mj_JSONObject];
                [weakSelf.tableView reloadData];
                [weakSelf.textView hideContainerBoard];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {
        NSDictionary *params = @{@"i":@(1),
                                 @"message":text,
                                 @"topic_id":self.awemeId,
                                 @"key":key,
        };
        [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/video_comment_member/comment_publish" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            NSDictionary *data = [dic objectForKey:@"data"];
            if(status == 200){
                NSDictionary *returnDict = data[@"return_data"];
                [weakSelf.data insertObject:returnDict atIndex:0];
                [weakSelf.tableView reloadData];
                [weakSelf.textView hideContainerBoard];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    }
}

#pragma mark  -  tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = [CommentModel yy_modelWithDictionary:self.data[indexPath.row]];
    if (model.recent_replay.count) {
        CGFloat height = model.height;
        for (NSDictionary *dict in model.recent_replay) {
            CommentModel *model = [CommentModel yy_modelWithDictionary:dict];
            height = height + model.height;
        }
        return height+(model.first_hasmore?30:0);
    }
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel *model = [CommentModel yy_modelWithDictionary:self.data[indexPath.row]];
    if (model.recent_replay.count) {
        BigCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentReplyCell];
        cell.delegate = self;
        cell.bigCommentModel = model;
        cell.indexRow = indexPath.row;
        return cell;
    } else {
        CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentListCell];
        [cell initData:model];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:CommentListCell.class] ){
        CommentModel *model = [CommentModel yy_modelWithDictionary:self.data[indexPath.row]];
        self.textView.placeholderLabel.text =[NSString stringWithFormat:@"回复：%@",model.from_nickname];
        self.commentID = model.comment_id;
        self.toUserID = model.from_uid;
        self.replayTTT = commentType;
        self.currentIndex = indexPath.row;
        [self.textView.textView becomeFirstResponder];
    }
}

#pragma mark  -  didClickBigCommentTableViewCell
- (void)didClickBigCommentTableViewCell:(CommentModel *)model andReplyType:(replayType)replyTTT{
    self.textView.placeholderLabel.text =[NSString stringWithFormat:@"回复：%@",model.from_nickname];
    CommentModel *mainModel = [CommentModel yy_modelWithDictionary:self.data[model.indexRow]];
    self.commentID = mainModel.comment_id;
    self.replayID = model.comment_id;
    self.toUserID = model.from_uid;
    self.replayTTT = replyTTT;
    self.currentIndex = model.indexRow;
    [self.textView.textView becomeFirstResponder];
}

- (void)didMoreDataBigCommentTableViewCell:(NSInteger)indexRow {
    XYWeakSelf;
    self.currentIndex = indexRow;
    CommentModel *model = [CommentModel yy_modelWithDictionary:self.data[indexRow]];
    NSDictionary *params = @{@"i":@(1),
                             @"page":@(self.replyPageIndex),
                             @"comment_id":model.comment_id,
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment/reply_list"WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        NSDictionary *data = [dic objectForKey:@"data"];
        if(status == 200){
            NSArray *arr = data[@"reply_list"];
            BOOL hasMore = [[data objectForKey:@"hasmore"] boolValue];
            model.first_hasmore  = hasMore ? 1:0;
            [model.recent_replay addObjectsFromArray:arr];
            [weakSelf.data replaceObjectAtIndex:indexRow withObject:model.mj_JSONObject];
            [weakSelf.tableView reloadData];
            self.replyPageIndex ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}
//delete comment
- (void)deleteComment:(id )comment {
    
}

//guesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListCell"]||[NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListMoreCell"]) {
        return NO;
    }else if([NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListReplyCell"]){
        return NO;
    }else {
        return YES;
    }
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_close];
    if([_close.layer containsPoint:point]) {
        [self dismiss];
    }
}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
    [self.textView show];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self.textView dismiss];
                     }];
}

//load data
- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    XYWeakSelf;
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    NSDictionary *params = @{@"i":@(1),
                             @"page":@(pageIndex),
                             @"topic_id":self.awemeId,
                             @"key":key,
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment/comment_list" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        NSDictionary *data = [dic objectForKey:@"data"];
        if(status == 200){
            
            NSMutableArray *array = [data[@"comment_list"] mutableCopy];
            [UIView setAnimationsEnabled:NO];
            [weakSelf.tableView beginUpdates];
            [weakSelf.data addObjectsFromArray:array];
            NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
            for(NSInteger row = weakSelf.data.count - array.count; row<weakSelf.data.count; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [indexPaths addObject:indexPath];
            }
            [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.tableView endUpdates];
            [UIView setAnimationsEnabled:YES];
            
            weakSelf.pageIndex ++;
            
            [_loadMore endLoading];
            if(![data[@"hasmore"] boolValue]) {
                [_loadMore loadingAll];
            }

            weakSelf.label.text = [NSString stringWithFormat:@"%ld条评论",[data[@"total"] integerValue]];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        [weakSelf.loadMore loadingFailed];
    }];
}

//UIScrollViewDelegate Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0) {
        self.frame = CGRectMake(0, -offsetY, self.frame.size.width, self.frame.size.height);
    }
    if (scrollView.isDragging && offsetY < -50) {
        [self dismiss];
    }
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"refreshCommentTableView" object:nil];
}
@end


#pragma comment tableview cell

#define MaxContentWidth     ScreenWidth - 55 - 35
//cell
@implementation CommentListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kClearColor;
        self.clipsToBounds = YES;
        _avatar = [[UIImageView alloc] init];
        _avatar.clipsToBounds = YES;
        [self addSubview:_avatar];

        MCFireworksButton *view = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
          view.particleImage = [UIImage imageNamed:@"like_icon_video"];
          view.particleScale = 0.05;
          view.particleScaleRange = 0.02;
         [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
         [view setUserInteractionEnabled:YES];
          [view addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeIcon = view;
        [self addSubview:_likeIcon];
        
        UILongPressGestureRecognizer *longTag = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteComment:)];
        longTag.minimumPressDuration = 1.5;
        [self addGestureRecognizer:longTag];
        
        _nickName = [[UILabel alloc] init];
        _nickName.numberOfLines = 1;
        _nickName.textColor = ColorWhiteAlpha60;
        _nickName.font = FONT_10;
        [self addSubview:_nickName];
        
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.textColor = kWhiteColor;
        _content.font = FONT_14;
        [self addSubview:_content];
        
        _date = [[UILabel alloc] init];
        _date.numberOfLines = 1;
        _date.textColor = color_textBg_C7C7D1;
        _date.font = FONT_10;
        [self addSubview:_date];
        
        _likeNum = [[UILabel alloc] init];
        _likeNum.numberOfLines = 1;
        _likeNum.textColor = color_textBg_C7C7D1;
        _likeNum.font = FONT_10;
        [self addSubview:_likeNum];
        
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = ColorWhiteAlpha10;
        [self addSubview:_splitLine];
        
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).inset(15);
            make.width.height.mas_equalTo(34);
        }];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.avatar.mas_right).offset(10);
            make.right.equalTo(self.likeIcon.mas_left).inset(25);
        }];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickName.mas_bottom).offset(5);
            make.left.equalTo(self.nickName);
        }];
        _content.preferredMaxLayoutWidth = (MaxContentWidth);
        [_content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.mas_bottom).offset(5);
            make.left.right.equalTo(self.nickName);
        }];
        [_likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self).inset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.likeIcon);
            make.top.equalTo(self.likeIcon.mas_bottom).offset(2);
        }];
        [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.date);
            make.right.equalTo(self.likeIcon);
            make.top.equalTo(self.date.mas_bottom).offset(9.5);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)likeBtnClick:(MCFireworksButton *)sender {
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    sender.selected= !sender.selected;
    if (sender.selected) {
        NSDictionary *params = @{@"i":@(1),
                                 @"zan_type":@(1),
                                 @"comment_id":self.model.comment_id,
                                 @"key":key,
        };
        [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/comment_zan" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                [sender popOutsideWithDuration:0.5];
                [sender setImage:[UIImage imageNamed:@"smallVideo_home_like_after"] forState:UIControlStateNormal];
                [_likeNum setTextColor:KKColor(243, 55, 102, 1)];
                [_likeNum setText:[NSString stringWithFormat:@"%ld",[_likeNum.text integerValue]+1]];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            sender.selected = !sender.selected;
        }];
    }
    else {
        NSDictionary *params = @{@"i":@(1),
                                 @"zan_type":@(0),
                                 @"comment_id":self.model.comment_id,
                                 @"key":key,
        };
        [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/comment_zan" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                [sender popInsideWithDuration:0.4];
                [sender setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
                [_likeNum setTextColor:color_textBg_C7C7D1];
                [_likeNum setText:[NSString stringWithFormat:@"%ld",[_likeNum.text integerValue]?[_likeNum.text integerValue] -1:0]];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            sender.selected = !sender.selected;
        }];
    }
}
-(void)initData:(CommentModel *)comment {
    _model = comment;
    @STweakify(self);
    [_avatar setImageWithUrl:comment.from_headimg placeholder:IMAGE_NAME(STimagDefault) circleImage:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @STstrongify(self);
        self.avatar.image = image;
    }];
    _nickName.text = comment.from_nickname;
    _content.attributedText = [self cellAttributedString:comment.content];
    _date.text = comment.add_time;
    _likeNum.text = STRING_FROM_INTAGER(comment.zan_volume);
    if (comment.zan_flag == 1) {
        [self.likeIcon setImage:[UIImage imageNamed:@"smallVideo_home_like_after"] forState:UIControlStateNormal];
        [_likeNum setTextColor:KKColor(243, 55, 102, 1)];
        [self.likeIcon setSelected:YES];
    } else {
        [self.likeIcon setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
        [_likeNum setTextColor:color_textBg_C7C7D1];
        [self.likeIcon setSelected:NO];
    }
}

+(CGFloat)cellHeight:(CommentModel *)comment {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:comment.content];
    [attributedString addAttribute:NSFontAttributeName value:FONT_14 range:NSMakeRange(0, attributedString.length)];
    CGSize size = [attributedString multiLineSize:MaxContentWidth];
    return size.height + 30 + FONT_12.lineHeight * 2;
}

- (void)deleteComment:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@""
                                                          delegate:nil
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"删除", nil];
        [actionSheet show];
        XYWeakSelf;
        actionSheet.clickedHandler = ^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 1) {//删除
                [weakSelf deletCommentRequst];
            } else {//0取消
                
            }
        };
    }
}

- (void)deletCommentRequst {
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    NSDictionary *params = @{@"i":@(1),
                             @"topic_id":self.model.topic_id,
                             @"comment_id":self.model.comment_id,
                             @"key":key,
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/comment_del" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            [kNotificationCenter postNotificationName:@"refreshCommentTableView" object:nil];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}
@end

@implementation CommentListReplyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kClearColor;
        self.clipsToBounds = YES;
        _avatar = [[UIImageView alloc] init];
        _avatar.clipsToBounds = YES;
        [self addSubview:_avatar];
        
        UILongPressGestureRecognizer *longTag = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteComment:)];
        longTag.minimumPressDuration = 1.5;
        [self addGestureRecognizer:longTag];
        
        MCFireworksButton *view = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
          view.particleImage = [UIImage imageNamed:@"like_icon_video"];
          view.particleScale = 0.05;
          view.particleScaleRange = 0.02;
         [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
         [view setUserInteractionEnabled:YES];
          [view addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeIcon = view;
        [self addSubview:_likeIcon];
        
        _nickName = [[UILabel alloc] init];
        _nickName.numberOfLines = 1;
        _nickName.textColor = ColorWhiteAlpha60;
        _nickName.font = FONT_10;
        [self addSubview:_nickName];
        
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.textColor = kWhiteColor;
        _content.font = FONT_14;
        [self addSubview:_content];
        
        _date = [[UILabel alloc] init];
        _date.numberOfLines = 1;
        _date.textColor = color_textBg_C7C7D1;
        _date.font = FONT_10;
        [self addSubview:_date];
        
        _likeNum = [[UILabel alloc] init];
        _likeNum.numberOfLines = 1;
        _likeNum.textColor = color_textBg_C7C7D1;
        _likeNum.font = FONT_10;
        [self addSubview:_likeNum];
        
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = ColorWhiteAlpha10;
        [self addSubview:_splitLine];
        
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).inset(15);
            make.left.equalTo(self).inset(15+34+10);
            make.width.height.mas_equalTo(28);
        }];
        [_likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self).inset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.avatar.mas_right).offset(10);
            make.right.equalTo(self.likeIcon.mas_left).inset(25);
        }];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickName.mas_bottom).offset(5);
            make.left.equalTo(self.nickName);
        }];
        _content.preferredMaxLayoutWidth = (MaxContentWidth-44);
        [_content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.mas_bottom).offset(5);
            make.left.right.equalTo(self.nickName);
        }];
        [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.likeIcon);
            make.top.equalTo(self.likeIcon.mas_bottom).offset(2);
        }];
        [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.date);
            make.right.equalTo(self.likeIcon);
            make.top.equalTo(self.date.mas_bottom).offset(9.5);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)deleteComment:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@""
                                                          delegate:nil
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"删除", nil];
        [actionSheet show];
        XYWeakSelf;
        actionSheet.clickedHandler = ^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 1) {//删除
                [weakSelf deletCommentRequst];
            } else {//0取消
                
            }
        };
    }
}

- (void)deletCommentRequst {
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    NSDictionary *params = @{@"i":@(1),
                             @"topic_id":self.model.topic_id,
                             @"comment_id":self.model.comment_id,
                             @"key":key,
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/comment_del" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            [kNotificationCenter postNotificationName:@"refreshCommentTableView" object:nil];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}

-(void)initData:(CommentModel *)comment {
    _model = comment;
    @STweakify(self);
    [_avatar setImageWithUrl:comment.from_headimg placeholder:IMAGE_NAME(STimagDefault) circleImage:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @STstrongify(self);
        self.avatar.image = image;
    }];
    _nickName.text = comment.from_nickname;
    _content.attributedText = [self cellAttributedString:comment.content];
    _date.text = comment.add_time;
    _likeNum.text = STRING_FROM_INTAGER(comment.zan_volume);
    if (comment.zan_flag == 1) {
        [self.likeIcon setImage:[UIImage imageNamed:@"smallVideo_home_like_after"] forState:UIControlStateNormal];
        [_likeNum setTextColor:KKColor(243, 55, 102, 1)];
        [self.likeIcon setSelected:YES];
    } else {
        [self.likeIcon setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
        [_likeNum setTextColor:color_textBg_C7C7D1];
        [self.likeIcon setSelected:NO];
    }
}

- (void)likeBtnClick:(MCFireworksButton *)sender {
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    sender.selected= !sender.selected;
    if (sender.selected) {
        NSDictionary *params = @{@"i":@(1),
                                 @"zan_type":@(1),
                                 @"zan_id":self.model.comment_id,
                                 @"key":key,
        };
        [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/reply_zan" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                [sender popOutsideWithDuration:0.5];
                [sender setImage:[UIImage imageNamed:@"smallVideo_home_like_after"] forState:UIControlStateNormal];
                [_likeNum setTextColor:KKColor(243, 55, 102, 1)];
                [_likeNum setText:[NSString stringWithFormat:@"%ld",[_likeNum.text integerValue]+1]];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            sender.selected = !sender.selected;
        }];
    }
    else {
        NSDictionary *params = @{@"i":@(1),
                                 @"zan_type":@(0),
                                 @"zan_id":self.model.comment_id,
                                 @"key":key,
        };
        [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video_comment_member/reply_zan" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                [sender popInsideWithDuration:0.4];
                [sender setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
                [_likeNum setTextColor:color_textBg_C7C7D1];
                [_likeNum setText:[NSString stringWithFormat:@"%ld",[_likeNum.text integerValue]?[_likeNum.text integerValue]-1 :0]];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            sender.selected = !sender.selected;
        }];
    }
}

@end

@implementation CommentListMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = kClearColor;
    _content = [[UILabel alloc] init];
    _content.numberOfLines = 0;
    _content.textColor = ColorWhiteAlpha80;
    _content.font = FONT_14;
    _content.text = @"展开查看更多回复";
    [self addSubview:_content];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(15+34+10);
        make.top.right.bottom.equalTo(self);
    }];
}

@end
