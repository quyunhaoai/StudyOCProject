//
//  STRecommenVideoTableViewCell.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 推荐。视频
 */
@interface STRecommenVideoTableViewCell : STBaseTableViewCell

+ (CGFloat)techHeightForOjb:(id)obj;
- (void)refreshData:(id)data;
@end

NS_ASSUME_NONNULL_END
