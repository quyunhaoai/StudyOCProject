//
//  STBaseTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//
//#define space 10
//#define normalSpace 12
//#define smaillSpace 5
#import <UIKit/UIKit.h>
//#import "TYAttributedLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface STBaseTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)TYAttributedLabel *titleLabel;
@property(nonatomic,strong)UILabel *nameStringLabel;
@property(nonatomic,strong)UILabel *subNameStringLabel;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *newsTipBtn; 
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIView *splitView;//分割线
@property(nonatomic,strong)UIButton *playVideoBtn;

@property (strong, nonatomic) UIImageView *headerIconView; // 头 视图
@property (strong, nonatomic) UIImageView *vipImageView; //  图片

@property (strong, nonatomic) UIImageView *coverView; // 视频 视图
@property (strong, nonatomic) UIImageView *coverBgView; // 渐变蒙版 视图
@property (strong, nonatomic) UILabel *commentLabel; // 评论 标签
@property (strong, nonatomic) UILabel *stateLabel; // 状态 视图
@property (strong, nonatomic) UILabel *videoTimeLabel; // 标签

@property (nonatomic,strong) UIButton *withdrawButton; //  按钮
@property(nonatomic,weak)id<KKCommonDelegate>delegate;

+ (CGFloat)techHeightForOjb:(id)obj;
- (void)refreshData:(id)data;
- (void)moreBtnClicked:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
