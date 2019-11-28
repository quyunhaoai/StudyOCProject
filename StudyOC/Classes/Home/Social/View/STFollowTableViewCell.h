//
//  STFollowTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STFollowTableViewCell : UITableViewCell
@property (weak, nonatomic) id<KKCommonDelegate> delegate; // 
@property (weak, nonatomic) IBOutlet UIImageView *userHeadIcon;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property(nonatomic,strong) CAGradientLayer *gradientLayer;
@end

NS_ASSUME_NONNULL_END
