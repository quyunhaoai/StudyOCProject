//
//  STVideoChannelModl.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/1.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Video_teamItem :NSObject
@property (nonatomic , copy) NSString              * headimg;
@property (nonatomic , copy) NSString              * uid;

@end


@interface Video_listItem :NSObject
@property (nonatomic , copy) NSString              * headimg;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              is_v;
@property (nonatomic , copy) NSString              * video_title;
@property (nonatomic , copy) NSString              * video_thumb;
@property (nonatomic , copy) NSString              * video_url;
@property (nonatomic , copy) NSString              * video_desc;
@property (nonatomic , assign) NSInteger              play_volume;
@property (nonatomic , assign) NSInteger              zan_volume;
@property (nonatomic , assign) NSInteger              share_volume;
@property (nonatomic , assign) NSInteger              comment_volume;
@property (nonatomic , copy) NSString              * video_duration;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , strong) NSArray <NSString *>              * video_type;
@property (nonatomic , strong) NSArray <Video_teamItem *>              * video_team;

@end


@interface Data :NSObject
@property (nonatomic , strong) NSArray <Video_listItem *>              * video_list;
@property (nonatomic , assign) NSInteger              totalpage;
@property (nonatomic , assign) BOOL              hasmore;

@end


@interface ExampleModelName :NSObject
@property (nonatomic , assign) NSInteger              state;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) Data              * data;

@end

@interface STVideoChannelModl : STBaseModel
@property (nonatomic , copy) NSString              * headimg;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              is_v;
@property (nonatomic , copy) NSString              * video_title;
@property (nonatomic , copy) NSString              * video_thumb;
@property (nonatomic , copy) NSString              * video_url;
@property (nonatomic , copy) NSString              * video_desc;
@property (nonatomic , assign) NSInteger              play_volume;
@property (nonatomic , assign) NSInteger              zan_volume;
@property (nonatomic , assign) NSInteger              share_volume;
@property (nonatomic , assign) NSInteger              comment_volume;
@property (nonatomic , copy) NSString              * video_duration;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic, copy) NSString *               zuozhe_desc;
@property (assign, nonatomic) NSInteger              sex;
@property (nonatomic , strong) NSArray <NSString *>  * video_type;
@property (nonatomic , strong) NSArray               * video_team;
@property (nonatomic, strong) NSArray *video_sponsor;
@property (assign, nonatomic) int uid;    //
@end

NS_ASSUME_NONNULL_END
