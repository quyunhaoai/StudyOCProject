//
//  STKWWebViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/6.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "STKWWebViewController.h"

@interface STKWWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong,nonatomic) UIProgressView *progressView;
@property (strong,nonatomic) WKWebView *webView;


@end

@implementation STKWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark - setUpUI
- (void)setUpUI {
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.userContentController = [WKUserContentController new];
    configuration.preferences.javaScriptEnabled = YES;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    configuration.processPool = [WKProcessPool new];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,
                                                           NAVIGATION_BAR_HEIGHT,
                                                           Window_W,
                                                           Window_H - NAVIGATION_BAR_HEIGHT) configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    [self setupProgressView];
    [_webView addObserver:self
               forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    self.title = @"百度";
}

- (void)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + 1, Window_W, 2);
    [progressView setTrackTintColor:[UIColor colorWithRed:244.0/255
                                                    green:244.0/255
                                                     blue:244.0/255
                                                    alpha:1.0]];
    progressView.progressTintColor = COLOR_F42415;
    [self.view addSubview:progressView];
    _progressView = progressView;
    [self.view bringSubviewToFront:self.progressView];
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //开始加载的时候，让进度条显示
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
//    [MBManager showBriefAlert:@"网络故障,请检查网络后重试"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dict = (NSDictionary *)message.body;
    XYLog(@"dict:\n\n%@",dict);

}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

}

//kvo 监听进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
