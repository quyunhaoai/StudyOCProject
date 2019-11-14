//
//  STScanViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/25.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STScanViewController.h"

@interface STScanViewController ()
@property (strong, nonatomic) KKNavTitleView *navTitleView; //  视图

@end

@implementation STScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cameraInvokeMsg = @"相机启动中";
    
//    [self customNavBarwithTitle:@"" andLeftView:@""];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    [MBManager showBriefAlert:strResult];
//    __weak __typeof(self) weakSelf = self;
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
//
//        [weakSelf reStartDevice];
//    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
//    ScanResultViewController *vc = [ScanResultViewController new];
//    vc.imgScan = strResult.imgScanned;
//
//    vc.strScan = strResult.strScanned;
//
//    vc.strCodeType = strResult.strBarCodeType;
//
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)customNavBarWithTitle:(NSString *)title {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleLabel.text = @"扫一扫";
    self.navTitleView.titleLabel.textColor = kWhiteColor;
//    self.navTitleView.leftBtns
}

- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName {
    [self customNavBarWithTitle:title];
    if (imageName.length>0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [backButton setImage:IMAGE_NAME(imageName) forState:UIControlStateNormal];
        [backButton setImage:IMAGE_NAME(imageName) forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    } else {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        //        [backButton setImage:@"" forState:UIControlStateNormal];
        //        [backButton setImage:@"" forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  -  Get

- (KKNavTitleView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = ({
            KKNavTitleView *view = [KKNavTitleView new];
            view.contentOffsetY = (STATUS_BAR_HEIGHT-(13.5))/2 ;
            view.backgroundColor = kClearColor;
            view ;
        });
    }
    return _navTitleView;
}
@end
