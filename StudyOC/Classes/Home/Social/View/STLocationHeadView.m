//
//  STLocationHeadView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/13.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLocationHeadView.h"
@interface STLocationHeadView()


@property (strong, nonatomic) UILabel *changeCityLabel; //  标签
@property (strong, nonatomic) UIImageView *chageImageView; //  图片
@property (strong, nonatomic) UIImageView *locationImageView; //    图片



@end
@implementation STLocationHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = color_cellBg_151420;
//    [self addSubview:self.changeCityLabel];
//    [self addSubview:self.chageImageView];
    [self addSubview:self.currentCityLabel];
    [self addSubview:self.locationImageView];
//    [self.changeCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).mas_offset(14);
//        make.centerY.mas_equalTo(self);
//        make.width.mas_equalTo(56);
//    }];
    [self addSubview:self.changeLocButton];
//    [self addSubview:self.currentBtnView];
    [self.changeLocButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(14);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(18);
    }];
    [self.changeLocButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitlePadding:5];
//    [self.currentBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self).mas_offset(-18);
//        make.centerY.mas_equalTo(self);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(18);
//    }];
    [self.locationImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-20);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.currentCityLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.locationImageView.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(18);
    }];
}
- (UILabel *)changeCityLabel {
    if (!_changeCityLabel) {
        _changeCityLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = color_text_AFAFB1;
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentCenter;
            view.numberOfLines = 1;
            view ;
            
            
        });
    }
    return _changeCityLabel;
}
- (UIImageView *)chageImageView {
    if (!_chageImageView) {
        _chageImageView = ({
            
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view.image = IMAGE_NAME(@"locationWhiteIcon");
//            ViewBorderRadius(view, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
            view;
        });
    }
    return _chageImageView;
}
- (UILabel *)currentCityLabel {
    if (!_currentCityLabel) {
        _currentCityLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = kWhiteColor;
            view.font = FONT_12;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.numberOfLines = 1;
            view ;
            
            
        });
    }
    return _currentCityLabel;
}
-(UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView =({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view.image = IMAGE_NAME(@"locationIcon");
//            ViewBorderRadius(view, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
            view;
            
            
        });
    }
    return _locationImageView;
}

//#pragma  mark  --  currentBtn 懒加载
//- (UIButton *)currentBtnView {
//
//    if (!_currentBtnView) {
//        _currentBtnView = ({
//            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitle:@"郑州" forState:UIControlStateNormal];
//            [view.titleLabel setFont:FONT_12];
//            [view.titleLabel setTextColor:kWhiteColor];
//            view.layer.masksToBounds = YES;
//            [view setImage:IMAGE_NAME(@"locationIcon") forState:UIControlStateNormal];
//            view.alpha = 1;
//            [view setUserInteractionEnabled:YES];
//            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [view setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:30];
//            view ;
//
//        });
//    }
//    return _currentBtnView;
//}
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
//            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setImage:IMAGE_NAME(@"locationWhiteIcon") forState:UIControlStateNormal];
            view.layer.cornerRadius = 5;
            [view setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitlePadding:5];
            view.layer.backgroundColor = [[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:50.0f/255.0f alpha:1.0f] CGColor];
            view ;
        });
    }
    return _changeLocButton;
}
//
//- (void)addBtnClick:(UIButton *)button {
//
//
//}
@end
