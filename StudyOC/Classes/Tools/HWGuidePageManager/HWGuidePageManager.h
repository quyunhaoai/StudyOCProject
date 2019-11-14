//
//  HWGuidePageManager.h
//  TransparentGuidePage
//
//  Created by wangqibin on 2018/4/20.
//  Copyright © 2018年 sensmind. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(void);

typedef NS_ENUM(NSInteger, HWGuidePageType) {
    HWGuidePageTypeHome = 0,//圆形
    HWGuidePageTypeMajor,//矩形
};

@interface HWGuidePageManager : NSObject

// 获取单例
+ (instancetype)shareManager;

/**
 显示方法

 @param type 指引页类型
 */
- (void)showGuidePageWithType:(HWGuidePageType)type;

/**
 显示方法

 @param type 指引页类型
 @param completion 完成时回调
 */
- (void)showGuidePageWithType:(HWGuidePageType)type completion:(FinishBlock)completion;

@end
