//
//  STBaseViewController.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNavTitleView.h"
#import "KKNoDataView.h"
NS_ASSUME_NONNULL_BEGIN

@interface STBaseViewController : UIViewController
@property (strong, nonatomic) KKNavTitleView *navTitleView; //  视图
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isShowErrorPageView;
@property (assign, nonatomic) BOOL isShowNoDataPageView; 
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) KKNoDataView *noDataView; //  视图
/**
 初始化导航栏

 @param title 标题
 */
- (void)customNavBarWithTitle:(NSString *)title;

/**
 含左侧按钮

 @param title 标题
 @param imageName 左侧按钮名
 */
- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName;

/**
 含右侧按钮集合

 @param title 标题
 @param imageName 左侧标题
 @param array 右侧按钮集合
 */
- (void)customNavBarWithtitle:(NSString *)title andLeftView:(NSString *)imageName andRightView:(NSArray *)array;


/**
 自定义左右两侧控件

 @param title 标题
 @param leftViews 左侧views
 @param rightViews 右侧views
 */
- (void)customNavBarwithTitle:(NSString *)title andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews;


/**
 全部自定义

 @param titleView 中间View
 @param leftViews 左侧Views
 @param rightViews 右侧Views
 */
- (void)customNavBarWithTitleView:(UIView *)titleView andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews;

@end

NS_ASSUME_NONNULL_END
