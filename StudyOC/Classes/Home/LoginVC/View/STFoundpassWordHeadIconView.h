//
//  STFoundpassWordHeadIconView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STFoundpassWordHeadIconView : UIView
@property (weak, nonatomic) id<KKCommonDelegate>delegate;
@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (nonatomic,strong) UIButton *sureModifyButton; //  按钮
@property (strong, nonatomic) NSMutableArray *headBtnArray;  //  数组
@property (strong, nonatomic) NSMutableArray *headIconArray;  //  数组


@end

NS_ASSUME_NONNULL_END
