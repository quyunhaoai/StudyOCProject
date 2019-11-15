//
//  STLocationThemeTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/14.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STLocationThemeTableViewCell : UITableViewCell
@property (strong, nonatomic) NSMutableArray *categortArray;  //  数组
@property (assign, nonatomic) BOOL isShowAll;
@property (copy, nonatomic) void(^searchHotCellLabelClickButton)(NSInteger tag,STLocationThemeTableViewCell *cell);
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;
+ (CGFloat)techHeightForOjb:(id)obj;
@end

NS_ASSUME_NONNULL_END
