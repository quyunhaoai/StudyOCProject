//
//  STBaseNav.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseNav.h"

@interface STBaseNav ()<UIGestureRecognizerDelegate>

@end

@implementation STBaseNav


- (void)viewDidLoad {
    [super viewDidLoad];
    /**iOS7之后是有侧滑返回手势功能的。注意，也就是说系统已经定义了一种手势，并且给这个手势已经添加了一个触发方法（重点）。但是，系统的这个手势的触发条件是必须从屏幕左边缘开始滑动。我们取巧的方法是自己写一个支持全屏滑动的手势，而其触发方法系统已经有，没必要自己实现pop的动画，所以直接就把系统的触发处理方法作为我们自己定义的手势的处理方法。**/
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    // 控制手势什么时候触发,只有非根控制器才需要触发手势
    pan.delegate = self;
    
    // 禁止之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 假死状态:程序还在运行,但是界面死了.
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
//  //默认值为“是”。如果导航栏具有自定义背景图像，则如果图像的任何像素的alpha值小于1.0，则默认为“是”，否则为“否”。如果在具有不透明自定义背景图像的导航栏上将此属性设置为“是”，则导航栏将对图像应用小于1.0的系统定义不透明度。如果在具有半透明自定义背景图像的导航栏上将此属性设置为“否”，则如果导航栏具有uibarstyleblack样式，导航栏将使用黑色为图像提供不透明的背景；如果导航栏具有uibarstyledefault，导航栏将使用白色；或者如果定义了自定义值，则为tintcolor。
//    self.navigationController.navigationBar.tintColor = kWhiteColor;//uiview的所有子类都从基类派生其tintcolor行为
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)load{

//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil]; //iOS9以下
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    //appearancewhencontainedinstancesofclasses
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];//粗体
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];//系统字体
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    [navBar setBackgroundColor:kRedColor];
//    [navBar setAlpha:1.0f];
//    [navBar setTintColor:kYellowColor];
}
#pragma mark - UIGestureRecognizerDelegate
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"back" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//        [backButton setImage:@"" forState:UIControlStateNormal];
//        [backButton setImage:@"" forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *letfItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = letfItem;
        // 设置返回按钮,只有非根控制器
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated {
    
    id vc = [self getCurrentViewControllerClass:ClassName];
    if (vc !=nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

- (instancetype)getCurrentViewControllerClass:(NSString *)className {
    Class classObj = NSClassFromString(className);
    
    NSArray *array = self.viewControllers;
    
    for (id vc in array) {
        if ([vc isMemberOfClass:classObj]) {
            return  vc;
        }
    }
    return nil;
}

@end
