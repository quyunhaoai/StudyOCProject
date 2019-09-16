//
//  STTwoViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/7.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STTwoViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface STTwoViewController ()<CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *mgr;

@end

@implementation STTwoViewController


#pragma mark - 懒加载
- (CLLocationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
        // 区域监听,监听的是用户,所以应该让用户授权获取用户当前位置
        if ([_mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_mgr requestAlwaysAuthorization];
        }
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    // ###细节二:判断设备是否支持区域监听(指定区域类型,一般是圆形区域)
    if (![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        return;
    }
    
    // 0.给定一个区域
    // 0.1 区域的中点坐标
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(38.6518, 104.07642);
    // 0.2区域半径
    CLLocationDistance distance = 1000.0;
    // ###细节一:半径有限制
    if (distance > self.mgr.maximumRegionMonitoringDistance) {
        distance = self.mgr.maximumRegionMonitoringDistance;
    }
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:distance identifier:@"Chaos"];
    
    // 1.开启区域监听 代理中操作 -- 该方法只有用户位置发生了移动才会触发
    //    [self.mgr startMonitoringForRegion:region];
    // 1.根据指定区域请求一下监听到的状态 代理中操作 -- 该方法在程序启动就会监听一下用户的位置
    // 同样当用户位置发生变化时,也会触发相应的代理方法
    [self.mgr requestStateForRegion:region];
}

#pragma mark - CLLocationManagerDelegate

/**
 *  进入指定区域后指定的代码
 *
 *  @param manager 位置管理者
 *  @param region  指定的区域
 */
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域--");
//    self.msgLabel.text = @"欢迎光临--";
}
/**
 *  离开指定区域后执行的代码
 *
 *  @param manager 位置管理者
 *  @param region  指定的区域
 */
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域--");
//    self.msgLabel.text = @"下次再来--";
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    /*
     CLRegionStateUnknown, 不知道
     CLRegionStateInside, 进入区域
     CLRegionStateOutside 离开区域
     */
    if (state == CLRegionStateInside) {
        NSLog(@"欢迎光临！");
//        self.msgLabel.text = @"欢迎光临";
    } else if (state == CLRegionStateOutside) {
        NSLog(@"下次再来！");
//        self.msgLabel.text = @"下次再来";
    }
}



@end
