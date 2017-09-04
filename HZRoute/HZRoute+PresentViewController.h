//
//  HZRoute+PresentViewController.h
//  HZRoute
//  本类主要配合HZRoute 做页面跳转
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "HZRoute.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HZRPresentType) {
     HZRPush, //push 方式打开
     HZRPresent, //模态弹出
};
@interface HZRoute (PresentViewController)

/**
 尝试的用指定的方式去打开指定的页面

 @param viewController 即将被呈现的视图
 @param presentType 呈现的方式
 */
- (void)presentViewController:(UIViewController *)viewController tryPresentType:(HZRPresentType)presentType;

@end
