//
//  STBaseTableViewController.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface STBaseTableViewController : STBaseViewController

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 初始化类

 @param style 表风格类型
 @return 当前类
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;



@end

NS_ASSUME_NONNULL_END
