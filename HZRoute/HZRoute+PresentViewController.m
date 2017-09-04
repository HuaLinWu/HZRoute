//
//  HZRoute+PresentViewController.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "HZRoute+PresentViewController.h"

@implementation HZRoute (PresentViewController)
- (void)presentViewController:(UIViewController *)viewController tryPresentType:(HZRPresentType)presentType {
    
    UIViewController *topViewController = [self topViewController];
        switch (presentType) {
            case HZRPush: {
                if(!topViewController.navigationController) {
                    //navigationController 不存在的时候，就会用present 去呈现
                    [topViewController presentViewController:viewController animated:YES completion:nil];
                } else {
                    [topViewController.navigationController pushViewController:viewController animated:YES];
                }
                break;
               }
            case HZRPresent: {
                 [topViewController presentViewController:viewController animated:YES completion:nil];
                break;
            }
        }
}
#pragma mark private
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
