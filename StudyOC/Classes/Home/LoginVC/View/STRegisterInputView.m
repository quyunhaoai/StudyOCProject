//
//  STRegisterInputView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRegisterInputView.h"
@interface STRegisterInputView()
@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (strong, nonatomic) UILabel *niceLabel; //  标签
@property (strong, nonatomic) UILabel *mobileLabel; //  标签
@property (strong, nonatomic) UILabel *passWordLabel; //  标签
//@property (strong, nonatomic) UILabel *verificationLabel; //  标签




@end
@implementation STRegisterInputView

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
    [self addSubview:self.headPortraitImageView];
    [self addSubview:self.headPortraitLabel];
    [self addSubview:self.areaButton];
    [self addSubview:self.VerificationTextField];
//    [self addSubview:self.verificationLabel];
    [self addSubview:self.verButton];
    [self addSubview:self.justButton];
    [self addSubview:self.regiserButton];
    [self addSubview:self.agreeLabel];
    
    
    
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(27);
        make.size.mas_equalTo(CGSizeMake(kWidth(200), 40));
    }];
    [self.niceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.titleLabelView.mas_bottom).mas_offset(kHeight(19));
        make.size.mas_equalTo(CGSizeMake(30, 21));
    }];
    
    [self.niceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(78));
        make.top.mas_equalTo(self.niceLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.niceTextView.mas_bottom).mas_offset(kHeight(12));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    
    [self.headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.niceLabel);
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(18);
        make.height.mas_equalTo(kWidth(52));
        make.width.mas_equalTo(_headPortraitImageView.mas_height);
    }];
    
    [self.headPortraitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headPortraitImageView);
        make.left.mas_equalTo(self.headPortraitImageView.mas_right).mas_offset(kWidth(14));
        make.size.mas_equalTo(CGSizeMake(kWidth(175), 21));
    }];
    
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(self.headPortraitImageView.mas_bottom).mas_offset(kHeight(27));
        make.width.mas_equalTo(kWidth(80));
        make.height.mas_equalTo(25);
    }];
    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headPortraitLabel);
        make.top.mas_equalTo(self.areaButton);
        make.width.mas_equalTo(kWidth(150));
        make.height.mas_equalTo(21);
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
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(kHeight(25));
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(21);
    }];
    [self.VerificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headPortraitLabel);
        make.top.mas_equalTo(self.mobileLabel);
        make.width.mas_equalTo(kWidth(150));
        make.height.mas_equalTo(21);
    }];
    [self.verButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-25);
        make.centerY.mas_equalTo(self.VerificationTextField);
        make.size.mas_equalTo(CGSizeMake(97, 26));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.VerificationTextField.mas_bottom).mas_offset(kHeight(17));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.passWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headPortraitLabel);
        make.top.mas_equalTo(self.passWordLabel);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTextView.mas_bottom).mas_offset(kHeight(17));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    
    [self.justButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line4.mas_bottom).mas_offset(kHeight(22));
        make.left.mas_equalTo(self.niceLabel.mas_right).mas_offset(-kWidth(0));
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.regiserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.justButton.mas_bottom).mas_offset(kHeight(15));
        make.left.mas_equalTo(self).mas_offset(14);
        make.width.mas_equalTo(Window_W-28);
        make.height.mas_equalTo(kHeight(45));
    }];
    
    [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.justButton);
        make.left.mas_equalTo(self.justButton.mas_right).mas_offset(8);
        make.height.mas_equalTo(kHeight(21));
        make.right.mas_equalTo(self);
    }];
    self.line1 = line1;
    self.line2 = line2;
    self.line3 = line3;
    self.line4 = line4;
}

#pragma mark  -  get

- (TYAttributedLabel *)agreeLabel {
    
    if (!_agreeLabel) {
        _agreeLabel =({
            
            TYAttributedLabel *view = [TYAttributedLabel new];
            view.textColor = kBlackColor;
            view.font = FONT_15;
            view.numberOfLines = 1 ;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.textAlignment = NSTextAlignmentLeft;
            view.backgroundColor = [UIColor clearColor];
            view.text = @"已阅读并同意《优趣城用户服务协议》";
            
            TYTextStorage *textStorage2 = [[TYTextStorage alloc] init];
            textStorage2.range = [view.text rangeOfString:@"《优趣城用户服务协议》"];
            textStorage2.textColor = COLOR_HEX_RGB(0x2a5d8f);//#D2D1D1
            textStorage2.font = FONT_15;
            [view addTextStorage:textStorage2];
            
            view ;
            
        });
    }
    return _agreeLabel;
}

