//
//  STFoundPassWordResuldView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STFoundPassWordResuldView.h"

@implementation STFoundPassWordResuldView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    [self addSubview:self.resultImageView];
    [self addSubview:self.titleLabelView];
    
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidth(108), kWidth(108)));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(kHeight(36));
    }];
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.resultImageView.mas_bottom).mas_offset(kHeight(16));
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(Window_W-50);
    }];
    
}
#pragma mark  -  get
- (UILabel *)titleLabelView {
    if (!_titleLabelView) {
        _titleLabelView = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"修改密码成功";

            label;
        });
    }
    return _titleLabelView;
}
- (UIImageView *)resultImageView {
    if (!_resultImageView) {
        _resultImageView = ({
            
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"successFoundPasswordIcon"];
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES;
//            [view addTapGestureWithTarget:self action:@selector(btnClicked:)];
        view ;
            
            
        });
    }
    return _resultImageView;
}
@end
