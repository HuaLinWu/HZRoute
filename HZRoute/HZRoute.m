//
//  HZRoute.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "HZRoute.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "HZRoute+PresentViewController.h"
#import "HZRouteGlobalConstant.h"
typedef NS_ENUM(NSInteger,URLType) {
    isAPPURL,//表示APP 的url
    isWebURL,//表示是webURL 的url
    isSystemURL// 打开系统的url
};

@implementation HZRoute

void openURL(NSString *url) {
    if(!url) return;
    static HZRoute *route = nil;
    route = [[HZRoute alloc] init];
    NSURL *routeURL = nil;
    if([url isKindOfClass:[NSString class]]) {
        routeURL = [NSURL URLWithString:[route URLEncodedString:url]];
    } else if([url isKindOfClass:[NSURL class]]) {
        routeURL = (NSURL *)url;
    }
    [route openURL:routeURL];
   
}
#pragma mark private_method
- (void)openURL:(NSURL *)url {
    URLType urlType = [self getURLType:url];
    switch (urlType) {
        case isAPPURL:{
            [self openAPPURL:url];
           break;
        }
        case isWebURL: {
            [self openWebURL:url];
            break;
        }
        case isSystemURL: {
            [self openSystemURL:url];
            break;
        }
    }
}
- (void)openWebURL:(NSURL *)url {
    
    NSDictionary *queryDict = [self getQueryForURL:url];
    if(queryDict[kWebURLOpenTypeQueryName] && [queryDict[kWebURLOpenTypeQueryName] isEqualToString:kWebURLOpenWithBrowserValue]) {
        //表示用自带的浏览器打开
        [self openSystemURL:url];
    } else {
        //创建webView
        Class webViewClass = NSClassFromString(kWebViewClass);
        if(webViewClass) {
            id webView = [[webViewClass alloc] init];
            NSString *urlStr = [url absoluteString];
            if(!url.scheme){
                urlStr = [NSString stringWithFormat:@"%@://%@",kDefaultURLScheme,urlStr];
            }
            webView = [self configViewController:webView query:@{kWebViewURLName:urlStr}];
            //呈现方式
            HZRPresentType presentType = HZRPush;
            if(queryDict[kPresentTypeName] && [queryDict[kPresentTypeName] isEqualToString:kPresentTypePresentValue]) {
                presentType = HZRPresent;
            }
#pragma mark 页面跳转逻辑(本地页面跳转)
            [self presentViewController:webView tryPresentType:presentType];
        }
    }
}
- (void)openSystemURL:(NSURL *)url {
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
#ifdef __IPHONE_10_0
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];

#else
        [[UIApplication sharedApplication] openURL:url];
#endif

    }
}
- (void)openAPPURL:(NSURL *)url {
    NSString *host = url.host;
    NSString *path = url.path;
    if([host isEqualToString:kViewHost]) {
        //表明是一个页面跳转
        if(path) {
          NSArray *paths = [path componentsSeparatedByString:@"/"];
          path = paths[paths.count -1];
          Class viewControllerClass = NSClassFromString(path);
            if(viewControllerClass) {
                NSDictionary *queryDict = [self getQueryForURL:url];
                id viewController = [[viewControllerClass alloc] init];
                viewController = [self configViewController:viewController query:queryDict];
                //呈现方式
                HZRPresentType presentType = HZRPush;
                if(queryDict[kPresentTypeName] && [queryDict[kPresentTypeName] isEqualToString:kPresentTypePresentValue]) {
                    presentType = HZRPresent;
                }
                #pragma mark 页面跳转逻辑(本地页面跳转)
                [self presentViewController:viewController tryPresentType:presentType];
                
            }
        }
    } else if([host isEqualToString:kServiceHost]) {
        //表明名是一个方法调用
         #pragma mark 表明名是一个方法调用
        NSArray *paths = [path componentsSeparatedByString:@"/"];
        NSString *className = nil;
        NSString *method = nil;
        if(paths.count >1) {
            className = paths[1];
            method = paths[2];
        }
        Class viewControllerClass = NSClassFromString(className);
        if(viewControllerClass) {
             id viewController = [[viewControllerClass alloc] init];
             SEL methodSel = NSSelectorFromString(method);
            if(methodSel && [viewController respondsToSelector:methodSel]) {
                Method method = class_getInstanceMethod(viewControllerClass, methodSel);
                int  numberArguments =  method_getNumberOfArguments(method);
                NSDictionary *queryDict = [self getQueryForURL:url];
                if(numberArguments>= [queryDict allKeys].count) {
                    //目标方法比实际参数要多
                } else if (numberArguments < [queryDict allKeys].count) {
                    //目标方法参数比实际要少
                }
            }
        }
    }
}

