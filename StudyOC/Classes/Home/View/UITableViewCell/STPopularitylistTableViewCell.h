//
//  STPopularitylistTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"
#import "STBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface STPersonCollectionViewCell : STBaseCollectionViewCell

@end

/**
 人气榜
 */
@interface STPopularitylistTableViewCell : STBaseTableViewCell
@property (weak,nonatomic) id <KKCommonDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
