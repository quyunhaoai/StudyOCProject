//
//  BaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface ContentBaseViewController : UIViewController

@property (strong, nonatomic) UIView *navBarView; // 视图

@property (nonatomic, strong) NSArray *titles;

@property (strong, nonatomic) NSArray *viewArray;   //数组

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

@property (nonatomic, assign) BOOL isOff;

@property (assign, nonatomic) NSInteger currentIndex;    //

@property (nonatomic,strong) UIButton *rightButton1; //  按钮

@property (nonatomic,strong) UIButton *rightButton2; //  按钮
- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

@end
