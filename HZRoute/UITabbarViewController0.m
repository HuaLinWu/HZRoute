//
//  UITabbarViewController0.m
//  HZRoute
//
//  Created by 吴华林 on 2017/10/23.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UITabbarViewController0.h"
#import <HZRouteFramework/HZRouteFramework.h>
@interface UITabbarViewController0 ()

@end

@implementation UITabbarViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"123";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (IBAction)jumpToNextAction:(UIButton *)sender {
    UITabbarViewController0 *vc = [[UITabbarViewController0 alloc] initWithNibName:@"UITabbarViewController0" bundle:[NSBundle mainBundle]];

   [[HZRoute shareRoute] presentViewController:vc tryPresentType:HZRPresent animated:YES completion:nil];
   
//    if(random()%2 ==0){
//        //push
//        [[HZRoute shareRoute] presentViewController:vc tryPresentType:HZRPush];
//    } else {
//        //present
//       
//         [[HZRoute shareRoute] presentViewController:vc tryPresentType:HZRPresent];
//    }
//    NSString *url = @"HZRoute://view/webview?url=http://www.jianshu.com/p/7bb5f15f1daa";
//    openURL(url);
}
- (IBAction)goBackAction:(UIButton *)sender {
//    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"title" message:@"123456" preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alertView animated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];

//    [[[HZRoute alloc] init] dismissViewControllerAnimated:YES completion:nil];
//    [self route_dismissViewControllerAnimated:YES completion:nil];
    [[HZRoute shareRoute] dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)goToRootAction:(UIButton *)sender {
//    UITabbarViewController0 *vc = [[UITabbarViewController0 alloc] initWithNibName:@"UITabbarViewController0" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:vc animated:YES];
//    [[[HZRoute alloc] init] dismissToRootViewControllerAnimated:YES needUpdateRootViewControllerStatus:NO completion:nil];
//    [self route_dismissToRootViewControllerAnimated:YES needUpdateRootViewControllerStatus:NO completion:nil];
//    [[HZRoute shareRoute] dismissToRootViewControllerAnimated:YES needUpdateRootViewControllerStatus:NO completion:nil];
    [[HZRoute shareRoute] dismissToRootViewController];
}

@end
