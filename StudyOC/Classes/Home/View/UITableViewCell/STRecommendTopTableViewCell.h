//
//  STRecommendTopTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"
#import "STBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN
//@protocol STRecommendTopTableViewDelele <NSObject>
//@optional
//- (void)didSelectCell:(NSIndexPath *)index;
//@end

@interface STRecommendTopCollectionViewCell : STBaseCollectionViewCell


@end


@interface STRecommendTopTableViewCell : STBaseTableViewCell
@property (nonatomic,weak) id<KKCommonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