- (UIButton *)regiserButton {
    if (!_regiserButton) {
        _regiserButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_HEX_RGB(0xbdbdbd) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_HEX_RGB(0xe2e2e2)];
            [btn setTag:BUTTON_TAG(5)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"提交注册信息" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn.enabled = NO;
            btn ;
            
        });
    }
    return _regiserButton;
}

- (UIButton *)justButton {
    if (!_justButton) {
        _justButton =({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitleColor:COLOR_HEX_RGB(0x2a5d8f) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setImage:IMAGE_NAME(@"rectangleEmpty") forState:UIControlStateNormal];
//            [btn setBackgroundColor:[UIColor clearColor]];
//            [btn setTitle:@"使用手机短信验证登录" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(4)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn ;
            
        });
    }
    return _justButton;
}

- (UIButton *)verButton {
    if (!_verButton) {
        _verButton =({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
//            [btn setImage:IMAGE_NAME(@"areaButtonImage") forState:UIControlStateNormal];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(3)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:10];
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
- (UIButton *)areaButton{
    if (!_areaButton) {
        _areaButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setImage:IMAGE_NAME(@"areaButtonImage") forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(9)];
            [btn setTitle:@"+86" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight imageTitlePadding:20];
            btn ;
            
        });
    }
    return _areaButton;
}
- (void)btnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
-(UIImageView *)headPortraitImageView {
    if (!_headPortraitImageView) {
        _headPortraitImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"headPortraitImageView"];
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES;
//            [view addTapGestureWithTarget:self action:@selector(btnClicked:)];
            view ;
        });
    }
    return _headPortraitImageView;
}

- (UILabel *)headPortraitLabel {
    if (!_headPortraitLabel) {
        _headPortraitLabel = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                    label.backgroundColor = [UIColor clearColor];
        //            设置显示的内容
                    label.text = @"请上传头像";
        //            设置字体颜色
                    label.textColor = COLOR_HEX_RGB(0xbbbbbb);
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
    return _headPortraitLabel;
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
    return _mobileLabel;
}

- (UILabel *)passWordLabel {
    if (!_passWordLabel) {
        _passWordLabel =({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
            label.text = @"密码";
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
- (UILabel *)titleLabelView {
    if (!_titleLabelView) {
        _titleLabelView = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:28];
            label.text = @"账号注册";

            label;
        });
    }
    return _titleLabelView;
}

- (UITextField *)VerificationTextField {
    if (!_VerificationTextField) {
        _VerificationTextField = ({
            
            UITextField *textfield = [[UITextField alloc] init];
                      //设置边框
                      textfield.borderStyle = UITextBorderStyleNone;
                      //设置水印提示
                      textfield.placeholder = @"请填写验证码";
                      textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
                      //设置输入框右边的一键删除（x号）
                      textfield.clearButtonMode = 0;
                      //设置密码安全样式
                      textfield.secureTextEntry = NO;
                      //设置键盘样式
                      textfield.keyboardType = UIKeyboardTypeNumberPad;
                      textfield.backgroundColor = kClearColor;
                      //设置输入的字体大小
                      textfield.font = [UIFont systemFontOfSize:15];

                      textfield;
        });
    }
    return _VerificationTextField;
}
- (UITextField *)niceTextView {
    if (!_niceTextView) {
        _niceTextView = ({
            UITextField *textfield = [[UITextField alloc] init];
            //设置边框
            textfield.borderStyle = UITextBorderStyleNone;
            //设置水印提示
            textfield.placeholder = @"例如：陈奕含";
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
                   textfield.placeholder = @"请填写手机号";
                   textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
                   //设置输入框右边的一键删除（x号）
                   textfield.clearButtonMode = 0;
                   //设置密码安全样式
                   textfield.secureTextEntry = NO;
                   //设置键盘样式
                   textfield.keyboardType = UIKeyboardTypeNumberPad;
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
               textfield.placeholder = @"设置账号登录密码";
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















@end
