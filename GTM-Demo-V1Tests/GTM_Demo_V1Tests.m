//
//  GTM_Demo_V1Tests.m
//  GTM-Demo-V1Tests
//
//  Created by chao hsin-cheng on 2015/9/6.
//  Copyright (c) 2015年 chao hsin-cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GTM_Demo_V1Tests : XCTestCase

@end

@implementation GTM_Demo_V1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
