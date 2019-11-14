//
//  VideoTeam.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/1.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "VideoTeam.h"
NSString *const kVideoTeamHeadimg = @"headimg";
NSString *const kVideoTeamNickname = @"nickname";
NSString *const kVideoTeamUid = @"uid";
@implementation VideoTeam
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kVideoTeamHeadimg] isKindOfClass:[NSNull class]]){
        self.headimg = dictionary[kVideoTeamHeadimg];
    }
    if(![dictionary[kVideoTeamNickname] isKindOfClass:[NSNull class]]){
        self.nickname = dictionary[kVideoTeamNickname];
    }
    if(![dictionary[kVideoTeamUid] isKindOfClass:[NSNull class]]){
        self.uid = dictionary[kVideoTeamUid];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.headimg != nil){
        dictionary[kVideoTeamHeadimg] = self.headimg;
    }
    if(self.nickname != nil){
        dictionary[kVideoTeamNickname] = self.nickname;
    }
    if(self.uid != nil){
        dictionary[kVideoTeamUid] = self.uid;
    }
    return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.headimg != nil){
        [aCoder encodeObject:self.headimg forKey:kVideoTeamHeadimg];
    }
    if(self.nickname != nil){
        [aCoder encodeObject:self.nickname forKey:kVideoTeamNickname];
    }
    if(self.uid != nil){
        [aCoder encodeObject:self.uid forKey:kVideoTeamUid];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.headimg = [aDecoder decodeObjectForKey:kVideoTeamHeadimg];
    self.nickname = [aDecoder decodeObjectForKey:kVideoTeamNickname];
    self.uid = [aDecoder decodeObjectForKey:kVideoTeamUid];
    return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    VideoTeam *copy = [VideoTeam new];

    copy.headimg = [self.headimg copy];
    copy.nickname = [self.nickname copy];
    copy.uid = [self.uid copy];

    return copy;
}

@end
