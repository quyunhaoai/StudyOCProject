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
@property(nonatomic,strong)UILabel *refreshTipLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 初始化类

 @param style 表风格类型
 @return 当前类
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 添加刷新
 */
- (void)addTableViewRefresh;

- (void)refreshTableViewData;

/**
 刷新数据

 @param header 是否有之前的数据
 @param showTip 是否显示提示消息
 */
- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip;
@end

NS_ASSUME_NONNULL_END
