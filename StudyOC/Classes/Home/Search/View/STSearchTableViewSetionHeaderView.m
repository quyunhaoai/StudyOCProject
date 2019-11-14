//
//  STSearchTableViewSetionHeaderView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSearchTableViewSetionHeaderView.h"
#define itemButtonWidth 24
@implementation STSearchTableViewSetionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_viewBG_1A1929;
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, (40-itemButtonWidth)/2.0, Window_W-itemButtonWidth,24)];
        self.itemLabel.font = FONT_11;
        self.itemLabel.textColor = color_text_AFAFB1;
        [self addSubview:self.itemLabel];
        self.itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.itemButton.frame =CGRectMake(Window_W-30-12, (40-itemButtonWidth)/2.0, itemButtonWidth, itemButtonWidth);
        [self.itemButton setTitle:@"展开" forState:UIControlStateNormal];
        self.itemButton.titleLabel.font = FONT_10;
        [self.itemButton setTitleColor:color_text_AFAFB1 forState:UIControlStateNormal];
        [self addSubview:self.itemButton];
    }
    return self;
}

@end
