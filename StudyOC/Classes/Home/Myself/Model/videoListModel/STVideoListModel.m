//
//  STVideoListModel.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/1.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoListModel.h"
#import "VideoTeam.h"
//NSString *const kVideoListAddTime = @"add_time";
//NSString *const kVideoListCommentVolume = @"comment_volume";
//NSString *const kVideoListHeadimg = @"headimg";
//NSString *const kVideoListIsV = @"is_v";
//NSString *const kVideoListNickname = @"nickname";
//NSString *const kVideoListPlayVolume = @"play_volume";
//NSString *const kVideoListSex = @"sex";
//NSString *const kVideoListShareVolume = @"share_volume";
//NSString *const kVideoListVideoDesc = @"video_desc";
//NSString *const kVideoListVideoDuration = @"video_duration";
//NSString *const kVideoListVideoTeam = @"video_team";
//NSString *const kVideoListVideoThumb = @"video_thumb";
//NSString *const kVideoListVideoTitle = @"video_title";
//NSString *const kVideoListVideoType = @"video_type";
//NSString *const kVideoListVideoUrl = @"video_url";
//NSString *const kVideoListZanVolume = @"zan_volume";
//NSString *const kVideoListZuozheDesc = @"zuozhe_desc";

@interface STVideoListModel ()
@end
@implementation STVideoListModel



