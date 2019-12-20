//
//  STCustomHeader.m
//  StudyOC
//
//  Created by 光引科技 on 2019/12/19.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STCustomHeader.h"

@implementation STCustomHeader

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    
    [super prepare];
    // 设置控件的高度
    self.mj_h = 60;
    _indicatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon60LoadingMiddle"]];
    [self addSubview:_indicatorView];

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    
    [super placeSubviews];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(25);
    }];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    
    MJRefreshCheckState;
    
//    XYWeakSelf;
    switch (state) {
        case MJRefreshStateIdle:
        {
            [self stopAnim];
        }
            
            
            break;
        case MJRefreshStatePulling:
        {
            //菊花结束转动
            [self stopAnim];
        }
            
  
            break;
        case MJRefreshStateRefreshing:
        {
            [self startAnim];
        }
            
            break;
        default:
        {
            
        }
            break;
    }
}
//animation
- (void)startAnim {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.indicatorView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnim {
    [self.indicatorView.layer removeAllAnimations];
}
@end
