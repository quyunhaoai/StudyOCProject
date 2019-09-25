//
//  STBaseTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define space 10
#define smaillSpace 5
#import <UIKit/UIKit.h>
#import "TYAttributedLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface STBaseTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)TYAttributedLabel *titleLabel;
@property(nonatomic,strong)TYAttributedLabel *nameStringLabel;
@property(nonatomic,strong)TYAttributedLabel *subNameStringLabel;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *newsTipBtn; 
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIView *splitView;//分割线
@property(nonatomic,strong)UIButton *playVideoBtn;

@property (strong, nonatomic) UIImageView *headerIconView; // 头 视图
@property (strong, nonatomic) UIImageView *coverView; // 视频 视图
@property (strong, nonatomic) UIImageView *coverBgView; // 渐变蒙版 视图
@property (strong, nonatomic) UILabel *commentLabel; // 评论 标签
@property (strong, nonatomic) UILabel *stateLabel; // 状态 视图
@property (strong, nonatomic) UILabel *videoTimeLabel; // 标签


//@property(nonatomic,weak)KKSummaryContent *item;
//@property(nonatomic,weak)id<KKCommonDelegate>delegate;

//+ (CGFloat)fetchHeightWithItem:(KKSummaryContent *)item ;
//- (void)refreshWithItem:(KKSummaryContent *)item ;
//计算视频时间字符、图片个数字符等宽度
//- (CGFloat)fetchNewsTipWidth;
@end

NS_ASSUME_NONNULL_END