//
///**
// * Instantiate the instance using the passed dictionary values to set the properties values
// */
//
//-(instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//    self = [super init];
//    if(![dictionary[kVideoListAddTime] isKindOfClass:[NSNull class]]){
//        self.addTime = dictionary[kVideoListAddTime];
//    }
//    if(![dictionary[kVideoListCommentVolume] isKindOfClass:[NSNull class]]){
//        self.commentVolume = [dictionary[kVideoListCommentVolume] integerValue];
//    }
//
//    if(![dictionary[kVideoListHeadimg] isKindOfClass:[NSNull class]]){
//        self.headimg = dictionary[kVideoListHeadimg];
//    }
//    if(![dictionary[kVideoListIsV] isKindOfClass:[NSNull class]]){
//        self.isV = [dictionary[kVideoListIsV] integerValue];
//    }
//
//    if(![dictionary[kVideoListNickname] isKindOfClass:[NSNull class]]){
//        self.nickname = dictionary[kVideoListNickname];
//    }
//    if(![dictionary[kVideoListPlayVolume] isKindOfClass:[NSNull class]]){
//        self.playVolume = [dictionary[kVideoListPlayVolume] integerValue];
//    }
//
//    if(![dictionary[kVideoListSex] isKindOfClass:[NSNull class]]){
//        self.sex = [dictionary[kVideoListSex] integerValue];
//    }
//    if(![dictionary[kVideoListShareVolume] isKindOfClass:[NSNull class]]){
//        self.shareVolume = [dictionary[kVideoListShareVolume] integerValue];
//    }
//
//    if(![dictionary[kVideoListVideoDesc] isKindOfClass:[NSNull class]]){
//        self.videoDesc = dictionary[kVideoListVideoDesc];
//    }
//    if(![dictionary[kVideoListVideoDuration] isKindOfClass:[NSNull class]]){
//        self.videoDuration = dictionary[kVideoListVideoDuration];
//    }
//    if(dictionary[kVideoListVideoTeam] != nil && [dictionary[kVideoListVideoTeam] isKindOfClass:[NSArray class]]){
//        NSArray * videoTeamDictionaries = dictionary[kVideoListVideoTeam];
//        NSMutableArray * videoTeamItems = [NSMutableArray array];
//        for(NSDictionary * videoTeamDictionary in videoTeamDictionaries){
//            VideoTeam * videoTeamItem = [[VideoTeam alloc] initWithDictionary:videoTeamDictionary];
//            [videoTeamItems addObject:videoTeamItem];
//        }
//        self.videoTeam = videoTeamItems;
//    }
//    if(![dictionary[kVideoListVideoThumb] isKindOfClass:[NSNull class]]){
//        self.videoThumb = dictionary[kVideoListVideoThumb];
//    }
//    if(![dictionary[kVideoListVideoTitle] isKindOfClass:[NSNull class]]){
//        self.videoTitle = dictionary[kVideoListVideoTitle];
//    }
//    if(![dictionary[kVideoListVideoType] isKindOfClass:[NSNull class]]){
//        self.videoType = dictionary[kVideoListVideoType];
//    }
//    if(![dictionary[kVideoListVideoUrl] isKindOfClass:[NSNull class]]){
//        self.videoUrl = dictionary[kVideoListVideoUrl];
//    }
//    if(![dictionary[kVideoListZanVolume] isKindOfClass:[NSNull class]]){
//        self.zanVolume = [dictionary[kVideoListZanVolume] integerValue];
//    }
//
//    if(![dictionary[kVideoListZuozheDesc] isKindOfClass:[NSNull class]]){
//        self.zuozheDesc = dictionary[kVideoListZuozheDesc];
//    }
//    return self;
//}
//
//
///**
// * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
// */
//-(NSDictionary *)toDictionary
//{
//    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
//    if(self.addTime != nil){
//        dictionary[kVideoListAddTime] = self.addTime;
//    }
//    dictionary[kVideoListCommentVolume] = @(self.commentVolume);
//    if(self.headimg != nil){
//        dictionary[kVideoListHeadimg] = self.headimg;
//    }
//    dictionary[kVideoListIsV] = @(self.isV);
//    if(self.nickname != nil){
//        dictionary[kVideoListNickname] = self.nickname;
//    }
//    dictionary[kVideoListPlayVolume] = @(self.playVolume);
//    if(self.sex != nil){
//        dictionary[kVideoListSex] = self.sex;
//    }
//    dictionary[kVideoListShareVolume] = @(self.shareVolume);
//    if(self.videoDesc != nil){
//        dictionary[kVideoListVideoDesc] = self.videoDesc;
//    }
//    if(self.videoDuration != nil){
//        dictionary[kVideoListVideoDuration] = self.videoDuration;
//    }
//    if(self.videoTeam != nil){
//        NSMutableArray * dictionaryElements = [NSMutableArray array];
//        for(VideoTeam * videoTeamElement in self.videoTeam){
//            [dictionaryElements addObject:[videoTeamElement toDictionary]];
//        }
//        dictionary[kVideoListVideoTeam] = dictionaryElements;
//    }
//    if(self.videoThumb != nil){
//        dictionary[kVideoListVideoThumb] = self.videoThumb;
//    }
//    if(self.videoTitle != nil){
//        dictionary[kVideoListVideoTitle] = self.videoTitle;
//    }
//    if(self.videoType != nil){
//        dictionary[kVideoListVideoType] = self.videoType;
//    }
//    if(self.videoUrl != nil){
//        dictionary[kVideoListVideoUrl] = self.videoUrl;
//    }
//    dictionary[kVideoListZanVolume] = @(self.zanVolume);
//    if(self.zuozheDesc != nil){
//        dictionary[kVideoListZuozheDesc] = self.zuozheDesc;
//    }
//    return dictionary;
//
//}
//
///**
// * Implementation of NSCoding encoding method
// */
///**
// * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
// */
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    if(self.addTime != nil){
//        [aCoder encodeObject:self.addTime forKey:kVideoListAddTime];
//    }
//    [aCoder encodeObject:@(self.commentVolume) forKey:kVideoListCommentVolume];    if(self.headimg != nil){
//        [aCoder encodeObject:self.headimg forKey:kVideoListHeadimg];
//    }
//    [aCoder encodeObject:@(self.isV) forKey:kVideoListIsV];    if(self.nickname != nil){
//        [aCoder encodeObject:self.nickname forKey:kVideoListNickname];
//    }
//    [aCoder encodeObject:@(self.playVolume) forKey:kVideoListPlayVolume];    if(self.sex != nil){
//        [aCoder encodeObject:self.sex forKey:kVideoListSex];
//    }
//    [aCoder encodeObject:@(self.shareVolume) forKey:kVideoListShareVolume];    if(self.videoDesc != nil){
//        [aCoder encodeObject:self.videoDesc forKey:kVideoListVideoDesc];
//    }
//    if(self.videoDuration != nil){
//        [aCoder encodeObject:self.videoDuration forKey:kVideoListVideoDuration];
//    }
//    if(self.videoTeam != nil){
//        [aCoder encodeObject:self.videoTeam forKey:kVideoListVideoTeam];
//    }
//    if(self.videoThumb != nil){
//        [aCoder encodeObject:self.videoThumb forKey:kVideoListVideoThumb];
//    }
//    if(self.videoTitle != nil){
//        [aCoder encodeObject:self.videoTitle forKey:kVideoListVideoTitle];
//    }
//    if(self.videoType != nil){
//        [aCoder encodeObject:self.videoType forKey:kVideoListVideoType];
//    }
//    if(self.videoUrl != nil){
//        [aCoder encodeObject:self.videoUrl forKey:kVideoListVideoUrl];
//    }
//    [aCoder encodeObject:@(self.zanVolume) forKey:kVideoListZanVolume];    if(self.zuozheDesc != nil){
//        [aCoder encodeObject:self.zuozheDesc forKey:kVideoListZuozheDesc];
//    }
//
//}
//
///**
// * Implementation of NSCoding initWithCoder: method
// */
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    self.addTime = [aDecoder decodeObjectForKey:kVideoListAddTime];
//    self.commentVolume = [[aDecoder decodeObjectForKey:kVideoListCommentVolume] integerValue];
//    self.headimg = [aDecoder decodeObjectForKey:kVideoListHeadimg];
//    self.isV = [[aDecoder decodeObjectForKey:kVideoListIsV] integerValue];
//    self.nickname = [aDecoder decodeObjectForKey:kVideoListNickname];
//    self.playVolume = [[aDecoder decodeObjectForKey:kVideoListPlayVolume] integerValue];
//    self.sex = [aDecoder decodeObjectForKey:kVideoListSex];
//    self.shareVolume = [[aDecoder decodeObjectForKey:kVideoListShareVolume] integerValue];
//    self.videoDesc = [aDecoder decodeObjectForKey:kVideoListVideoDesc];
//    self.videoDuration = [aDecoder decodeObjectForKey:kVideoListVideoDuration];
//    self.videoTeam = [aDecoder decodeObjectForKey:kVideoListVideoTeam];
//    self.videoThumb = [aDecoder decodeObjectForKey:kVideoListVideoThumb];
//    self.videoTitle = [aDecoder decodeObjectForKey:kVideoListVideoTitle];
//    self.videoType = [aDecoder decodeObjectForKey:kVideoListVideoType];
//    self.videoUrl = [aDecoder decodeObjectForKey:kVideoListVideoUrl];
//    self.zanVolume = [[aDecoder decodeObjectForKey:kVideoListZanVolume] integerValue];
//    self.zuozheDesc = [aDecoder decodeObjectForKey:kVideoListZuozheDesc];
//    return self;
//
//}
//
///**
// * Implementation of NSCopying copyWithZone: method
// */
//- (instancetype)copyWithZone:(NSZone *)zone
//{
//    STVideoListModel *copy = [STVideoListModel new];
//
//    copy.addTime = [self.addTime copy];
//    copy.commentVolume = self.commentVolume;
//    copy.headimg = [self.headimg copy];
//    copy.isV = self.isV;
//    copy.nickname = [self.nickname copy];
//    copy.playVolume = self.playVolume;
//    copy.sex = [self.sex copy];
//    copy.shareVolume = self.shareVolume;
//    copy.videoDesc = [self.videoDesc copy];
//    copy.videoDuration = [self.videoDuration copy];
//    copy.videoTeam = [self.videoTeam copy];
//    copy.videoThumb = [self.videoThumb copy];
//    copy.videoTitle = [self.videoTitle copy];
//    copy.videoType = [self.videoType copy];
//    copy.videoUrl = [self.videoUrl copy];
//    copy.zanVolume = self.zanVolume;
//    copy.zuozheDesc = [self.zuozheDesc copy];
//
//    return copy;
//}

//@implementation STVideoListModel

@end
