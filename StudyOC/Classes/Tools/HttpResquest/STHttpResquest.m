//
//  STHttpResquest.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHttpResquest.h"
#import "SVProgressHUD+DGActivityIndicatorView.h"
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
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD show];
    [SVProgressHUD setActivityIndicatorType:DDActivityIndicatorAnimationTypeBallPulse];
    [SVProgressHUD setActivityIndicatorTintColor:kWhiteColor];
     NSString *urlstr = [NSString stringWithFormat:@"%@%@",KBaseLocation,path];
    switch (method) {
        case GET:{
            [self GET:urlstr
           parameters:params
             progress:nil
              success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                [SVProgressHUD dismiss];
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [SVProgressHUD dismiss];
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
                [SVProgressHUD dismiss];
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [SVProgressHUD dismiss];
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
@end
