//
//  HZRouteTests.m
//  HZRouteTests
//
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HZRoute.h"
@interface HZRouteTests : XCTestCase

@end

@implementation HZRouteTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *url = @"HZRoute://view/ViewController?a=1&b=2";
    openURL(url);
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