/**
 根据对象和初始化参数来配置好一个对象

 @param controller 待初始化的对象
 @param query 初始化参数
 */
- (UIViewController *)configViewController:(UIViewController *)controller query:(NSDictionary *)query{
    SEL initMehtod = NSSelectorFromString(kInitViewControllerMethod);
    if([controller respondsToSelector:initMehtod]) {
        IMP imp = [controller methodForSelector:initMehtod];
        void (*func)(id,SEL,NSDictionary *) = (void *)imp;
        func(controller,initMehtod,query);
    } else {
        //如果对象没有实现指定的初始化方法时（这个将参数当成property 进行赋值）
        if(query) {
            for(NSString *key in [query allKeys]) {
                [self safeSetValueToViewController:controller value:query[key] key:key];
            }
        }
    }
    return controller;
}

/**
 安全的给你UIViewController 对象赋值（防止对象赋值的属性不存在的时候，进行赋值的时候出现闪退）

 @param viewController 对象
 @param value 属性的值
 @param key 属性（优先会从property 中key 对应的，如果property 中不存在，再Ivar 中找，如果Ivar 还是不存在，那么会查找Ivar 是否存在_key 如果存在进行赋值，如果以上都没有就会丢掉当前的值）
 */
- (void)safeSetValueToViewController:(UIViewController *)viewController value:(NSString *)value key:(NSString *)key {
    //从property 查找
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([viewController class], &propertyCount);
    for(int i =0; i <propertyCount ; i++) {
        objc_property_t property = propertyList[i];
       NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if([propertyName isEqualToString:key]) {
            [viewController setValue:value forKey:key];
            return;
        }
    }
    //从Ivar 中查找key
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList([viewController class], &ivarCount);
    for(int i=0; i<ivarCount; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([ivarName isEqualToString:key]) {
            object_setIvar(viewController, ivar, value);
            return;
        }
    }
    //从Ivar 中查找_key（这个有时候可能会不准确）
    NSString *_key = [@"_" stringByAppendingString:key];
    for(int i=0; i<ivarCount; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([ivarName isEqualToString:_key]) {
            object_setIvar(viewController, ivar, value);
            return;
        }
    }
}

- (NSString *)URLEncodedString:(NSString *)url
{
    NSCharacterSet *allowedCharacters = [NSCharacterSet URLFragmentAllowedCharacterSet];
    NSString*encodedString = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}
-(NSString *)URLDecodedString:(NSString *)url
{
    return url.stringByRemovingPercentEncoding;
}
#pragma mark set/get
- (URLType)getURLType:(NSURL *)url {
    NSString *scheme = [url.scheme lowercaseString];
    //获取系统scheme
    NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for(NSDictionary *bundleURLTypeDict in bundleURLTypes) {
        NSArray *schemes = bundleURLTypeDict[@"CFBundleURLSchemes"];
        for(NSString *tempScheme in schemes) {
            if([[tempScheme lowercaseString] isEqualToString:scheme]) return isAPPURL;
        }
    }
    //表示为webView的链接
    NSString *regulaStr = @"((http[s]?|ftp|news|gopher|mailto)://)?[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\.[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)?(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *urlStr = [url absoluteString];
   NSTextCheckingResult *checkingResult = [regex firstMatchInString:urlStr options:NSMatchingReportProgress range:NSMakeRange(0, urlStr.length)];
    if(checkingResult) return isWebURL;
  
    
    //默认的是系统的url
    return isSystemURL;
}

- (NSDictionary *)getQueryForURL:(NSURL *)url {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray <NSURLQueryItem *>*items = urlComponents.queryItems;
    NSMutableDictionary *queryDict = [[NSMutableDictionary alloc] init];
    for(NSURLQueryItem *queryItem in items) {
        if(queryItem.value) {
            [queryDict setObject:queryItem.value forKey:queryItem.name];
        }
    }
    return [queryDict copy];
}
@end
