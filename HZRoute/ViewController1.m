//
//  ViewController1.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
@property(nonatomic, copy)NSString* a;
@property(nonatomic, assign)NSString* b;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"---->a=%@,b=%@",_a,_b);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
