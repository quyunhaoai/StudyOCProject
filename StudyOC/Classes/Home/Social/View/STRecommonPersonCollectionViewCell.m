//
//  STRecommonPersonCollectionViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRecommonPersonCollectionViewCell.h"

@implementation STRecommonPersonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    

    self.areaLabel.layer.cornerRadius = 1;
    self.areaLabel.layer.backgroundColor = [[UIColor colorWithRed:109.0f/255.0f green:108.0f/255.0f blue:136.0f/255.0f alpha:1.0f] CGColor];
    self.areaLabel.alpha = 1;
//    self.areaLabel.qyh_width = STRINGFONT_2_WIDTH(@"黔东南·凯里市", 11, FONT_14);
//    self.areaLabel.yn_width = 80;
    self.areaLabel.text = @" 黔东南·凯里市  ";
}

@end
