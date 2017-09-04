//
//  ViewController.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "ViewController.h"
#import "HZRoute.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)initWithQuery:(NSDictionary *)query {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)findFirstResponder:(id)sender {
    NSString *url = @"HZRoute://view/ViewController1?a=1&b=2";

//    NSString *url = @"http://www.jianshu.com/p/7bb5f15f1daa?openWith=browser";
//    NSString *url = @"http://www.jianshu.com/p/7bb5f15f1daa";
//    NSString *url = @"HZRoute://view/HZWebView?url=http://www.jianshu.com/p/7bb5f15f1daa";
//   NSString *url = @"http://127.0.0.1/index.html";
//    NSString *url = @"www.baidu.com";
//      NSString *url = @"http://127.0.0.1:8088/index.html";
//    NSString *url = @"prefs:root=General&path=About";
//    NSString *url = @"HZRoute://service/ViewController/method1:?a=1&b=1";
    openURL(url);
}
- (void)method1:(NSDictionary *)query {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
