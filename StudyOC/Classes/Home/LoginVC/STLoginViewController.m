//
//  STLoginViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/27.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLoginViewController.h"
#import "STLoginInputView.h"

#import "STRegisterViewController.h"
#import "STLoginMobileInputView.h"
#import "STFoundPassWordViewController.h"

#import "STCommonVariable.h"
#import "LCActionSheet.h"

@interface STLoginViewController ()<TYAttributedLabelDelegate,KKCommonDelegate,UITextFieldDelegate,LCActionSheetDelegate>
{
    WSProgressHUD *hud;
    NSString *niceString;
    NSString *mobileNumberStr;
    NSString *passWordString;
    NSString *verCodeString;
}
@property (strong, nonatomic) STLoginInputView *loginInputView; //  视图
@property (strong, nonatomic) STLoginMobileInputView *mobileView; //  视图
@property (nonatomic,strong) UIButton *closeButton; //  按钮

@property (assign, nonatomic) int captchaTimeout;
@property (strong, nonatomic) dispatch_source_t timer;
@property (nonatomic, copy) NSString *verCode;  //
@end

@implementation STLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle=self.barStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COlOR_EDEDED;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth(26), kHeight(59), 17, 17)];
    [closeBtn setImage:IMAGE_NAME(@"close_nav_icon") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeMethod:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn.titleLabel setFont:FONT_10];
    self.closeButton = closeBtn;
    [self.view addSubview:closeBtn];
    TYAttributedLabel *attriLabel = [[TYAttributedLabel alloc] initWithFrame:CGRectMake(0,
                                                                                        Window_H - 47 - HOME_INDICATOR_HEIGHT,
                                                                                        Window_W,
                                                                                        21)];
    [self.view addSubview:attriLabel];
    NSString *text = @"安全帮助 | 找回密码 | 切换更多";
    attriLabel.text = text;
    attriLabel.textColor = COLOR_056377;
    attriLabel.font = FONT_15;
    attriLabel.linkColor = COLOR_056377;
    attriLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    attriLabel.linesSpacing = 5;
    attriLabel.numberOfLines = 1;
    attriLabel.textAlignment = kCTTextAlignmentCenter;
    attriLabel.delegate = self;
    
    TYTextStorage *textStorage = [[TYTextStorage alloc] init];
    textStorage.range = [text rangeOfString:@"|"];
    textStorage.textColor = COLOR_HEX_RGB(0xD2D1D1);//#D2D1D1
    textStorage.font = FONT_15;
    [attriLabel addTextStorage:textStorage];
        
    TYTextStorage *textStorage1 = [[TYTextStorage alloc] init];
    textStorage1.range = NSMakeRange(12, 1);
    textStorage1.textColor =  COLOR_HEX_RGB(0xD2D1D1);
    textStorage1.font = FONT_15;
    [attriLabel addTextStorage:textStorage1];
        
    [attriLabel sizeToFit];
    [attriLabel addLinkWithLinkData:@"点击了安全帮助"
                          linkColor:COLOR_056377
                     underLineStyle:kCTUnderlineStyleNone
                              range:[text rangeOfString:@"安全帮助"]];
    
    [attriLabel addLinkWithLinkData:@"点击了找回密码"
                          linkColor:COLOR_056377
                     underLineStyle:kCTUnderlineStyleNone
                              range:[text rangeOfString:@"找回密码"]];
    
    [attriLabel addLinkWithLinkData:@"点击了切换更多"
                          linkColor:COLOR_056377
                     underLineStyle:kCTUnderlineStyleNone
                              range:[text rangeOfString:@"切换更多"]];
    
    
    BOOL isMobile = NO;
    if (isMobile) {
        _mobileView = [[STLoginMobileInputView alloc] initWithFrame:CGRectMake(0,
                                                                               MaxY(closeBtn.frame),
                                                                               Window_W,
                                                                               500)];
        _mobileView.delegate = self;
        [self.view addSubview:_mobileView];
        [_mobileView.mobileTextView addTarget:self
                                       action:@selector(textfileEditingChanged:)
                             forControlEvents:UIControlEventEditingChanged];
        [_mobileView.verWordTextView addTarget:self
                                        action:@selector(textfileEditingChanged:)
                              forControlEvents:UIControlEventEditingChanged];
        _mobileView.mobileTextView.delegate = self;
        _mobileView.verWordTextView.delegate = self;
    } else {
        _loginInputView = [[STLoginInputView alloc] initWithFrame:CGRectMake(0,
                                                                             MaxY(closeBtn.frame),
                                                                             Window_W,
                                                                             500)];
        _loginInputView.delegate = self;
        [self.view addSubview:_loginInputView];
        [_loginInputView.mobileTextView addTarget:self
                                           action:@selector(textfileEditingChanged:)
                                 forControlEvents:UIControlEventEditingChanged];
        [_loginInputView.niceTextView addTarget:self
                                         action:@selector(textfileEditingChanged:)
                               forControlEvents:UIControlEventEditingChanged];
        [_loginInputView.passWordTextView addTarget:self
                                             action:@selector(textfileEditingChanged:)
                                   forControlEvents:UIControlEventEditingChanged];
        _loginInputView.mobileTextView.delegate = self;
        _loginInputView.niceTextView.delegate = self;
        _loginInputView.passWordTextView.delegate = self;
    }
    BOOL islogin = NO ;
    if (islogin) {
        _loginInputView.titleLabelView.hidden = YES;
        _loginInputView.niceTextView.text = @"王力宏";
        _loginInputView.mobileTextView.text = @"12345678910";
        _loginInputView.headIconImageView.image = IMAGE_NAME(STSystemDefaultImageName);
    } else {
        _loginInputView.headIconImageView.hidden = YES;
    }
    
    
}
#pragma mark  -  fieldDelegate
- (void)textfileEditingChanged:(UITextField *)field {
    if (field == _loginInputView.niceTextView) {
        niceString = [self SubStringfrom:field andLength:8];
    } else if(field == _loginInputView.mobileTextView) {
        mobileNumberStr = [self SubStringfrom:field andLength:11];
    } else if (field == _loginInputView.passWordTextView){
        passWordString = [self SubStringfrom:field andLength:18];
    } else if (field == _mobileView.mobileTextView){
        mobileNumberStr = [self SubStringfrom:field andLength:11];
    } else {
        verCodeString = [self SubStringfrom:field andLength:6];
    }
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

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _mobileView.mobileTextView) {
        if (textField.text.length==11) {
            _mobileView.line1.backgroundColor = COLOR_13B900;
            _mobileView.line2.backgroundColor = COLOR_E92101;
        }
    } else if(textField == _mobileView.verWordTextView){
        if (textField.text.length == 6 && [textField.text isEqualToString:self.verCode]) {
            _mobileView.line2.backgroundColor = COLOR_13B900;
            
            if(self.captchaTimeout > 0){
                dispatch_source_cancel(self.timer);
            }
            XYWeakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mobileView.verButton setTitle:@"验证成功" forState:UIControlStateNormal];
            [weakSelf.mobileView.verButton setTitleColor:COLOR_HEX_RGB(0x707070) forState:UIControlStateNormal];
            weakSelf.mobileView.verButton.layer.borderColor = [kClearColor CGColor];
            weakSelf.mobileView.verButton.layer.borderWidth = 0;
            [weakSelf.mobileView.verButton setImage:IMAGE_NAME(@"sure_readicon") forState:UIControlStateNormal];
            [weakSelf.mobileView.verButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:5];
            });
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@\n",str);
    return YES;
}
#pragma mark  -  kkCommonDelegate
- (void)jumpBtnClicked:(id)item {
    if ([item isKindOfClass:[UIButton class]]) {
        NSInteger tag = [(UIButton *)item tag];
        if (tag == BUTTON_TAG(1)) {
            [self.loginInputView removeFromSuperview];
            _mobileView = [[STLoginMobileInputView alloc] initWithFrame:CGRectMake(0,
                                                                                   MaxY(self.closeButton.frame),
                                                                                   Window_W,
                                                                                   500)];
            _mobileView.delegate = self;
            [self.view addSubview:_mobileView];
            [_mobileView.mobileTextView addTarget:self
                                           action:@selector(textfileEditingChanged:)
                                 forControlEvents:UIControlEventEditingChanged];
            [_mobileView.verWordTextView addTarget:self
                                            action:@selector(textfileEditingChanged:)
                                  forControlEvents:UIControlEventEditingChanged];
            _mobileView.mobileTextView.delegate = self;
            _mobileView.verWordTextView.delegate = self;
        } else if (tag == BUTTON_TAG(2)){
            [self.mobileView removeFromSuperview];
            _loginInputView = [[STLoginInputView alloc] initWithFrame:CGRectMake(0,
                                                                                 MaxY(self.closeButton.frame),
                                                                                 Window_W,
                                                                                 500)];
            _loginInputView.delegate = self;
            [self.view addSubview:_loginInputView];
            [_loginInputView.mobileTextView addTarget:self
                                               action:@selector(textfileEditingChanged:)
                                     forControlEvents:UIControlEventEditingChanged];
            [_loginInputView.niceTextView addTarget:self
                                             action:@selector(textfileEditingChanged:)
                                   forControlEvents:UIControlEventEditingChanged];
            [_loginInputView.passWordTextView addTarget:self
                                                 action:@selector(textfileEditingChanged:)
                                       forControlEvents:UIControlEventEditingChanged];
            _loginInputView.mobileTextView.delegate = self;
            _loginInputView.niceTextView.delegate = self;
            _loginInputView.passWordTextView.delegate = self;
        } else if(tag == BUTTON_TAG(6)){
            //获取验证码
            UIButton *button = (UIButton *)item;
            [self.view endEditing:YES];
            if (_mobileView.mobileTextView.text.length == 0) {
                return;
            }
            NSString *message = [NSString stringWithFormat:@"我们将发送验证码短信到下面的号码：%@",mobileNumberStr];
            XYWeakSelf;
            SPAlertController *aler = [SPAlertController alertControllerWithTitle:@"确定手机号码"
                                                                          message:message
                                                                   preferredStyle:SPAlertControllerStyleAlert];
            SPAlertAction *sureAction= [SPAlertAction actionWithTitle:@"确定"
                                                                style:SPAlertActionStyleDefault
                                                              handler:^(SPAlertAction * _Nonnull action) {
                
                NSDictionary *params = @{@"type":@2,
                                         @"i":@1,
                                         @"mobile":[NSString stringWithFormat:@"+86%@",self->mobileNumberStr]};
                [[STHttpResquest sharedManager] requestWithMethod:GET
                                                         WithPath:@"/login/get_sms_captcha"
                                                       WithParams:params
                                                 WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                    NSString *msg = [[dic objectForKey:@"msg"] description];
                    NSInteger status = [[dic objectForKey:@"state"] integerValue];
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
            
        } else if (tag == BUTTON_TAG(7)){
            //账号登录
            if (![mobileNumberStr isNotBlank]) {
                return;
            }
            if (![niceString isNotBlank]) {
                return;
            }
            if (![passWordString isNotBlank]) {
                return;
            }
            NSDictionary *params = @{@"i":@1,
                                     @"login_type":@"account",
                                     @"mobile":[NSString stringWithFormat:@"+86%@",mobileNumberStr],
                                     @"username":niceString,
                                     @"password":passWordString,
                                     @"client":clientName,
            };
            //Add HUD to view
            hud = [[WSProgressHUD alloc] initWithView:self.navigationController.view];
            [self.view addSubview:hud];
            
            //show
            [hud showWithString:@"正在登录" maskType:WSProgressHUDMaskTypeBlack];
            [[STHttpResquest sharedManager] requestWithMethod:POST
                                                     WithPath:@"/login/login_submit"
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSInteger status = [[dic objectForKey:@"state"] integerValue];
                NSString *msg = [[dic objectForKey:@"msg"] description];
                if(status == 200){
                    NSDictionary *dict = [dic objectForKey:@"data"];
                    NSString *key = [dict objectForKey:@"key"];
                    [kUserDefaults setObject:key forKey:STUserRegisterInfokey];
                    [kUserDefaults setObject:dict forKey:STUserRegisterInfoDict];
                    [kUserDefaults synchronize];
                    [self->hud showWithString:@"登录成功" maskType:WSProgressHUDMaskTypeBlack];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self->hud dismiss];
                        [self.view endEditing:YES];
                        [self.navigationController popViewControllerAnimated:YES];
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                    });
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                    [self->hud dismiss];
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
                [self->hud dismiss];
            }];

        } else if (tag == BUTTON_TAG(8)){
            //手机d好登录
            if (![mobileNumberStr isNotBlank]) {
                return;
            }
            if (![verCodeString isNotBlank]) {
                return;
            }
            NSDictionary *params = @{@"i":@1,
                                     @"login_type":@"mobile",
                                     @"mobile":[NSString stringWithFormat:@"+86%@",mobileNumberStr],
                                     @"mobile_code":verCodeString,
                                     @"client":clientName,
            };
            //Add HUD to view
            hud = [[WSProgressHUD alloc] initWithView:self.navigationController.view];
            [self.view addSubview:hud];
            
            //show
            [hud showWithString:@"正在登录" maskType:WSProgressHUDMaskTypeBlack];
            [[STHttpResquest sharedManager] requestWithMethod:POST
                                                     WithPath:@"/login/login_submit"
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSString *msg = [[dic objectForKey:@"msg"] description];
                NSInteger status = [[dic objectForKey:@"state"] integerValue];
                if(status == 200){
                    NSDictionary *dict = [dic objectForKey:@"data"];
                    NSString *key = [dict objectForKey:@"key"];
                    [kUserDefaults setObject:key forKey:STUserRegisterInfokey];
                    [kUserDefaults setObject:dict forKey:STUserRegisterInfoDict];
                    [kUserDefaults synchronize];
                    [self->hud showWithString:@"登录成功" maskType:WSProgressHUDMaskTypeBlack];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self->hud dismiss];
                    });
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                    [self->hud dismiss];
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
                [self->hud dismiss];
            }];
        }
    }
}
#pragma mark  -  privateMothed
- (void)closeMethod:(UIButton *)button {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark  -  TYAttriLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point { //点击
    
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {

            if ([linkStr isEqual:@"点击了安全帮助"]) {

            }else if([linkStr isEqual:@"点击了找回密码"]){
                STFoundPassWordViewController *vc = [STFoundPassWordViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([linkStr isEqual:@"点击了切换更多"]){
                
                LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@""
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"登录其他账户", @"我要注册", @"安全帮助", nil];
                [actionSheet show];
                
            }else{
                [MBManager showBriefAlert:linkStr];
            }
        }
    }
}

#pragma mark - LCActionSheet Delegate

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %d", (int)buttonIndex);
    if (buttonIndex == 1) {//登录其他账号
        
    } else if(buttonIndex == 2){
        //我要注册
        STRegisterViewController *vc = [STRegisterViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (buttonIndex == 3){
        //安全帮助
    }
}

- (void)willPresentActionSheet:(LCActionSheet *)actionSheet {
    NSLog(@"willPresentActionSheet");
}

- (void)didPresentActionSheet:(LCActionSheet *)actionSheet {
    NSLog(@"didPresentActionSheet");
}

- (void)actionSheet:(LCActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex: %d", (int)buttonIndex);
}

- (void)actionSheet:(LCActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex: %d", (int)buttonIndex);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.loginInputView.passWordTextView resignFirstResponder];
    [self.loginInputView.niceTextView resignFirstResponder];
    [self.loginInputView.mobileTextView resignFirstResponder];
    [self.mobileView.mobileTextView resignFirstResponder];
    [self.mobileView.verWordTextView resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
@end
