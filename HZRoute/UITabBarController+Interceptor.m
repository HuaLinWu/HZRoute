//
//  UITabBarController+Interceptor.m
//  HZRoute
//
//  Created by 吴华林 on 2017/10/24.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UITabBarController+Interceptor.h"
#import "HZRoute.h"
#import <objc/runtime.h>
@implementation UITabBarController (Interceptor)
+ (void)load {
    //拦截setSelectedIndex
    SEL setSelectedIndexSel =@selector(setSelectedIndex:);
    SEL interceptorSetSelectedIndexSel = @selector(interceptor_setSelectedIndex:);
    [self exchanageMethod:setSelectedIndexSel interceptorMethod:interceptorSetSelectedIndexSel];
    //拦截setSelectedViewController
    SEL setSelectedViewControllerSel =@selector(setSelectedViewController:);
    SEL interceptorSetSelectedViewControllerSel = @selector(interceptor_setSelectedViewController:);
    [self exchanageMethod:setSelectedViewControllerSel interceptorMethod:interceptorSetSelectedViewControllerSel];
}
- (void)interceptor_setSelectedIndex:(NSUInteger)index {
   
    [self interceptor_setSelectedIndex:index];
    //维护正在呈现的视图
     [[HZRoute shareRoute] setVisibleViewController:self.selectedViewController];
}
- (void)interceptor_setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    //维护视图
     [[HZRoute shareRoute] setVisibleViewController:selectedViewController];
    [self interceptor_setSelectedViewController:selectedViewController];
    
}
#pragma mark exchanage_method
+ (void)exchanageMethod:(SEL)sourceSEL interceptorMethod:(SEL)interceptorSEL {
    Method sourceMethod = class_getInstanceMethod(self, sourceSEL);
    Method interceptorMethod = class_getInstanceMethod(self, interceptorSEL);
    BOOL addMethod = class_addMethod(self, sourceSEL, method_getImplementation(interceptorMethod), method_getTypeEncoding(interceptorMethod));
    if(addMethod) {
        //添加方法成功
        class_replaceMethod(self, interceptorSEL, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod));
    } else {
        method_exchangeImplementations(sourceMethod, interceptorMethod);
    }
}
@end
