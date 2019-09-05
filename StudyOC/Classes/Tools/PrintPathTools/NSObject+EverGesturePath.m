//
//  NSObject+EverGesturePath.m
//  EverShowPath
//
//  Created by Ever on 17/1/3.
//  Copyright © 2017年 Beijing Byecity International Travel CO., Ltd. All rights reserved.
//  欢迎关注微信公众号：iOS狗
//

#import "NSObject+EverGesturePath.h"
#import <objc/runtime.h>

/**
 刚才被点击的页面
 */
@implementation NSObject (EverGesturePath)

+ (void)load {
#ifdef DEBUG
#if kPrintPathLog == 1
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIGestureRecognizerTarget");
        Method m1 = class_getInstanceMethod(cls, NSSelectorFromString(@"_sendActionWithGestureRecognizer:"));
        Method m2 = class_getInstanceMethod([self class], NSSelectorFromString(@"sendActionWithGestureRecognizer_EverGesture:"));
        method_exchangeImplementations(m1, m2);
    });
#endif
#endif
}

- (void)sendActionWithGestureRecognizer_EverGesture:(id)arg1 {
    [self sendActionWithGestureRecognizer_EverGesture:arg1];
    NSLog(@"vanishing_page_Path: %@",self);
}

@end
