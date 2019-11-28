//
//  STLoginInputView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLoginInputView.h"
@interface STLoginInputView ()

@property (strong, nonatomic) UILabel *niceLabel; //  标签
@property (strong, nonatomic) UILabel *mobileLabel; //  标签
@property (strong, nonatomic) UILabel *passWordLabel; //  标签

@property (nonatomic,strong) KKButton *justButton; //  按钮
@property (nonatomic,strong) UIButton *loginButton; //  按钮
@end


@implementation STLoginInputView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.titleLabelView];
    [self addSubview:self.niceLabel];
    [self addSubview:self.passWordLabel];
    [self addSubview:self.mobileLabel];
    [self addSubview:self.niceTextView];
    [self addSubview:self.mobileTextView];
    [self addSubview:self.passWordTextView];
    [self addSubview:self.justButton];
    [self addSubview:self.loginButton];
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kHeight(72));
        make.left.mas_equalTo(self).mas_offset(27);
        make.size.mas_equalTo(CGSizeMake(kWidth(200), 40));
    }];
    [self.niceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.titleLabelView.mas_bottom).mas_offset(kHeight(37));
        make.size.mas_equalTo(CGSizeMake(30, 21));
    }];
    [self.niceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(101));
        make.top.mas_equalTo(self.niceLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.niceLabel.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(101));
        make.top.mas_equalTo(self.mobileLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.mobileLabel.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.passWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(101));
        make.top.mas_equalTo(self.passWordLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.niceTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    
    [self.justButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(kHeight(19));
        make.left.mas_equalTo(self.niceLabel.mas_left).mas_offset(-kWidth(2));
        make.size.mas_equalTo(CGSizeMake(Window_W-50, 21));
    }];
    [self.justButton layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitleSpace:0];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.justButton.mas_bottom).mas_offset(kHeight(30));
        make.left.mas_equalTo(self).mas_offset(14);
        make.width.mas_equalTo(Window_W-28);
        make.height.mas_equalTo(kHeight(45));
    }];
    
    [self addSubview:self.headIconImageView];
    [self.headIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(kHeight(37));
        make.width.mas_equalTo(kWidth(82));
        make.height.mas_equalTo(_headIconImageView.mas_width);
    }];
}

#pragma mark  -  get
- (UIImageView *)headIconImageView {
    if (!_headIconImageView) {
        _headIconImageView =({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"headPortraitImageView"];
            view.layer.masksToBounds = YES ;
            view.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:159.0f/255.0f blue:16.0f/255.0f alpha:1.0f] CGColor];
            view.layer.borderWidth = 1;
            view.hidden = YES;
            view ;
            
        });
    }
    return _headIconImageView;
    
}

                             
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_HEX_RGB(0xe1451f)];
            [btn setTag:BUTTON_TAG(7)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
            
        });
    }
    return _loginButton;
}

- (KKButton *)justButton {
    if (!_justButton) {
        _justButton =({
            KKButton *btn = [KKButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_HEX_RGB(0x2a5d8f) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"使用手机短信验证登录" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(1)];
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
            label.text = @"账号登录";

            label;
        });
    }
    return _titleLabelView;
}
            //
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"账号登录"];
//            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Segoe UI" size:14.0f] range:NSMakeRange(0, 4)];
//            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
- (UITextField *)niceTextView {
    if (!_niceTextView) {
        _niceTextView = ({
            UITextField *textfield = [[UITextField alloc] init];
            //设置边框
            textfield.borderStyle = UITextBorderStyleNone;
            //设置水印提示
            textfield.placeholder = @"所注册的昵称";
            textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
            //设置输入框右边的一键删除（x号）
            textfield.clearButtonMode = 0;
            //设置密码安全样式
            textfield.secureTextEntry = NO;
            //设置键盘样式
            textfield.keyboardType = 0 ;
            textfield.backgroundColor = kClearColor;
            //设置输入的字体大小
            textfield.font = [UIFont systemFontOfSize:15];

            textfield;
        });
    }
    return _niceTextView;
}

- (UITextField *)mobileTextView {
    if (!_mobileTextView) {
        _mobileTextView =  ({
                   UITextField *textfield = [[UITextField alloc] init];
                   //设置边框
                   textfield.borderStyle = UITextBorderStyleNone;
                   //设置水印提示
                   textfield.placeholder = @"所注册的手机号";
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

- (UITextField *)passWordTextView {
    if (!_passWordTextView) {
        _passWordTextView = ({
               UITextField *textfield = [[UITextField alloc] init];
               //设置边框
               textfield.borderStyle = UITextBorderStyleNone;
               //设置水印提示
               textfield.placeholder = @"账号登录密码";
               textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
               //设置输入框右边的一键删除（x号）
               textfield.clearButtonMode = UITextFieldViewModeAlways;
               //设置密码安全样式
               textfield.secureTextEntry = YES;
               //设置键盘样式
               textfield.keyboardType = 0;
                
               textfield.backgroundColor = kClearColor;
               //设置输入的字体大小
               textfield.font = [UIFont systemFontOfSize:15];

               textfield;
           });
    }
    return _passWordTextView;
}

- (UILabel *)niceLabel {
    if (!_niceLabel) {
        _niceLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
            label.text = @"昵称";
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
    return _niceLabel;
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

- (UILabel *)passWordLabel {
    if (!_passWordLabel) {
        _passWordLabel =({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
            label.text = @"登录密码";
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
    return _passWordLabel;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}




@end
