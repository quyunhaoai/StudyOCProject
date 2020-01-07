//
//  CommentModel.h
//  RingtoneDuoduo
//
//  Created by 唐天成 on 2017/7/6.
//  Copyright © 2017年 www.ShoujiDuoduo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "add_time" = "2019-12-30 13:47:13";
 "comment_id" = 3;
 content = 0001;
 "from_headimg" = "http://mp.youqucheng.com/addons/project/data/uploadfiles/headimg/5.jpg";
 "from_nickname" = 666;
 "from_uid" = 5;
 "recent_replay" =             (
 );
 "topic_id" = 3;
 "topic_title" = "\U6d4b\U8bd5\U89c6\U9891\U7684\U6b21\U90ce\U5148\U751f";
 "topic_type" = 1;
*/

@interface CommentModel : NSObject
//视频ID
@property (copy, nonatomic) NSString *topic_id;
//当前的评论ID
@property(nonatomic, copy) NSString *comment_id;
//当前评论内容
@property(nonatomic, copy) NSString *content;
//当前评论日期
@property(nonatomic, copy) NSString *add_time;
//当前评论人名字
@property(nonatomic, copy) NSString *from_nickname;
//当前评论人头像地址
@property(nonatomic, copy) NSString *from_headimg;
//评论人ID
@property (copy, nonatomic) NSString *from_uid;
//被回复人ID
@property (copy, nonatomic) NSString *to_uid;

@property(nonatomic, assign) CGFloat height;

@property (strong, nonatomic) NSMutableArray *recent_replay;

@property (assign, nonatomic) NSInteger zan_volume;

@property (assign, nonatomic) NSInteger indexRow;

@property (assign, nonatomic) NSInteger first_hasmore;    // 1表示有更多，0没有 first_hasmore

@property (assign, nonatomic) NSInteger zan_flag;
@end
