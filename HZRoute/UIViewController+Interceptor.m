//
//  UIViewController+Interceptor.m
//  HZRoute
//
//  Created by 吴华林 on 2017/10/24.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UIViewController+Interceptor.h"
#import "HZRoute.h"
#import <objc/runtime.h>
@implementation UIViewController (Interceptor)
+(void)load {
    //拦截presentViewController 方法
    SEL presentViewControllerSEL = @selector(presentViewController:animated:completion:);
    SEL InterceptorPresentViewControllerSEL = @selector(interceptor_presentViewController:animated:completion:);
   [self exchanageMethod:presentViewControllerSEL interceptorMethod:InterceptorPresentViewControllerSEL];
    //拦截dismissViewControllerAnimated 方法
    SEL dismissViewControllerSEL = @selector(dismissViewControllerAnimated:completion:);
    SEL interceptorDismissViewControllerSEL = @selector(interceptor_dismissViewControllerAnimated:completion:);
    [self exchanageMethod:dismissViewControllerSEL interceptorMethod:interceptorDismissViewControllerSEL];
}
- (void)interceptor_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //维护正在展示的视图
    [[HZRoute shareRoute] setVisibleViewController:viewControllerToPresent];
    [self interceptor_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
- (void)interceptor_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    //维护正在展示的视图
    [[HZRoute shareRoute] setVisibleViewController:self.presentingViewController];
    [self interceptor_dismissViewControllerAnimated:flag completion:completion];
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
