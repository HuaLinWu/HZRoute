//
//  UINavigationController+Interceptor.m
//  HZRoute
//
//  Created by 吴华林 on 2017/10/24.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UINavigationController+Interceptor.h"
#import <objc/runtime.h>
#import "HZRoute.h"
@implementation UINavigationController (Interceptor)
+ (void)load {
    //交换pushViewController:animated:
    SEL pushViewControllerSEL = @selector(pushViewController:animated:);
    SEL interceptorPushViewControllerSEL = @selector(interceptor_pushViewController:animated:);
    [self exchanageMethod:pushViewControllerSEL interceptorMethod:interceptorPushViewControllerSEL];
    //拦截popViewControllerAnimated
    SEL popViewControllerSEL = @selector(popViewControllerAnimated:);
    SEL interceptorPopViewControllerSEL = @selector(interceptor_popViewControllerAnimated:);
    [self exchanageMethod:popViewControllerSEL interceptorMethod:interceptorPopViewControllerSEL];
    //拦截popToViewController 方法
    SEL popToViewControllerSEL = @selector(popToViewController:animated:);
    SEL interceptorPopToViewControllerSEL = @selector(interceptor_popToViewController:animated:);
    [self exchanageMethod:popToViewControllerSEL interceptorMethod:interceptorPopToViewControllerSEL];
    //拦截popToRootViewControllerAnimated 方法
    SEL popToRootViewControllerSEL = @selector(popToRootViewControllerAnimated:);
    SEL interceptorPopToRootViewControllerSEL = @selector(interceptor_popToRootViewControllerAnimated:);
    [self exchanageMethod:popToRootViewControllerSEL interceptorMethod:interceptorPopToRootViewControllerSEL];
    
}
- (void)interceptor_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //维护正在展示的视图
    [[HZRoute shareRoute] setVisibleViewController:viewController];
    [self interceptor_pushViewController:viewController animated:animated];
}

- (UIViewController *)interceptor_popViewControllerAnimated:(BOOL)animated {
    //维护正在展示的视图
    UIViewController *viewController = [self interceptor_popViewControllerAnimated:animated];
    [[HZRoute shareRoute] setVisibleViewController:self.topViewController];
   return viewController;
}
- (NSArray<__kindof UIViewController *> *)interceptor_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //维护正在展示的视图
    [[HZRoute shareRoute] setVisibleViewController:viewController];
    return [self interceptor_popToViewController:viewController animated:animated];
}
- (NSArray<__kindof UIViewController *> *)interceptor_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray <__kindof UIViewController *>*viewControllers = [self interceptor_popToRootViewControllerAnimated:animated];
    //维护正在展示的视图
    [[HZRoute shareRoute] setVisibleViewController:self.topViewController];
    return viewControllers;
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
