//
//  CommentsPopView.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "CommentsPopView.h"
#import "LKMoreReplyContentTableViewCell.h"
#import "LoadMoreControl.h"
#import "EmotionSelector.h"
#import "ChatTextView.h"
NSString * const kCommentListCell     = @"CommentListCell";
NSString * const kCommentHeaderCell   = @"CommentHeaderCell";
NSString * const kCommentFooterCell   = @"CommentFooterCell";
static NSString * const commentReplyCell = @"commentReplyCell";
static NSString * const commentMoreCell = @"LKMoreReplyContentTableViewCell";
@interface CommentsPopView () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate,UIScrollViewDelegate, ChatTextViewDelegate>

@property (nonatomic, assign) NSString                         *awemeId;

@property (nonatomic, assign) NSInteger                        pageIndex;
@property (nonatomic, assign) NSInteger                        pageSize;

@property (nonatomic, strong) UIView                           *container;
@property (nonatomic, strong) UITableView                      *tableView;
@property (nonatomic, strong) NSMutableArray                   *data;
@property (nonatomic, strong) ChatTextView                     *textView;
@property (nonatomic, strong) LoadMoreControl                  *loadMore;

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
        
        _pageIndex = 0;
        _pageSize = 20;
        
        _data = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
        
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
        _close.image = [UIImage imageNamed:@"close"];
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight*3/4 - 35 - 50 - HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kClearColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:CommentListCell.class forCellReuseIdentifier:kCommentListCell];
        [_tableView registerClass:CommentListReplyCell.class forCellReuseIdentifier:commentReplyCell];
        [_tableView registerNib:[LKMoreReplyContentTableViewCell loadNib] forCellReuseIdentifier:commentMoreCell];
//        _loadMore = [[LoadMoreControl alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50) surplusCount:10];
//        [_loadMore setLoadingType:LoadStateIdle];
//        __weak __typeof(self) wself = self;
//        [_loadMore setOnLoad:^{
//            [wself loadData:wself.pageIndex pageSize:wself.pageSize];
//        }];
//        [_tableView addSubview:_loadMore];
        
        [_container addSubview:_tableView];
        
        _textView = [ChatTextView new];
        _textView.delegate = self;
        
    }
    return self;
}
#pragma mark  -  ChattextDel
- (void)onSendImages:(NSMutableArray<UIImage *> *)images {
    
}
- (void)onEditBoardHeightChange:(CGFloat)height {

}
// comment textView delegate
-(void)onSendText:(NSString *)text {

}

#pragma mark  -  tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCellDefultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2==0) {
        CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentListCell];
        return cell;
    } else {
        CommentListReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:commentReplyCell];
//        LKMoreReplyContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentMoreCell];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//delete comment
- (void)deleteComment:(id )comment {
    
}

//guesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListCell"]) {
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
        _avatar.image = [UIImage imageNamed:@"img_find_default"];
        _avatar.clipsToBounds = YES;
        _avatar.layer.cornerRadius = 17;
        [self addSubview:_avatar];
        
        _likeIcon = [[UIImageView alloc] init];
        _likeIcon.contentMode = UIViewContentModeCenter;
        _likeIcon.image = [UIImage imageNamed:@"like_icon_video"];
        [self addSubview:_likeIcon];
        
        _nickName = [[UILabel alloc] init];
        _nickName.numberOfLines = 1;
        _nickName.textColor = ColorWhiteAlpha60;
        _nickName.font = FONT_10;
        [self addSubview:_nickName];
        
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.textColor = ColorWhiteAlpha80;
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
            make.width.mas_lessThanOrEqualTo(MaxContentWidth);
        }];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.mas_bottom).offset(5);
            make.left.right.equalTo(self.nickName);
        }];
        [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.likeIcon);
            make.top.equalTo(self.likeIcon.mas_bottom).offset(5);
        }];
        [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.date);
            make.right.equalTo(self.likeIcon);
            make.top.equalTo(self.date.mas_bottom).offset(9.5);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    [self initDatatest];
    return self;
}

-(void)initDatatest{
    _nickName.text = @"美美";
    self.avatar.image = IMAGE_NAME(STSystemDefaultImageName);
    _content.text = @"自媒体自媒体自媒体";
    _date.text =@"12-13-11";
    _likeNum.text = @"123";
}

-(void)initData:(id )comment {
//    NSURL *avatarUrl;
//    if([@"user" isEqualToString:comment.user_type]) {
//        avatarUrl = [NSURL URLWithString:comment.user.avatar_thumb.url_list.firstObject];
//        _nickName.text = comment.user.nickname;
//    }else {
//        avatarUrl = [NSURL URLWithString:comment.visitor.avatar_thumbnail.url];
//        _nickName.text = [comment.visitor formatUDID];
//    }
//
//    __weak __typeof(self) wself = self;
//    [_avatar setImageWithURL:avatarUrl completedBlock:^(UIImage *image, NSError *error) {
//        image = [image drawCircleImage];
//        wself.avatar.image = image;
//    }];
//    _content.text = comment.text;
//    _date.text = [NSDate formatTime:comment.create_time];
//    _likeNum.text = [NSString formatCount:comment.digg_count];
    
}

