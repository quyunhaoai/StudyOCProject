//
//  STPersonalCenterViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/16.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STPersonalCenterViewController.h"
#import "TYAttributedLabel.h"

#import "STLoginViewController.h"
#import <JTSImageViewController/JTSImageViewController.h>
@interface STPersonalCenterViewController ()<TYAttributedLabelDelegate>

@end

@implementation STPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:button];
    
    button.frame = CGRectMake(10, 10, 200, 200);
    button.center = self.view.center;
    [button setTitle:@"登录" forState:UIControlStateNormal];
//    [button setImage:IMAGE_NAME(STSystemDefaultImageName) forState:UIControlStateNormal];
    [button setTitleColor:kRedColor forState:UIControlStateNormal];
    [button setBackgroundColor:kBlackColor];
//    [button setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:10];
    [button addTarget:self action:@selector(chickPPNetRequest) forControlEvents:UIControlEventTouchUpInside];
    
    
//    TYAttributedLabel *attriLabel = [[TYAttributedLabel alloc] initWithFrame:CGRectMake(10, 220, 200, 20)];
//    [self.view addSubview:attriLabel];
//    NSString *text = @"安全帮助 | 找回密码 | 切换更多";
//    attriLabel.text = text;
//    attriLabel.textColor = COLOR_056377;
//    attriLabel.font = FONT_15;
//    attriLabel.linkColor = kBlueColor;
//    attriLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    attriLabel.linesSpacing = 5;
//    attriLabel.numberOfLines = 2;
//    attriLabel.delegate = self;
//    TYTextStorage *textStorage = [[TYTextStorage alloc] init];
//    textStorage.range = [text rangeOfString:@"在一起"];
//    textStorage.textColor = kOrangeColor;
//    textStorage.font = FONT_12;
//    [attriLabel addTextStorage:textStorage];
    

//    TYTextStorage *textStorage1 = [[TYTextStorage alloc] init];
//    textStorage1.range = [text rangeOfString:@"北京天安门"];
//    textStorage1.textColor = COLOR_056377;
//    textStorage1.font = FONT_14;
//    [attriLabel addTextStorage:textStorage1];
    
//    [attriLabel sizeToFit];
    
//    [attriLabel appendLinkWithText:@"北京天安门" linkFont:FONT_15 linkColor:COLOR_056377 linkData:@"北京天安门"];
//    attriLabel.linun
//    [attriLabel appendLinkWithText:@"北京天安门" linkFont:FONT_13 linkData:@"111R"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self showImageURL:@"http://e.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg" point:CGPointZero];
}
- (void)showImageURL:(NSString *)url point:(CGPoint)point{
    if(![url hasPrefix:@"http"])return;
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:url];
    imageInfo.referenceView = self.view;
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
    [imageViewer showFromViewController:self.navigationController transition:JTSImageViewControllerTransition_FromOffscreen];
    
}
//- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point { //点击
//    [MBManager showBriefAlert:@"点击"];
//    NSLog(@"%@",attributedLabel.text);
//
//}
//- (void)attributedLabel:(TYAttributedLabel *)attributedLabel lableLongPressOnState:(UIGestureRecognizerState)state atPoint:(CGPoint)point {//非长按
//
//}
//- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point {  //长按
//
//}
- (void)ppNet {
    [PPNetworkHelper openLog];
//    [PPNetworkHelper net]
    [PPNetworkHelper isNetwork];
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType status) {
        NSLog(@"%ld",status);
    }];
    [PPNetworkHelper GET:@"http://is.snssdk.com/article/category/get_subscribed/v2/?iid=25504462036&device_id=43911586446&ac=wifi&channel=iphone6&aid=13&app_name=news_article&version_code=659&version_name=6.5.9&device_platform=ios&ab_version=275263%2C276222%2C271178%2C208278%2C252767%2C249828%2C246859%2C275644%2C268839%2C276183%2C249686%2C249675%2C264842%2C268794%2C249667%2C274584%2C206075%2C249674%2C272432%2C229304%2C276049%2C270947%2C271842%2C275587%2C275947%2C266386%2C271717%2C260441%2C240865%2C274670%2C270388%2C276002%2C251713%2C271059%2C274344%2C275066%2C229399%2C276128%2C270333%2C275347%2C274131%2C267093%2C274411%2C270107%2C258356%2C247848%2C264452%2C276173%2C249045%2C271663%2C244746%2C273961%2C274292%2C264616%2C275350%2C276211%2C268788%2C260656%2C261944%2C241181%2C268341%2C232362%2C265709%2C271194%2C273233%2C239096%2C272011%2C170988%2C269425%2C273499%2C268663%2C275295%2C243585%2C276203%2C272515%2C272486%2C257280%2C261294%2C265122%2C258603&ab_client=a1%2Cc4%2Ce1%2Cf2%2Cg2%2Cf7&ab_feature=94563%2C102749&abflag=3&ssmix=a&device_type=BAC-AL00&device_brand=HUAWEI&language=zh&os_api=24&os_version=7.0&uuid=866432038206049&openudid=50468f33e8fc72cf&manifest_version_code=659&resolution=720*1208&dpi=320&update_version_code=65902&_rticket=1517897403139&plugin=10575&fp=42TqLlm1Pr5_FlHtLrU1FlFSF2Qq&pos=5r_-9Onkv6e_dBoQeCcbeCUfv7G_8fLz-vTp6Pn4v6esrauzqKuur6-rsb_x_On06ej5-L-nr6SzqK6pqa-v4A%3D%3D&rom_version=emotionui_5.1_bac-al00c00b180&ts=1517897403&as=a28564971bcb0a96294897&mas=00d821575ea3fde5405dd395344d4d8767ad8250edd6552d73" parameters:@{} responseCache:^(id responseCache) {
        NSLog(@"%@",responseCache);
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
            
//            [PPNetworkHelper GET:@"https://is.snssdk.com/article/category/get_subscribed/v4/" parameters:@{} success:^(id responseObject) {
//
//            } failure:^(NSError *error) {
//
//            }];
    //        [PPNetworkHelper closeLog];
}
- (void)chickPPNetRequest {
    STLoginViewController *loginVc = [[STLoginViewController alloc] init];
    loginVc.barStyle = [UIApplication sharedApplication].statusBarStyle;
    [self.navigationController pushViewController:loginVc animated:YES];
//    SPAlertController *aaa = [SPAlertController alertControllerWithTitle:@"123" message:@"345" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeNone];
//    SPAlertAction *action = [SPAlertAction actionWithTitle:@"ccc" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
//
//    }];
//    SPAlertAction *bction = [SPAlertAction actionWithTitle:@"111" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
//
//    }];
//    [aaa addAction:action];
//    [aaa addAction:bction];
//
//    [self presentViewController:aaa animated:YES completion:^{
//
//    }];
    
//    [self pres]
    
//    SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"我是主标题" message:@"我是副标题" preferredStyle:SPAlertControllerStyleActionSheet];
//
//    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"Default" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
//
//    }];
//    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"Destructive" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
//
//    }];
//    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"Cancel" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
//
//    }];
//
//    [alert addAction:action1];
//    [alert addAction:action2];
//    [alert addAction:action3];
////    [alert setModalPresentationStyle:UIModalPresentationPageSheet];
//    [self presentViewController:alert animated:YES completion:^{
//
//    }];
}

@end
