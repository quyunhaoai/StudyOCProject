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
    self.areaLabel.text = @" 黔东南·凯里市  ";
     ViewBorderRadius(self.userHeadIcon, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
    self.shopLab.textColor = color_textBg_C7C7D1;
    self.areaLab.textColor = color_textBg_C7C7D1;
    self.themeLab.textColor = color_textBg_C7C7D1;
}

- (IBAction)buttonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.selected) {
//        button.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
//        [button setBackgroundColor:[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f]];
        [button setTitle:@"已关注" forState:UIControlStateNormal];
    } else {
//        button.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
//        [button setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] ];
        [button setTitle:@"关注+" forState:UIControlStateNormal];
    }
}
@end
