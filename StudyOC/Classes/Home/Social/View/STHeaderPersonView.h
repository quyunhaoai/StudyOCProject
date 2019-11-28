//
//  STHeaderPersonView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
NS_ASSUME_NONNULL_BEGIN

@interface STHeaderPersonView : UIView
@property(nonatomic,strong)UILabel *nameStringLabel;
@property(nonatomic,strong)UILabel *subNameStringLabel;
@property (strong, nonatomic) UIImageView *headerIconView; // 头 视图
@property (strong, nonatomic) UIImageView *vipImageView; //  图片
@property (nonatomic,strong) UIButton *addButton; //  按钮
@property (strong, nonatomic) TagView *tagView; //  视图
@property (strong, nonatomic) TYAttributedLabel *detailLabel; //  标签
@property (strong, nonatomic) UILabel *typeLabel; //  标签

@property (strong, nonatomic) NSArray *titleLabArray;   // 数组
@end

NS_ASSUME_NONNULL_END
