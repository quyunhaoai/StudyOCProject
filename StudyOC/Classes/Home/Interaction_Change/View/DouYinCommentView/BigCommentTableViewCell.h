//
//  BigCommentTableViewCell.h
//  Comment布局
//
//  Created by Geb on 16/2/20.
//  Copyright © 2016年 OE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentsPopView.h"
@protocol BigCommentTableViewRefreshDelegate <NSObject>

-(void)didClickBigCommentTableViewCell:(CommentModel *)model andReplyType:(replayType)replyTTT;

-(void)didMoreDataBigCommentTableViewCell:(NSInteger )indexRow;
@end

@interface BigCommentTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) CommentModel *bigCommentModel;
@property (nonatomic,strong) UITableView *smallCommentTableView;
@property (nonatomic) id<BigCommentTableViewRefreshDelegate> delegate;
@property (assign, nonatomic) NSInteger indexRow;    
@end
