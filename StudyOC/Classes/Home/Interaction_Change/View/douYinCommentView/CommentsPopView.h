//
//  CommentsPopView.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

typedef enum : NSUInteger {
    commentType = 1,
    replyCommentType = 2,
} replayType;
#import <UIKit/UIKit.h>
#import <MCFireworksButton.h>
#import "STBaseTableViewCell.h"
@interface CommentsPopView:UIView

@property (nonatomic, strong) UILabel           *label;
@property (nonatomic, strong) UIImageView       *close;

- (instancetype)initWithAwemeId:(NSString *)awemeId;
- (void)show;
- (void)dismiss;

@end


@class CommentModel;
@interface CommentListCell : STBaseTableViewCell

@property (nonatomic, strong) UIImageView        *avatar;
@property (nonatomic, strong) MCFireworksButton  *likeIcon;
@property (nonatomic, strong) UILabel            *nickName;
@property (nonatomic, strong) UILabel            *extraTag;
@property (nonatomic, strong) UILabel            *content;
@property (nonatomic, strong) UILabel            *likeNum;
@property (nonatomic, strong) UILabel            *date;
@property (nonatomic, strong) UIView             *splitLine;
@property (strong, nonatomic) CommentModel       *model;
-(void)initData:(CommentModel *)comment;
+(CGFloat)cellHeight:(CommentModel *)comment;

@end
@class CommentModel;
@interface CommentListReplyCell : STBaseTableViewCell

@property (nonatomic, strong) UIImageView        *avatar;
@property (nonatomic, strong) MCFireworksButton  *likeIcon;
@property (nonatomic, strong) UILabel            *nickName;
@property (nonatomic, strong) UILabel            *extraTag;
@property (nonatomic, strong) UILabel            *content;
@property (nonatomic, strong) UILabel            *likeNum;
@property (nonatomic, strong) UILabel            *date;
@property (nonatomic, strong) UIView             *splitLine;
@property (strong, nonatomic) CommentModel       *model;
-(void)initData:(CommentModel *)comment;

@end

@interface CommentListMoreCell : UITableViewCell

@property (nonatomic, strong) UILabel            *content;
@property (nonatomic, strong) UIView             *splitLine;

@end
