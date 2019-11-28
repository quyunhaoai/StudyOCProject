//
//  STFoundPassWordViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/11.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STFoundPassWordViewController.h"

#import "STFoundpassWordHeadIconView.h"
#import "STFoundPassWordResuldView.h"
#import "XWCountryCodeController.h"
@interface STFoundPassWordViewController ()<UITextFieldDelegate,KKCommonDelegate>
{
    NSString *mobileNumberStr;
    NSString *passWordString;
    NSString *verCodeString;
    NSInteger uid;
}
@property (strong, nonatomic) UITextField *mobileTextView;   //  文本域
@property (strong, nonatomic) UITextField *passWordTextView;   //  文本域
@property (strong, nonatomic) UITextField *VerificationTextField;  //  文本框
@property (nonatomic,strong) UIButton *areaButton; //  按钮
@property (nonatomic,strong) UIButton *verButton; //  按钮

@property (strong, nonatomic) UIView *line1; //  视图
@property (strong, nonatomic) UIView *line2; //  视图
@property (strong, nonatomic) UIView *line3; //  视图
@property (strong, nonatomic) UIView *line4; //  视图
@property (nonatomic,strong) UIButton *justButton; //  按钮
@property (nonatomic,strong) UIButton *regiserButton; //  按钮

@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (strong, nonatomic) UILabel *mobileLabel; //  标签
@property (strong, nonatomic) UILabel *passWordLabel; //  标签

@property (assign, nonatomic) int captchaTimeout;
@property (strong, nonatomic) dispatch_source_t timer;

@property (strong, nonatomic) UIView *contentView; //  视图

@property (strong, nonatomic) STFoundpassWordHeadIconView *selectHeadIconView; //  视图
@property (strong, nonatomic) STFoundPassWordResuldView *resuldView; //  视图
@property (nonatomic, copy) NSString *verCode;  //
@end

