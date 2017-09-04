//
//  HZRouteGlobalConstant.h
//  HZRoute
//
//  Created by 吴华林 on 2017/9/4.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#ifndef HZRouteGlobalConstant_h
#define HZRouteGlobalConstant_h
//这个是webURL 打开的方式key
static NSString *const kWebURLOpenTypeQueryName = @"openWith";
//这个是webURL 用系统自带的webView 打开时候 kWebURLOpenTypeQueryName 对应的value
static NSString *const kWebURLOpenWithBrowserValue = @"browser";
//系统自带webview 的类名(这个随着APP 不同可以自定义设置)
static NSString *const kWebViewClass = @"HZWebView";
//承载url 地址的key
static NSString *const kWebViewURLName = @"url";
//初始化viewController的方法名，这个可以根据APP 不同设置不同的（不过请保证参数只有一个）
static NSString *const kInitViewControllerMethod = @"initWithQuery:";
//表示当前的是一个页面跳转host
static NSString *const kViewHost = @"view";
//表示调用APP 的一个服务的host(这个暂定)
static NSString *const kServiceHost = @"service";
//表示页面打开的方式的(没有这个参数默认是尝试用push的方式打开)
static NSString *const kPresentTypeName = @"presentType";
//表示希望新的页面是push 方式打开的
static NSString *const kPresentTypePushValue = @"push";
//表示希望新的页面是present 方式打开的
static NSString *const kPresentTypePresentValue = @"present";
//如果url 地址没有scheme 的时候我们需要设置一个默认的scheme
static NSString *const kDefaultURLScheme = @"http";

#endif
