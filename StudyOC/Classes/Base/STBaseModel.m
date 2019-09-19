//
//  STBaseModel.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/11.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseModel.h"
#import <objc/runtime.h>
@implementation STBaseModel
- (NSString *)description {
    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
    NSMutableArray *attrName = [NSMutableArray array];
    
    unsigned int outCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertys[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [attrName addObject:propertyName];
    }
    free(propertys);
    
    for (NSString *attributeName in attrName) {
        
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *__unsafe_unretained valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            if (valueObj) {
                [attrsDesc appendFormat:@" [%@ = %@] ",attributeName,valueObj];
            }else {
                [attrsDesc appendFormat:@" [%@ = nil] ",attributeName];
            }
        }
    }
    NSString *desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
    return desc;
}

- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [self mj_encode:encoder];
}

- (id)valueForUndefinedKey:(NSString *)key {
    return @"";
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end
