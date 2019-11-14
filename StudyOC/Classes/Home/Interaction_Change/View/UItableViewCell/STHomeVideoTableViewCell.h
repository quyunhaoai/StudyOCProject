//
//  STHomeVideoTableViewCell.h
//  
//
//  Created by 研学旅行 on 2019/11/7.
//

#import <UIKit/UIKit.h>
#import "STBaseTableViewCell.h"
#import "STVideoChannelModl.h"
NS_ASSUME_NONNULL_BEGIN

@interface STHomeVideoTableViewCell : STBaseTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,strong)CAGradientLayer *gradientLayer1;
@property (strong, nonatomic) UIImageView *playSmallImageView; //  图片
@property (assign, nonatomic) BOOL isShowWithdram; //
@property (strong, nonatomic) NSMutableDictionary *withdrawDic;  //  字典
@property (strong, nonatomic) UIView *smallWindosView; //  视图

+ (CGFloat)techHeightForOjb:(STVideoChannelModl *)obj;
- (void)refreshData:(STVideoChannelModl *)model;
@end

NS_ASSUME_NONNULL_END
