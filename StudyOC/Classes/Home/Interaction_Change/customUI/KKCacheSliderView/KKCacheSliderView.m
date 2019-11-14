//
//  KKCacheSliderView.m
//  KKToydayNews
//
//  Created by finger on 2017/10/5.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKCacheSliderView.h"

#define TrackHeight 1.5
//#define ThumbImageWH 40

@interface KKCacheSliderView ()

@end

@implementation KKCacheSliderView

- (instancetype)init{
    if(self = [super init]){
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
        self.value = 0.0;
        self.minimumTrackTintColor = [UIColor redColor];
        self.maximumTrackTintColor = [UIColor clearColor];
        [self setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
        self.value = 0.0;
        self.minimumTrackTintColor = [UIColor redColor];
        self.maximumTrackTintColor = [UIColor clearColor];
        [self setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self initUI];
    }
    return self ;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.progressView.frame = CGRectMake(0, self.centerY + TrackHeight/2.0, 100, TrackHeight);
}

- (void)initUI{
    [self insertSubview:self.progressView atIndex:0];
    self.progressView.frame = CGRectMake(0, self.centerY + TrackHeight/2.0, 100, TrackHeight);
}

#pragma mark -- 重写

- (CGRect)trackRectForBounds:(CGRect)bounds {
    [super trackRectForBounds:bounds];
    return CGRectMake(0, (self.height - TrackHeight)/2.0, self.width, TrackHeight);
}

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
//    bounds = [super thumbRectForBounds:bounds trackRect:rect value:value];
//    return CGRectMake(bounds.origin.x, (self.height - ThumbImageWH) / 2.0 , ThumbImageWH, ThumbImageWH);
//}

#pragma mark -- @property setter

- (void)setCacheColor:(UIColor *)cacheColor{
    _cacheColor = cacheColor;
    self.progressView.progressTintColor = [UIColor whiteColor];
}

- (void)setCachaValue:(CGFloat)cachaValue{
    _cachaValue = cachaValue / (self.maximumValue - self.minimumValue);
    self.progressView.progress = _cachaValue;
}

#pragma mark -- @property getter

- (UIProgressView *)progressView{
    if(!_progressView){
        _progressView = ({
            UIProgressView *view = [UIProgressView new];
            view;
        });
    }
    return _progressView;
}

@end
