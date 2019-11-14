//
//  STFoundpassWordHeadIconView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STFoundpassWordHeadIconView.h"

@implementation STFoundpassWordHeadIconView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}



- (void)setupUI {
    [self addSubview:self.titleLabelView];
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(39));
        make.top.mas_equalTo(self).mas_offset(kHeight(22));
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(Window_W-kWidth(50));
    }];
    
    
    
    NSArray * arrayTitle = @[@"我的房屋",@"物业报修",@"我的收藏",@"我的消息",@"我的管家",@"设置"];
//    NSArray * arrayImage = @[@"我的房屋",@"物业报修",@"我的收藏",@"我的消息",@"我的管家",@"我的设置"];
    int SPNum = 3;//水平一行放几个
    CGFloat JGGMinX = kWidth(28);//起始x值
    CGFloat JGGMinY = 24+kHeight(22)+kHeight(13);//起始y值
    CGFloat SPspace = kWidth(33);//水平距离
    CGFloat CXspace = kHeight(26);//垂直距离
    CGFloat widthJGG = (Window_W- JGGMinX * 2 -SPspace * (SPNum-1)) / SPNum ;//九宫格宽
    CGFloat heightJGG = widthJGG;//九宫格高
    self.headBtnArray = [NSMutableArray arrayWithCapacity:1];
    self.headIconArray = [NSMutableArray arrayWithCapacity:1];
    for ( int  i = 0; i < arrayTitle.count ; i++) {
        //图片
        UIButton * buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBig.imageView.contentMode = UIViewContentModeScaleAspectFill;
        buttonBig.clipsToBounds = YES;
//        [buttonBig setImage:[UIImage imageNamed:STSystemDefaultImageName] forState:UIControlStateNormal];
//        [buttonBig setTitle:arrayTitle[i] forState:UIControlStateNormal];
//        [buttonBig setTitleColor:MAIN_COLOR_333333 forState:UIControlStateNormal];
        buttonBig.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttonBig setBackgroundColor:kClearColor];
        [buttonBig addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        buttonBig.tag = 1001+i;
//        [buttonBig setImagePositionWithType:SSImagePositionTypeTop spacing:10];
        buttonBig.adjustsImageWhenHighlighted = NO;
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;



        [self addSubview:imageView];
        [self.headIconArray addObject:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(JGGMinX + i % SPNum * (widthJGG + SPspace));
            make.top.mas_equalTo(JGGMinY + i / SPNum * (heightJGG + CXspace));
            make.width.mas_equalTo(widthJGG);
            make.height.mas_equalTo(heightJGG);
            //不能再这里跟新约束，否则会警告,控件错位
        }];
        
        [self addSubview:buttonBig];
        [self.headBtnArray addObject:buttonBig];
        [buttonBig mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(JGGMinX + i % SPNum * (widthJGG + SPspace));
            make.top.mas_equalTo(JGGMinY + i / SPNum * (heightJGG + CXspace));
            make.width.mas_equalTo(widthJGG);
            make.height.mas_equalTo(heightJGG);
            //不能再这里跟新约束，否则会警告,控件错位
        }];
    }
    
    [self addSubview:self.sureModifyButton];
    [self.sureModifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(JGGMinY + 2 * (heightJGG + CXspace)+kHeight(0));
        make.left.mas_equalTo(self).mas_offset(kWidth(14));
        make.width.mas_equalTo(Window_W-28);
        make.height.mas_equalTo(kHeight(45));
    }];
    
}
    



- (void)btnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
#pragma mark  -  get
- (UILabel *)titleLabelView {
    if (!_titleLabelView) {
        _titleLabelView = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"请选择如下头像，那个是你使用的";

            label;
        });
    }
    return _titleLabelView;
}
- (UIButton *)sureModifyButton {
    if (!_sureModifyButton) {
        _sureModifyButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_HEX_RGB(0xbdbdbd) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_HEX_RGB(0xe2e2e2)];
            [btn setTag:BUTTON_TAG(5)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"确定提交" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
            
        });
    }
    return _sureModifyButton;
}




@end
