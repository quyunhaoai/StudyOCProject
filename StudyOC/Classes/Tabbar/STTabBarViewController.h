//
//  STTabBarViewController.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STTabBarViewController : UITabBarController

/**
 单例模式创建Tab bar

 @return Tab bar
 */
+ (instancetype)getTabBarController;
@end

NS_ASSUME_NONNULL_END
