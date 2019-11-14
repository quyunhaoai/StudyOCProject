//
//  STLocationHeadView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLocationHeadView.h"
@interface STLocationHeadView()
@property (strong, nonatomic) UIButton *currentBtnView; //  视图
@property (nonatomic,strong) UIButton *changeLocButton; //  按钮

@end
@implementation STLocationHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    [self addSubview:self.changeLocButton];
    [self addSubview:self.currentBtnView];
    [self.changeLocButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(14);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(18);
    }];
    [self.changeLocButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitlePadding:5];
    [self.currentBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-18);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(18);
    }];
}
#pragma  mark  --  currentBtn 懒加载
- (UIButton *)currentBtnView {
    
    if (!_currentBtnView) {
        _currentBtnView = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"郑州" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_12];
            [view.titleLabel setTextColor:kWhiteColor];
            view.layer.masksToBounds = YES;
            [view setImage:IMAGE_NAME(@"locationIcon") forState:UIControlStateNormal];
            view.alpha = 1;
            [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:30];
            view ;

        });
    }
    return _currentBtnView;
}
- (UIButton *)changeLocButton {
    if (!_changeLocButton) {
        _changeLocButton = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"城市切换" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_10];
            [view.titleLabel setTextColor:KKColor(199, 199, 209, 1)];
            view.layer.masksToBounds = YES;
            view.alpha = 1;
            [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setImage:IMAGE_NAME(@"locationWhiteIcon") forState:UIControlStateNormal];
            view.layer.cornerRadius = 5;
            [view setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitlePadding:5];
            view.layer.backgroundColor = [[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:50.0f/255.0f alpha:1.0f] CGColor];
            view ;
        });
    }
    return _changeLocButton;
}

- (void)addBtnClick:(UIButton *)button {
    
    
}
@end
