//
//  HZWebView.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "HZWebView.h"
#import <WebKit/WebKit.h>
@interface HZWebView ()
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) WKWebViewConfiguration *config;
@property(nonatomic, strong) NSURL *url;
@end

@implementation HZWebView
- (void)initWithQuery:(NSDictionary *)dict {
    NSString *url = dict[@"url"];
    _url = [NSURL URLWithString:url];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}
#pragma mark set/get
- (WKWebView *)webView {
    if(!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:self.config];
    }
    return _webView;
}
- (WKWebViewConfiguration *)config {
    if(!_config) {
        _config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        _config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        _config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        _config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        _config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    }
    return _config;
}
@end