@implementation STFoundPassWordViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COlOR_EDEDED;
    [self setupUI];
    self.mobileTextView.delegate = self;
    self.VerificationTextField.delegate = self;
    self.passWordTextView.delegate = self;

    [self.mobileTextView addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    [self.passWordTextView addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
    [self.VerificationTextField addTarget:self
                                   action:@selector(textFieldDidChange:)
                         forControlEvents:UIControlEventEditingChanged];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setupUI {
    [self customNavBarwithTitle:@"" andLeftView:@"找回密码"];
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            NAVIGATION_BAR_HEIGHT,
                                                            Window_W,
                                                            Window_H - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabelView];
    [self.contentView addSubview:self.passWordLabel];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.mobileTextView];
    [self.contentView addSubview:self.passWordTextView];
    [self.contentView addSubview:self.areaButton];
    [self.contentView addSubview:self.VerificationTextField];
    [self.contentView addSubview:self.verButton];
    [self.contentView addSubview:self.regiserButton];
    
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+kHeight(27));
        make.left.mas_equalTo(self.view).mas_offset(kWidth(39));
        make.size.mas_equalTo(CGSizeMake(Window_W-54, 40));
    }];
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(kWidth(31));
        make.top.mas_equalTo(self.titleLabelView.mas_bottom).mas_offset(kHeight(27));
        make.width.mas_equalTo(kWidth(80));
        make.height.mas_equalTo(25);
    }];
    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(kWidth(98));
        make.top.mas_equalTo(self.areaButton);
        make.width.mas_equalTo(kWidth(150));
        make.height.mas_equalTo(21);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = COLOR_d2d1d1;
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(kHeight(25));
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(21);
    }];
    [self.VerificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mobileTextView);
        make.top.mas_equalTo(self.mobileLabel);
        make.width.mas_equalTo(kWidth(150));
        make.height.mas_equalTo(21);
    }];
    [self.verButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.centerY.mas_equalTo(self.VerificationTextField);
        make.size.mas_equalTo(CGSizeMake(97, 26));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = COLOR_d2d1d1;
    [self.contentView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.VerificationTextField.mas_bottom).mas_offset(kHeight(17));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabelView);
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(kHeight(30));
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    [self.passWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mobileTextView);
        make.top.mas_equalTo(self.passWordLabel);
        make.right.mas_equalTo(self.view).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = COLOR_d2d1d1;
    [self.contentView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTextView.mas_bottom).mas_offset(kHeight(17));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.regiserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line4.mas_bottom).mas_offset(kHeight(29));
        make.left.mas_equalTo(self.view).mas_offset(14);
        make.width.mas_equalTo(Window_W-28);
        make.height.mas_equalTo(kHeight(45));
    }];
    self.line2 = line2;
    self.line3 = line3;
    self.line4 = line4;
    
}
#pragma mark  -  kkcommondelegate
- (void)jumpBtnClicked:(id)item {
    if ([item isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)item;
        NSInteger tag = button.tag;
        if (tag == BUTTON_TAG(5)) {//确定提交
            NSDictionary *params = @{@"i":@1,
                                     @"uid":@(uid),
            };
            XYWeakSelf;
            [[STHttpResquest sharedManager] requestWithMethod:POST
                                                     WithPath:@"/login/forget_password_step2"
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {

                NSInteger status = [[dic objectForKey:@"state"] integerValue];
                NSString *msg = [[dic objectForKey:@"msg"] description];
                if(status == 200){
                    [weakSelf.selectHeadIconView removeFromSuperview];
                    weakSelf.resuldView = [[STFoundPassWordResuldView alloc] initWithFrame:CGRectMake(0,
                                                                                                      NAVIGATION_BAR_HEIGHT,
                                                                                                      Window_W,
                                                                                                      Window_H-NAVIGATION_BAR_HEIGHT)];
                    [weakSelf.view addSubview:weakSelf.resuldView];
                }else {
                    NSDictionary *data = [dic objectForKey:@"data"];
                    if ([[data objectForKey:@"auth_error"] integerValue] == 1) {
                        [weakSelf.selectHeadIconView removeFromSuperview];
                        weakSelf.resuldView = [[STFoundPassWordResuldView alloc] initWithFrame:CGRectMake(0,
                                                                                                          NAVIGATION_BAR_HEIGHT,
                                                                                                          Window_W,
                                                                                                          Window_H-NAVIGATION_BAR_HEIGHT)];
                        [weakSelf.view addSubview:weakSelf.resuldView];
                        weakSelf.resuldView.titleLabelView.text = @"修改密码失败";
                        weakSelf.resuldView.resultImageView.image = IMAGE_NAME(@"fillFoundPasswordIcon");
                    }
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                }

            } WithFailurBlock:^(NSError * _Nonnull error) {
                
            }];

        } else {
            [button.layer setMasksToBounds:YES];
            button.selected = !button.isSelected;
            if (button.selected) {
                for (UIButton *btn in self.selectHeadIconView.headBtnArray) {
                    if ([button isEqual:btn]) {
                        button.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f
                                                                    green:159.0f/255.0f
                                                                     blue:16.0f/255.0f
                                                                    alpha:1.0f] CGColor];
                        button.layer.borderWidth = 1;
                        [_selectHeadIconView.sureModifyButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
                        [_selectHeadIconView.sureModifyButton setBackgroundColor:COLOR_HEX_RGB(0xe1451f)];
                        uid = tag;
                    } else {
                        btn.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f
                                                                 green:159.0f/255.0f
                                                                  blue:16.0f/255.0f
                                                                 alpha:1.0f] CGColor];
                        btn.layer.borderWidth = 0;
                        btn.selected = NO;
                    }
                }
            } else {
                button.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f
                                                            green:159.0f/255.0f
                                                             blue:16.0f/255.0f
                                                            alpha:1.0f] CGColor];
                button.layer.borderWidth = 0;
                [_selectHeadIconView.sureModifyButton setTitleColor:COLOR_HEX_RGB(0xbdbdbd) forState:UIControlStateNormal];
                [_selectHeadIconView.sureModifyButton setBackgroundColor:COLOR_HEX_RGB(0xe2e2e2)];
            }
        }
    }
}
#pragma mark  -  event priate
- (void)btnClicked:(UIButton *)button {
    NSInteger tag = [button tag];
    if (tag == BUTTON_TAG(9)) {
        //地区编码
            XWCountryCodeController *countryCodeVC = [[XWCountryCodeController alloc] init];
            __weak __typeof(self)weakSelf = self;
            countryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf->_areaButton setTitle:[NSString stringWithFormat:@"+%@",code] forState:UIControlStateNormal];
            };
            [self.navigationController pushViewController:countryCodeVC animated:YES];
        
    } else if (tag == BUTTON_TAG(5)){
        //修改密码
        if (![mobileNumberStr isNotBlank]) {
            return;
        }
        if (![verCodeString isNotBlank]) {
            return;
        }
        if (![passWordString isNotBlank]) {
            return;
        }
        NSDictionary *params = @{@"i":@1,
                                 @"mobile":[NSString stringWithFormat:@"+86%@",mobileNumberStr],
                                 @"mobile_code":verCodeString,
                                 @"password":passWordString,
                                 @"client":clientName,
                                 @"forget_type":@"mobile",
        };
        XYWeakSelf;
        [[STHttpResquest sharedManager] requestWithMethod:POST
                                                 WithPath:@"/login/forget_password_step1"
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
               NSDictionary *dataDict = [dic objectForKey:@"data"];
               NSArray *arr = [dataDict objectForKey:@"randomimg"];
           
               [weakSelf.contentView removeFromSuperview];
               weakSelf.selectHeadIconView = [[STFoundpassWordHeadIconView alloc] initWithFrame:CGRectMake(0,
                                                                                                           NAVIGATION_BAR_HEIGHT,
                                                                                                           Window_W,
                                                                                                           Window_H - NAVIGATION_BAR_HEIGHT)];
               weakSelf.selectHeadIconView.delegate = self;
                for (int i = 0; i<arr.count; i++) {
                    UIButton *button = weakSelf.selectHeadIconView.headBtnArray[i];
                    UIImageView *imageView = weakSelf.selectHeadIconView.headIconArray[i];
                    NSDictionary *dict = arr[i];
                    NSString *imageStr = [dict objectForKey:@"image"];
                    NSString *uid = [dict objectForKey:@"uid"];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
                    [button setTag:[uid integerValue]];
                }
                [weakSelf.view addSubview:weakSelf.selectHeadIconView];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else if (tag == BUTTON_TAG(3)){
        //验证码
        [self.view endEditing:YES];
        
        if (self.mobileTextView.text.length == 0) {
            return;
        }
        NSString *message = [NSString stringWithFormat:@"我们将发送验证码短信到下面的号码：%@%@",self.areaButton.titleLabel.text,mobileNumberStr];
        XYWeakSelf;
        SPAlertController *aler = [SPAlertController alertControllerWithTitle:@"确定手机号码"
                                                                      message:message
                                                               preferredStyle:SPAlertControllerStyleAlert];
        SPAlertAction *sureAction= [SPAlertAction actionWithTitle:@"确定" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                NSDictionary *params = @{@"type":@3,
                                            @"i":@1,
                                       @"mobile":[NSString stringWithFormat:@"+86%@",self->mobileNumberStr]};
                [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/login/get_sms_captcha" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                    

                    NSInteger status = [[dic objectForKey:@"state"] integerValue];
                    NSString *msg = [[dic objectForKey:@"msg"] description];
                    if(status == 200){
                       NSDictionary *data = [dic objectForKey:@"data"];
                       weakSelf.verCode = [data objectForKey:@"captcha"];
                       if(weakSelf.captchaTimeout>0) return;
                       weakSelf.captchaTimeout = 60;
                       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                       weakSelf.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                       dispatch_source_set_timer(weakSelf.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
                           dispatch_source_set_event_handler(weakSelf.timer, ^{
                               if(weakSelf.captchaTimeout <= 0)
                               {
                                   dispatch_source_cancel(weakSelf.timer);
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       button.enabled = YES;
                                       [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                                       [button setTitleColor:kBlackColor forState:UIControlStateNormal];
                                       button.layer.borderColor = [[UIColor colorWithRed:112.0f/255.0f
                                                                                   green:112.0f/255.0f
                                                                                    blue:112.0f/255.0f
                                                                                   alpha:1.0f] CGColor];
                                       button.layer.borderWidth = 1;
                                   });
                               }
                               else
                               {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       button.enabled = NO;
                                       NSString *strTime = [NSString stringWithFormat:@"%.2d秒后重试",weakSelf.captchaTimeout];
                                       [button setTitleColor:COLOR_HEX_RGB(0x707070) forState:UIControlStateNormal];
                                        button.layer.borderColor = [kClearColor CGColor];
                                        button.layer.borderWidth = 0;
                                       [button setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                                       weakSelf.captchaTimeout--;
                                   });
                               }
                           });
                       dispatch_resume(weakSelf.timer);
                    }else {
                        if (msg.length>0) {
                            [MBManager showBriefAlert:msg];
                        }
                    }
                } WithFailurBlock:^(NSError * _Nonnull error) {
    
                }];
        }];
        SPAlertAction *cacelAction = [SPAlertAction actionWithTitle:@"取消"
                                                              style:SPAlertActionStyleCancel
                                                            handler:^(SPAlertAction * _Nonnull action) {
            
        }];
        sureAction.titleColor = COLOR_HEX_RGB(0x2a5d8f);
        aler.messageColor = kBlackColor;
        [aler addAction:cacelAction];
        [aler addAction:sureAction];

        [self presentViewController:aler animated:YES completion:nil];

    }
}

