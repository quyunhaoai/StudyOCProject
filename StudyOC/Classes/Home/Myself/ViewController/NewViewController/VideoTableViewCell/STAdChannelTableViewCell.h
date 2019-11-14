//
//  STAdChannelTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface STAdChannelTableViewCell : STBaseTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;
@property (assign, nonatomic) BOOL isShowWithdram; 

@end

NS_ASSUME_NONNULL_END
