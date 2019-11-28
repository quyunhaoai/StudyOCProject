//
//  STLoginMobileInputView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/10.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLoginMobileInputView.h"

@implementation STLoginMobileInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.titleLabelView];
    [self addSubview:self.verWordLabel];
    [self addSubview:self.mobileLabel];
    [self addSubview:self.mobileTextView];
    [self addSubview:self.verWordTextView];
    [self addSubview:self.justButton];
    [self addSubview:self.loginButton];
    [self addSubview:self.verButton];
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kHeight(72));
        make.left.mas_equalTo(self).mas_offset(27);
        make.size.mas_equalTo(CGSizeMake(kWidth(200), 40));
    }];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.titleLabelView.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(101));
        make.top.mas_equalTo(self.mobileLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    [self.verWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.mobileLabel.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.verWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(101));
        make.top.mas_equalTo(self.verWordLabel);
        make.right.mas_equalTo(self).mas_offset(-144);
        make.height.mas_equalTo(21);
    }];

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verWordTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];

    [self.justButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(kHeight(19));
        make.left.mas_equalTo(self.titleLabelView.mas_left).mas_offset(-kWidth(2));
        make.size.mas_equalTo(CGSizeMake(Window_W-50, 21));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.justButton.mas_bottom).mas_offset(kHeight(30));
        make.left.mas_equalTo(self).mas_offset(14);
        make.width.mas_equalTo(Window_W-28);
        make.height.mas_equalTo(kHeight(45));
    }];
    
    [self addSubview:self.verButton];
    [self.verButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.verWordTextView);
        make.right.mas_equalTo(self).mas_offset(-kWidth(37));
        make.size.mas_equalTo(CGSizeMake(97, 26));
    }];
    
    self.line1= line1;
    self.line2= line2;
}
#pragma mark  -  get

- (UIButton *)verButton {
    if (!_verButton) {
        _verButton =({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(6)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 3;
            btn.layer.borderColor = [[UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] CGColor];
            btn.layer.borderWidth = 1;
            btn.layer.backgroundColor = [[UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1.0f] CGColor];
            btn ;
            
        });
    }
    return _verButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_HEX_RGB(0xe1451f)];
            [btn setTag:BUTTON_TAG(8)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
            
        });
    }
    return _loginButton;
}

- (UIButton *)justButton {
    if (!_justButton) {
        _justButton =({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_HEX_RGB(0x2a5d8f) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"使用账号登录" forState:UIControlStateNormal];
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [btn setTag:BUTTON_TAG(2)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitlePadding:0];
            btn ;
        });
    }
    return _justButton;
}


- (void)btnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}

- (UILabel *)titleLabelView {
    if (!_titleLabelView) {
        _titleLabelView = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:28];
            label.text = @"手机号登录";

            label;
        });
    }
    return _titleLabelView;
}

- (UITextField *)mobileTextView {
    if (!_mobileTextView) {
        _mobileTextView =  ({
                   UITextField *textfield = [[UITextField alloc] init];
                   //设置边框
                   textfield.borderStyle = UITextBorderStyleNone;
                   //设置水印提示
                   textfield.placeholder = @"手机号";
                   textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
                   //设置输入框右边的一键删除（x号）
                   textfield.clearButtonMode = 0;
                   //设置密码安全样式
                   textfield.secureTextEntry = NO;
                   //设置键盘样式
                   textfield.keyboardType = UIKeyboardTypeNumberPad ;
                   textfield.backgroundColor = kClearColor;
                   //设置输入的字体大小
                   textfield.font = [UIFont systemFontOfSize:15];

                   textfield;
               });
    }
    return _mobileTextView;
}

- (UITextField *)verWordTextView {
    if (!_verWordTextView) {
        _verWordTextView = ({
               UITextField *textfield = [[UITextField alloc] init];
               //设置边框
               textfield.borderStyle = UITextBorderStyleNone;
               //设置水印提示
               textfield.placeholder = @"请填写验证码";
               textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
               //设置输入框右边的一键删除（x号）
               textfield.clearButtonMode = 0;
               //设置密码安全样式
               textfield.secureTextEntry = YES;
               //设置键盘样式
               textfield.keyboardType = UIKeyboardTypeNumberPad;
                
               textfield.backgroundColor = kClearColor;
               //设置输入的字体大小
               textfield.font = [UIFont systemFontOfSize:15];

               textfield;
           });
    }
    return _verWordTextView;
}

- (UILabel *)mobileLabel {
    if (!_mobileLabel) {
        _mobileLabel =({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
            label.text = @"手机号";
//            设置字体颜色
            label.textColor = [UIColor blackColor];
//            设置字体和字号
            label.font = [UIFont systemFontOfSize:15];
//            设置多行显示
            label.numberOfLines = 1;
//            设置换行的方式
            label.lineBreakMode = NSLineBreakByCharWrapping;
//            设置对齐方式
            label.textAlignment = NSTextAlignmentLeft;
            
            label;
            
        });
    }
    return _mobileLabel;
}

- (UILabel *)verWordLabel {
    if (!_verWordLabel) {
        _verWordLabel =({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
            label.text = @"验证码";
//            设置字体颜色
            label.textColor = [UIColor blackColor];
//            设置字体和字号
            label.font = [UIFont systemFontOfSize:15];
//            设置多行显示
            label.numberOfLines = 1;
//            设置换行的方式
            label.lineBreakMode = NSLineBreakByCharWrapping;
//            设置对齐方式
            label.textAlignment = NSTextAlignmentLeft;
            
            label;
            
        });
    }
    return _verWordLabel;
}









@end