#pragma mark  -  textfiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;
}
- (NSString *)SubStringfrom:(UITextField *)textField andLength:(NSUInteger )length {
    NSString *str1 =   [self getSubString:textField.text AndLength:length];
    textField.text = str1;
    return textField.text;
}

/**
 判断输入的是不是数字
 */
- (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/**
 *  限制字符长度的
 */
-(NSString *)getSubString:(NSString*)string AndLength:(NSInteger)length
{
    if (string.length > length) {
        return [string substringToIndex:length];
    }else {
        return string;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.mobileTextView) {
        if (textField.text.length == 11) {
            self.line2.backgroundColor = COLOR_13B900;
            self.line3.backgroundColor = COLOR_E92101;
        } else {
            self.line2.backgroundColor = COLOR_E92101;
        }
    } else if (textField == self.VerificationTextField) {
        if (textField.text.length == 6&&[textField.text isEqualToString:self.verCode]) {
            self.line3.backgroundColor = COLOR_13B900;
            self.line4.backgroundColor = COLOR_E92101;
            

            if(self.captchaTimeout > 0){
                dispatch_source_cancel(self.timer);
            }
            XYWeakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.verButton setTitle:@"验证成功" forState:UIControlStateNormal];
                [weakSelf.verButton setTitleColor:COLOR_HEX_RGB(0x707070) forState:UIControlStateNormal];
                weakSelf.verButton.layer.borderColor = [kClearColor CGColor];
                weakSelf.verButton.layer.borderWidth = 0;
                [weakSelf.verButton setImage:IMAGE_NAME(@"sure_readicon") forState:UIControlStateNormal];
                [weakSelf.verButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:5];
            });
        }
    } else if (textField == self.passWordTextView) {
        if (textField.text.length > 0) {
            self.line4.backgroundColor = COLOR_13B900;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
        if (textField == self.mobileTextView) {
            mobileNumberStr = [self SubStringfrom:textField andLength:11];
        } else if (textField == self.VerificationTextField) {
            verCodeString = [self SubStringfrom:textField andLength:6];
        } else if (textField == self.passWordTextView) {
            passWordString = [self SubStringfrom:textField andLength:18];
        }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.mobileTextView) {
        
    } else if (textField == self.VerificationTextField) {

    }
    return YES;
}
#pragma mark  -  get

- (UIButton *)regiserButton {
    if (!_regiserButton) {
        _regiserButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_E1451F];
            [btn setTag:BUTTON_TAG(5)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"修改密码" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
            
        });
    }
    return _regiserButton;
}

- (UIButton *)verButton {
    if (!_verButton) {
        _verButton =({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(3)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 3;
            btn.layer.borderColor = [[UIColor colorWithRed:112.0f/255.0f
                                                     green:112.0f/255.0f
                                                      blue:112.0f/255.0f
                                                     alpha:1.0f] CGColor];
            btn.layer.borderWidth = 1;
            btn.layer.backgroundColor = [[UIColor colorWithRed:237.0f/255.0f
                                                         green:237.0f/255.0f
                                                          blue:237.0f/255.0f
                                                         alpha:1.0f] CGColor];
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
            [btn setTitle:@"+86" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(9)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight imageTitlePadding:20];
            btn ;
            
        });
    }
    return _areaButton;
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
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"请使用手机号短信验证，从新设置密码";

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
               textfield.placeholder = @"请填写新密码";
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

#pragma mark  -  event priate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mobileTextView resignFirstResponder];
    [self.passWordTextView resignFirstResponder];
    [self.VerificationTextField resignFirstResponder];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
