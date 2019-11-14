//
//  STHttpResquest.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHttpResquest.h"

@implementation STHttpResquest

+ (instancetype)sharedManager {
    static STHttpResquest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kUrl]];
    });
    return manager;
}

+ (instancetype)sharedNetworkToolsWithoutBaseUrl
{
    static STHttpResquest *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:kUrl];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                              @"application/json",
                                                              @"text/json",
                                                              @"text/javascript",
                                                              @"text/html", nil];
    });
    return instance;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"application/json",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          @"text/json",
                                                          @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    NSLog(@"params:%@\n",params);
     NSString *urlstr = [NSString stringWithFormat:@"%@%@",KBaseLocation,path];
    switch (method) {
        case GET:{
            [self GET:urlstr
           parameters:params
             progress:nil
              success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
//                NSInteger status = [[responseObject objectForKey:@"state"] integerValue];
//                NSString *msg = [[responseObject objectForKey:@"msg"] description];
//                if(status == 200){
                    success(responseObject);
//                }else {
//                    if (status == 400) {
////                        success(responseObject);
//                    } else {
//                        if (msg.length>0) {
//                            [MBManager showBriefAlert:msg];
//                        }
//                    }
//                }
//                NSLog(@"msg:%@ status:%ld",msg,status);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:urlstr
            parameters:params
              progress:nil
               success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
//                NSString *msg = [[responseObject objectForKey:@"msg"] description];
//                NSInteger status = [[responseObject objectForKey:@"state"] integerValue];
//                if(status == 200){
                    success(responseObject);
//                }else {
//                    NSDictionary *data = [responseObject objectForKey:@"data"];
//                    if ([data.allKeys containsObject:@"auth_error"]) {
//                       NSInteger auth_error = [[data objectForKey:@"auth_error"] integerValue];
//                        if (auth_error  == 1) {
//                            success(responseObject);
//                        }
//                    }
//                    if (msg.length>0) {
//                        [MBManager showBriefAlert:msg];
//                    }
////
//                }
//                NSLog(@"msg:%@ status:%ld",msg,status);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
@end
