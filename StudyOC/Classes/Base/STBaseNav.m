//
//  STBaseNav.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseNav.h"

@interface STBaseNav ()

@end

@implementation STBaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
