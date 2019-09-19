//
//  STChildrenViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/11.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STChildrenViewController.h"

@interface STChildrenViewController ()

@end

@implementation STChildrenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KKRandomColor;
    STChildrenModel *model = [[STChildrenModel alloc] init];
    model.name = @"Jack!";
    
    NSLog(@"%@",model.description);
}



@end
