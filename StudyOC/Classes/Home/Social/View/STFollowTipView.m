//
//  STFollowTipView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STFollowTipView.h"

@implementation STFollowTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, Window_W-60, self.height)];
    [self addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = FONT_10;
    _titleLabel.textColor = color_B2B2B2;
    _titleLabel.text = @"抱歉，当前您还未关注任何粉号自媒体！";
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:IMAGE_NAME(@"close_follow") forState:UIControlStateNormal];
    [self addSubview:_closeButton];
    _closeButton.frame = CGRectMake(Window_W-30, 0, 30, self.height);
    
}

@end
