//
//  STBaseNav.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBaseNav : UINavigationController



/**
 返回到指定的类视图

 @param ClassName 类名
 @param animated 是否动画
 @return 返回是否跳转
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
