//
//  STRegisterViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRegisterViewController.h"

#import "STRegisterInputView.h"
#import "STFoundPassWordViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"

#import "XWCountryCode/XWCountryCodeController.h"
#import "LCActionSheet.h"

#import "STKWWebViewController.h"
@interface STRegisterViewController ()<TYAttributedLabelDelegate,UITextFieldDelegate,KKCommonDelegate,STPhotoKitDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,XWCountryCodeControllerDelegate,LCActionSheetDelegate>
{
    NSString *niceString;
    NSString *mobileNumberStr;
    NSString *passWordString;
    NSString *verCodeString;
    
    NSString *fileUrl;
    WSProgressHUD *hud;
}
@property (strong, nonatomic) STRegisterInputView *registerInputView; //  视图
@property (assign, nonatomic) int captchaTimeout;
@property (strong, nonatomic) dispatch_source_t timer;

@property (assign, nonatomic) BOOL isUploadHeadIcon;
@property (nonatomic, strong) NSString *verCode;
@end

@implementation STRegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = COlOR_EDEDED;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth(26), kHeight(59), 17, 17)];
    [closeBtn setImage:IMAGE_NAME(@"close_nav_icon") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeMethod:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn.titleLabel setFont:FONT_10];
    [self.view addSubview:closeBtn];

    TYAttributedLabel *attriLabel = [[TYAttributedLabel alloc] initWithFrame:CGRectMake((Window_W-kWidth(224))/2,
                                                                                        Window_H - 47 - HOME_INDICATOR_HEIGHT,
                                                                                        kWidth(224),
                                                                                        21)];
    [self.view addSubview:attriLabel];
    NSString *text = @"安全帮助| 找回密码 | 切换更多";
    attriLabel.text = text;
    attriLabel.textColor = COLOR_056377;
    attriLabel.font = FONT_15;
    attriLabel.linkColor = COLOR_056377;
    attriLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    attriLabel.linesSpacing = 5;
    attriLabel.numberOfLines = 1;
    attriLabel.textAlignment = NSTextAlignmentCenter;
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
    _registerInputView = [[STRegisterInputView alloc] initWithFrame:CGRectMake(0,
                                                                               MaxY(closeBtn.frame)+37,
                                                                               Window_W,
                                                                               500)];
    [self.view addSubview:_registerInputView];
    _registerInputView.delegate = self;
    _registerInputView.agreeLabel.delegate = self;
    _registerInputView.niceTextView.delegate = self;
    _registerInputView.mobileTextView.delegate =self;
    _registerInputView.passWordTextView.delegate = self;
    _registerInputView.VerificationTextField.delegate = self;
    [_registerInputView.niceTextView addTarget:self
                                        action:@selector(textFieldDidChange:)
                              forControlEvents:UIControlEventEditingChanged];
    [_registerInputView.mobileTextView addTarget:self
                                          action:@selector(textFieldDidChange:)
                                forControlEvents:UIControlEventEditingChanged];
    [_registerInputView.passWordTextView addTarget:self
                                            action:@selector(textFieldDidChange:)
                                  forControlEvents:UIControlEventEditingChanged];
    [_registerInputView.VerificationTextField addTarget:self
                                                 action:@selector(textFieldDidChange:)
                                       forControlEvents:UIControlEventEditingChanged];
    [_registerInputView.agreeLabel addLinkWithLinkData:@"点击了《优趣城用户服务协议》"
                                             linkColor:COLOR_056377
                                        underLineStyle:kCTUnderlineStyleNone
                                                 range:NSMakeRange(6, 11)];
 
    [_registerInputView.headPortraitImageView addTapGestureWithTarget:self
                                                               action:@selector(uploadHeadIcon)];
}

- (void)uploadHeadIcon {
    [self editImageSelected];
}
#pragma mark - XWCountryCodeControllerDelegate
- (void)returnCountryName:(NSString *)countryName code:(NSString *)code {
//    showCodeLB.text = [NSString stringWithFormat:@"%@",code];
    [self.registerInputView.areaButton setTitle:[NSString stringWithFormat:@"+%@",code] forState:UIControlStateNormal];
}
#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    NSLog(@"image:%@",resultImage);
    self.registerInputView.headPortraitImageView.image = resultImage;
    self.registerInputView.headPortraitImageView.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f
                                                                                      green:159.0f/255.0f
                                                                                       blue:16.0f/255.0f
                                                                                      alpha:1.0f] CGColor];
    self.registerInputView.headPortraitImageView.layer.borderWidth = 1;
    self.isUploadHeadIcon = YES;
    _registerInputView.headPortraitLabel.text = @"头像上传成功";
}

#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];

        [photoVC setSizeClip:CGSizeMake(self.registerInputView.headPortraitImageView.width*3,
                                        self.registerInputView.headPortraitImageView.height*3)];

        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - --- event response 事件相应 ---
