//
//  STHttpResquest.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN
//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;
@interface STHttpResquest : AFHTTPSessionManager
+ (instancetype)sharedManager;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
