//
//  STSearchHistoryTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKSearchHotDataTypeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface STSearchHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) NSMutableArray *recommendModelArray;    // 搜索热词 array
@property (strong, nonatomic) NSMutableArray *historyArray;  //  数组

@property (strong, nonatomic) AKSearchHotDataTypeView *searchHotDataTypeView; // hot 视图

+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;

/*
 *  AKSearchHotCell label click block
 */
@property (copy, nonatomic) void(^searchHotCellLabelClickButton)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
