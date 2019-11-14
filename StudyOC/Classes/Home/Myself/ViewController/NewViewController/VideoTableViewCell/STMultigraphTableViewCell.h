//
//  STMultigraphTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface STMultigraphTableViewCell : STBaseTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;
//@property (weak, nonatomic) id<KKCommonDelegate> delegate; // del

+ (CGFloat)techHeightForOjb:(id)obj;
- (void)refreshData:(id)data;
@end

NS_ASSUME_NONNULL_END
