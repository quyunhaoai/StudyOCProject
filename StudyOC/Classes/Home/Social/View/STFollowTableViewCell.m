//
//  STFollowTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STFollowTableViewCell.h"

@implementation STFollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBorderRadius(self.userHeadIcon, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
    [self.coverImageView.layer insertSublayer:self.gradientLayer below:self.playCountLab.layer];
    self.gradientLayer.frame = CGRectMake(0, MaxY(self.coverImageView.frame)-45, WIDTH(self.coverImageView), 45);
}
	
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 5;
    [super setFrame:frame];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:@""];
    }
}
- (CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.01f].CGColor, (__bridge id)[UIColor colorWithRed:48.0f/255.0f green:55.0f/255.0f blue:66.0f/255.0f alpha:0.90f].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    }
    return _gradientLayer;
}

@end
