//
//  VideoTeam.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/1.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoTeam : STBaseModel
@property (nonatomic, strong) NSString * headimg;
@property (nonatomic, strong) NSObject * nickname;
@property (nonatomic, strong) NSString * uid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
