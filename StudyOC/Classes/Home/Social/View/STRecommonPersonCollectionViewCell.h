//
//  STRecommonPersonCollectionViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STRecommonPersonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopLab;
@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;

@end

NS_ASSUME_NONNULL_END