+(CGFloat)cellHeight:(id )comment {
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:comment.text];
//    [attributedString addAttribute:NSFontAttributeName value:MediumFont range:NSMakeRange(0, attributedString.length)];
//    CGSize size = [attributedString multiLineSize:MaxContentWidth];
//    return size.height + 30 + SmallFont.lineHeight * 2;
    return KCellDefultHeight;
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
        _avatar.image = [UIImage imageNamed:@"img_find_default"];
        _avatar.clipsToBounds = YES;
        _avatar.layer.cornerRadius = 14;
        [self addSubview:_avatar];
        
        _likeIcon = [[UIImageView alloc] init];
        _likeIcon.contentMode = UIViewContentModeCenter;
        _likeIcon.image = [UIImage imageNamed:@"like_icon_video"];
        [self addSubview:_likeIcon];
        
        _nickName = [[UILabel alloc] init];
        _nickName.numberOfLines = 1;
        _nickName.textColor = ColorWhiteAlpha60;
        _nickName.font = FONT_10;
        [self addSubview:_nickName];
        
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.textColor = ColorWhiteAlpha80;
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
            make.width.mas_lessThanOrEqualTo(MaxContentWidth);
        }];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.mas_bottom).offset(5);
            make.left.right.equalTo(self.nickName);
        }];
        [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.likeIcon);
            make.top.equalTo(self.likeIcon.mas_bottom).offset(5);
        }];
        [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.date);
            make.right.equalTo(self.likeIcon);
            make.top.equalTo(self.date.mas_bottom).offset(9.5);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    [self initDatatest];
    return self;
}

-(void)initDatatest{
    _nickName.text = @"美美";
    self.avatar.image = IMAGE_NAME(STSystemDefaultImageName);
    _content.text = @"自媒体自媒体自媒体";
    _date.text =@"12-13-11";
    _likeNum.text = @"123";
}

-(void)initData:(id )comment {
}

+(CGFloat)cellHeight:(id )comment {
    return KCellDefultHeight;
}
@end






#pragma TextView

static const CGFloat kCommentTextViewLeftInset               = 15;
static const CGFloat kCommentTextViewRightInset              = 60;
static const CGFloat kCommentTextViewTopBottomInset          = 15;

@interface CommentTextView ()<UITextViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat            textHeight;
@property (nonatomic, assign) CGFloat            keyboardHeight;
@property (nonatomic, retain) UILabel            *placeholderLabel;
@property (nonatomic, strong) UIImageView        *atImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation CommentTextView
- (instancetype)init {
    self = [super init];
    if(self) {
        self.frame = SCREEN_BOUNDS;
        self.backgroundColor = kClearColor;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50 - HOME_INDICATOR_HEIGHT, ScreenWidth, 50 + HOME_INDICATOR_HEIGHT)];
        _container.backgroundColor = ColorBlackAlpha40;
        [self addSubview:_container];
        
        _keyboardHeight = HOME_INDICATOR_HEIGHT;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _textView.backgroundColor = kClearColor;
        
        _textView.clipsToBounds = NO;
        _textView.textColor = kWhiteColor;
        _textView.font = FONT_14;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.scrollEnabled = NO;
        _textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        _textView.textContainerInset = UIEdgeInsetsMake(kCommentTextViewTopBottomInset, kCommentTextViewLeftInset, kCommentTextViewTopBottomInset, kCommentTextViewRightInset);
        _textView.textContainer.lineFragmentPadding = 0;
        _textHeight = ceilf(_textView.font.lineHeight);
        
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.text = @"有爱评论，说点儿好听的~";
        _placeholderLabel.textColor = color_textBg_C7C7D1;
        _placeholderLabel.font = FONT_14;
        _placeholderLabel.frame = CGRectMake(kCommentTextViewLeftInset, 0, ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset, 50);
        [_textView addSubview:_placeholderLabel];
        
        _atImageView = [[UIImageView alloc] init];
        _atImageView.contentMode = UIViewContentModeCenter;
        _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
        _atImageView.userInteractionEnabled = YES;
        [_atImageView addTapGestureWithTarget:self action:@selector(atAction)];
        [_textView addSubview:_atImageView];
        [_container addSubview:_textView];
        
        _textView.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)atAction {//at好友
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _atImageView.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    _container.layer.mask = shape;
    
    [self updateTextViewFrame];
}


- (void)updateTextViewFrame {
    CGFloat textViewHeight = _keyboardHeight > HOME_INDICATOR_HEIGHT ? _textHeight + 2*kCommentTextViewTopBottomInset : ceilf(_textView.font.lineHeight) + 2*kCommentTextViewTopBottomInset;
    _textView.frame = CGRectMake(0, 0, ScreenWidth, textViewHeight);
    _container.frame = CGRectMake(0, ScreenHeight - _keyboardHeight - textViewHeight, ScreenWidth, textViewHeight + _keyboardHeight);
}

//keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    _keyboardHeight = [notification keyBoardHeight];
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconBlackaBefore"];
    _container.backgroundColor = kWhiteColor;
    _textView.textColor = kBlackColor;
    self.backgroundColor = ColorBlackAlpha60;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _keyboardHeight = HOME_INDICATOR_HEIGHT;
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
    _container.backgroundColor = ColorBlackAlpha40;
    _textView.textColor = kWhiteColor;
    self.backgroundColor = kClearColor;
}

//textView delegate
-(void)textViewDidChange:(UITextView *)textView {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    if(!textView.hasText) {
        [_placeholderLabel setHidden:NO];
        _textHeight = ceilf(_textView.font.lineHeight);
    }else {
        [_placeholderLabel setHidden:YES];
        _textHeight = [attributedText multiLineSize:ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset].height;
    }
    [self updateTextViewFrame];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        if(_delegate) {
            [_delegate onSendText:textView.text];
            [_placeholderLabel setHidden:NO];
            textView.text = @"";
            _textHeight = ceilf(textView.font.lineHeight);
            [textView resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

//handle guesture tap
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_textView];
    if(![_textView.layer containsPoint:point]) {
        [_textView resignFirstResponder];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        if(hitView.backgroundColor == kClearColor) {
            return nil;
        }
    }
    return hitView;
}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
