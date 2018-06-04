//
//  AppDelegate.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "AppDelegate.h"
#import <HZRouteFramework/HZRouteFramework.h>
#import "UITabbarViewController0.h"
#import "UITabbarViewController1.h"
#import "UITabbarViewController2.h"
#import "UITabbarViewController3.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    UITabBarItem *tabBartem0 = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"btn-xiaoxi-n"] selectedImage:[UIImage imageNamed:@"btn-xiaoxi-h"]];
    UITabBarItem *tabBartem1 = [[UITabBarItem alloc] initWithTitle:@"工作" image:[UIImage imageNamed:@"btn-gongzuo-n"] selectedImage:[UIImage imageNamed:@"btn-gongzuo-h"]];
      UITabBarItem *tabBartem2 = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"btn-tongxunlu-n"] selectedImage:[UIImage imageNamed:@"btn-tongxunlu-h"]];
    UITabBarItem *tabBartem3 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"btn-wo-h"] selectedImage:[UIImage imageNamed:@"btn-wo-h"]];
    UITabbarViewController0 *vc0 = [[UITabbarViewController0 alloc] initWithNibName:@"UITabbarViewController0" bundle:[NSBundle mainBundle]];
    UITabbarViewController1 *vc1 = [[UITabbarViewController1 alloc] initWithNibName:@"UITabbarViewController1" bundle:[NSBundle mainBundle]];
    UITabbarViewController2 *vc2 = [[UITabbarViewController2 alloc] initWithNibName:@"UITabbarViewController2" bundle:[NSBundle mainBundle]];
    UITabbarViewController3 *vc3 = [[UITabbarViewController3 alloc] initWithNibName:@"UITabbarViewController3" bundle:[NSBundle mainBundle]];
//    [[HZRouteRootViewManager shareManager] initWithViewControllers:@[vc0,vc1,vc2,vc3] tabBarItems:@[tabBartem0,tabBartem1,tabBartem2,tabBartem3]];
//    self.window.rootViewController = [HZRouteRootViewManager shareManager].rootViewContoller;
//     UINavigationController *nv0 = [[UINavigationController alloc] initWithRootViewController:vc0];
//     nv0.tabBarItem = tabBartem0;
//     UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc1];
//     nv1.tabBarItem = tabBartem1;
//     UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//     nv2.tabBarItem = tabBartem2;
//     UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
//     nv3.tabBarItem = tabBartem3;
//    UITabBarController *tabbar = [[UITabBarController alloc] init];
//    [tabbar setViewControllers:@[nv1,nv0,nv2,nv3]];
//    self.window.rootViewController = tabbar;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation  {
    openURL(url);
    return YES;
}
@end