- (void)editImageSelected
{
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@""
                                             cancelButtonTitle:@"取消"
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {

        NSLog(@"clickedButtonAtIndex: %d", (int)buttonIndex);
        if (buttonIndex == 1) {
            UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];

            if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
                [controller setDelegate:self];
                [self presentViewController:controller animated:YES completion:nil];
            }else {
                NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
            }
        } else if(buttonIndex == 2){
            UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [controller setDelegate:self];
            if ([controller isAvailablePhotoLibrary]) {
                [self presentViewController:controller animated:YES completion:nil];
            }
        }

    } otherButtonTitles:@"拍照", @"从相册获取", nil];
    [actionSheet show];
}
- (void)closeMethod:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark  -  kkCommonDelegate

- (void)jumpBtnClicked:(id)item {
    if ([item isKindOfClass:[UIButton class]]) {
        NSInteger tag = [(UIButton *)item tag];
        if (tag == BUTTON_TAG(3)) {
            UIButton *button = (UIButton *)item;
            //获取验证码。。。
            [self.view endEditing:YES];
            
            if (_registerInputView.mobileTextView.text.length == 0) {
//                [MBManager showBriefAlert:@"请输入手机号"];
                return;
            }
            NSString *message = [NSString stringWithFormat:@"我们将发送验证码短信到下面的号码：%@%@",_registerInputView.areaButton.titleLabel.text,mobileNumberStr];
            XYWeakSelf;
            SPAlertController *aler = [SPAlertController alertControllerWithTitle:@"确定手机号码"
                                                                          message:message
                                                                   preferredStyle:SPAlertControllerStyleAlert];
            SPAlertAction *sureAction= [SPAlertAction actionWithTitle:@"确定"
                                                                style:SPAlertActionStyleDefault
                                                              handler:^(SPAlertAction * _Nonnull action) {
                NSDictionary *params = @{@"type":@1,
                                            @"i":@1,
                                        @"mobile":[NSString stringWithFormat:@"+86%@",self->mobileNumberStr]};
                    [[STHttpResquest sharedManager] requestWithMethod:GET
                                                             WithPath:@"/login/get_sms_captcha"
                                                           WithParams:params
                                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {

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
                                            button.layer.borderColor = [[UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] CGColor];
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

        } else if (tag == BUTTON_TAG(4)){//同意协议
            if (![niceString isNotBlank]) {
                return;
            }
            if (![mobileNumberStr isNotBlank]) {
                return;
            }
            if (![verCodeString isNotBlank]) {
                return;
            }
            if (![passWordString isNotBlank]) {
                return;
            }
            UIButton *button = (UIButton *)item;
            [button setSelected:!button.isSelected];
            if (button.isSelected) {
                [_registerInputView.justButton setImage:IMAGE_NAME(@"selectionRRRImage") forState:UIControlStateNormal];
                [_registerInputView.regiserButton setBackgroundColor:COLOR_HEX_RGB(0xE1451F)];
                [_registerInputView.regiserButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
                [_registerInputView.regiserButton setEnabled:YES];
            } else {
                [_registerInputView.justButton setImage:IMAGE_NAME(@"deselectionRRRImage") forState:UIControlStateNormal];
                [_registerInputView.regiserButton setBackgroundColor:COLOR_HEX_RGB(0xe2e2e2)];
                [_registerInputView.regiserButton setTitleColor:COLOR_HEX_RGB(0xbdbdbd) forState:UIControlStateNormal];
                [_registerInputView.regiserButton setEnabled:NO];
            }
        } else if (tag == BUTTON_TAG(5)){//提交注册信息
            hud = [[WSProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:hud];

            //show
            [hud showWithString:@"正在注册" maskType:WSProgressHUDMaskTypeBlack];
            [[STHttpResquest sharedManager] POST:@"/front.php/login/update_headimg_api"
                                      parameters:@{@"i":@1}
                       constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *data = UIImagePNGRepresentation(self.registerInputView.headPortraitImageView.image);
                //上传的参数(上传图片，以文件流的格式
                [formData appendPartWithFileData:data
                                             name:@"files"
                                         fileName:@"gauge.png"
                                         mimeType:@"image/png"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"resp:%@",responseObject);
            
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                NSString *url = [dict objectForKey:@"file_url"];
                [self registerActions:url];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error:%@",error.description);
            }];
        } else if (tag == BUTTON_TAG(9)){//国家代码选择
            XWCountryCodeController *countryCodeVC = [[XWCountryCodeController alloc] init];
            countryCodeVC.deleagete = self;
            [self.navigationController pushViewController:countryCodeVC animated:YES];
        }
    }
    
}
             
- (void)registerActions:(NSString *)filePath {
    if (![niceString isNotBlank]) {
        return;
    }
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
                             @"nickname":niceString,
                             @"mobile":[NSString stringWithFormat:@"%@%@",self.registerInputView.areaButton.titleLabel.text,mobileNumberStr],
                             @"mobile_code":verCodeString,
                             @"password":passWordString,
                             @"client":client,
                             @"headimg":filePath
    };
    [[STHttpResquest sharedManager] requestWithMethod:POST
                                             WithPath:@"/login/register"
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
            [self->hud showWithString:@"注册成功" maskType:WSProgressHUDMaskTypeBlack];
            [self->hud dismiss];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        [self->hud dismiss];
    }];
}
#pragma mark  -  textfiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _registerInputView.mobileTextView) {
        if (!self.isUploadHeadIcon) {
            SPAlertController *aler = [SPAlertController alertControllerWithTitle:@""
                                                                          message:@"请上传头像成功后在填写手机号"
                                                                   preferredStyle:SPAlertControllerStyleAlert];
            aler.messageFont = FONT_12;
            aler.messageColor = kBlackColor;
            SPAlertAction *sure = [SPAlertAction actionWithTitle:@"确定"
                                                           style:SPAlertActionStyleDefault
                                                         handler:^(SPAlertAction * _Nonnull action) {
                
            }];
            sure.titleColor = COLOR_HEX_RGB(0x2a5d8f);
            sure.titleFont = [UIFont systemFontOfSize:17];
            [aler addAction:sure];
            [self presentViewController:aler animated:YES completion:^{
                
            }];
            return NO;
        }
    }
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
    if (textField == _registerInputView.mobileTextView) {
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _registerInputView.niceTextView) {
        if (textField.text.length > 0) {
            _registerInputView.line1.backgroundColor = COLOR_13B900;
        }else if (textField.text.length == 0){
             _registerInputView.line1.backgroundColor = COLOR_d2d1d1;
        }
    } else if (textField == _registerInputView.mobileTextView) {
        if (textField.text.length == 11) {
            _registerInputView.line2.backgroundColor = COLOR_13B900;
            _registerInputView.line3.backgroundColor = COLOR_E92101;
        } else {
            _registerInputView.line2.backgroundColor = COLOR_E92101;
        }
    } else if (textField == _registerInputView.VerificationTextField) {
        if (textField.text.length == 6 && [textField.text isEqualToString:self.verCode]) {
            _registerInputView.line3.backgroundColor = COLOR_13B900;
            _registerInputView.line4.backgroundColor = COLOR_E92101;
            

            if(self.captchaTimeout > 0){
                dispatch_source_cancel(self.timer);
            }
            XYWeakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.registerInputView.verButton setTitle:@"验证成功" forState:UIControlStateNormal];
                [weakSelf.registerInputView.verButton setTitleColor:COLOR_HEX_RGB(0x707070) forState:UIControlStateNormal];
                weakSelf.registerInputView.verButton.layer.borderColor = [kClearColor CGColor];
                weakSelf.registerInputView.verButton.layer.borderWidth = 0;
                [weakSelf.registerInputView.verButton setImage:IMAGE_NAME(@"sure_readicon") forState:UIControlStateNormal];
                [weakSelf.registerInputView.verButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:5];
            });
        }
    } else if (textField == _registerInputView.passWordTextView) {
        if (textField.text.length > 0) {
            _registerInputView.line4.backgroundColor = COLOR_13B900;
            [_registerInputView.justButton setImage:IMAGE_NAME(@"deselectionRRRImage") forState:UIControlStateNormal];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _registerInputView.niceTextView) {
        niceString = [self SubStringfrom:textField andLength:8];
    } else if (textField == _registerInputView.mobileTextView) {
        mobileNumberStr = [self SubStringfrom:textField andLength:11];
    } else if (textField == _registerInputView.VerificationTextField) {
        verCodeString = [self SubStringfrom:textField andLength:6];
    } else if (textField == _registerInputView.passWordTextView) {
        passWordString = [self SubStringfrom:textField andLength:18];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _registerInputView.niceTextView) {

    } else if (textField == _registerInputView.mobileTextView) {

    } else if (textField == _registerInputView.VerificationTextField) {

    }
    return YES;
}
#pragma mark  -  TYAttributedLabelDelegate

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point { //点击
    
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            if ([linkStr isEqual:@"点击了安全帮助"]) {
                [MBManager showBriefAlert:linkStr];
            }else if([linkStr isEqual:@"点击了找回密码"]){
               STFoundPassWordViewController *vc = [STFoundPassWordViewController new];
               [self.navigationController pushViewController:vc animated:YES];
            }else if([linkStr isEqualToString:@"点击了切换更多"]){
                LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@""
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"登录其他账户", @"我要注册", @"安全帮助", nil];
                [actionSheet show];
            } else if ([linkStr isEqualToString:@"点击了《优趣城用户服务协议》"]){
                STKWWebViewController *wkVc =  [[STKWWebViewController alloc] init];
                wkVc.urlString = @"http://mp.youqucheng.com";
                wkVc.navTitle = @"用户服务协议";
                [self.navigationController pushViewController:wkVc animated:YES];
            }
        }
    }
}
#pragma mark - LCActionSheet Delegate

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %d", (int)buttonIndex);
    if (buttonIndex == 1) {//登录其他账号
        [self.navigationController popViewControllerAnimated:YES];
    } else if(buttonIndex == 2){
//        //我要登录
//        [self.navigationController popViewControllerAnimated:YES];
    } else if (buttonIndex == 3){
        //安全帮助
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.registerInputView.passWordTextView resignFirstResponder];
    [self.registerInputView.niceTextView resignFirstResponder];
    [self.registerInputView.mobileTextView resignFirstResponder];
    [self.registerInputView.VerificationTextField resignFirstResponder];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}


@end
