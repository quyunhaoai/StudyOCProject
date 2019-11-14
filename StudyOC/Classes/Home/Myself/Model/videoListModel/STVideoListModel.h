//
//  STVideoListModel.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/1.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STVideoListModel : STBaseModel
@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, assign) NSInteger commentVolume;
@property (nonatomic, strong) NSString * headimg;
@property (nonatomic, assign) NSInteger isV;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) NSInteger playVolume;
@property (nonatomic, assign) NSInteger  sex;
@property (nonatomic, assign) NSInteger shareVolume;
@property (nonatomic, strong) NSString * videoDesc;
@property (nonatomic, strong) NSString * videoDuration;
@property (nonatomic, strong) NSArray * videoTeam;
@property (nonatomic, strong) NSString * videoThumb;
@property (nonatomic, strong) NSString * videoTitle;
@property (nonatomic, strong) NSArray * videoType;
@property (nonatomic, strong) NSString * videoUrl;
@property (nonatomic, assign) NSInteger zanVolume;
@property (nonatomic, strong) NSString * zuozheDesc;

//-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
//
//-(NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
