//
//  STSmallPlayShopTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/12/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallVideoModel.h"
#import "SmallVideoPlayCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface STSmallPlayShopTableViewCell : UITableViewCell
@property (nonatomic, strong) SmallVideoModel *model;
@property (nonatomic, strong) UIView *playerFatherView;

@property (nonatomic, weak) id<SmallVideoPlayCellDlegate> delegate;
@property (weak, nonatomic) IBOutlet UIStackView *leftStackview;
@end

NS_ASSUME_NONNULL_END
