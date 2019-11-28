//
//  KKRelateVideoCell.h
//  KKToydayNews
//
//  Created by finger on 2017/9/17.
//  Copyright © 2017年 finger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBaseTableViewCell.h"
#import "STVideoChannelModl.h"
@interface KKRelateVideoCell : STBaseTableViewCell
- (void)refreshData:(STVideoChannelModl *)data;
@end
