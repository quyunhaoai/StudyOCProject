//
//  STLoginBottomButtonViews.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLoginBottomButtonViews.h"

@implementation STLoginBottomButtonViews

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.lockButton];
    [self addSubview:self.longinButton];
    [self addSubview:self.fondKeyButton];
    
    
    
    
    
}

#pragma mark  -  Get

-(UIButton *)longinButton {
    if (!_longinButton) {
        _longinButton = ({
            UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [but1 setTitle:@"我要登录" forState:UIControlStateNormal];
            [but1 setTitleColor:COLOR_056377 forState:UIControlStateNormal];
            but1;
            
        });
    }
    return _longinButton;
}

- (UIButton *)fondKeyButton {
    if (!_fondKeyButton) {
        _fondKeyButton = ({
            UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [but1 setTitle:@"找会密码" forState:UIControlStateNormal];
            [but1 setTitleColor:COLOR_056377 forState:UIControlStateNormal];
            but1;
            
        });
    }
    return _fondKeyButton;
}

- (UIButton *)lockButton {
    if (!_lockButton) {
        _lockButton = ({
            UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [but1 setTitle:@"切换更多" forState:UIControlStateNormal];
            [but1 setTitleColor:COLOR_056377 forState:UIControlStateNormal];
            but1;
            
        });
    }
    return _lockButton;
}
@end
