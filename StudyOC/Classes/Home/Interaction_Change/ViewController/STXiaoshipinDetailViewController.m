//
//  STXiaoshipinDetailViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STXiaoshipinDetailViewController.h"

@interface STXiaoshipinDetailViewController ()

@end

@implementation STXiaoshipinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_H)];
    [self.view addSubview:imageView];
    imageView.image = IMAGE_NAME(STSystemDefaultImageName);
    
}


@end
