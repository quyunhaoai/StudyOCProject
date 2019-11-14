//
//  STLocationChannelTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/17.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"
#import "SPActivityIndicatorView.h"
NS_ASSUME_NONNULL_BEGIN

/// 直播cell
@interface STLocationChannelTableViewCell : STBaseTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,strong)CAGradientLayer *gradientLayer1;
@property (strong, nonatomic) SPActivityIndicatorView *activityView; //  视图
@property (strong, nonatomic) UIView *smallWindosView; //  视图
+ (CGFloat)techHeightForOjb:(id)obj;
- (void)refreshData:(id)data;
- (void)resetPlayerView;

@end

NS_ASSUME_NONNULL_END
