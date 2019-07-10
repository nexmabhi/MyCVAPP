//
//  Abhishek_s_CVTests.m
//  Abhishek's CVTests
//
//  Created by Dsilva on 10/07/19.
//  Copyright © 2019 Abhishek Dsilva. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CVExtractedObject.h"

@interface Abhishek_s_CVTests : XCTestCase

@end

@implementation Abhishek_s_CVTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

// Extracting info from info.plist (used to fill details)
- (void)testExtractor {
    NSError *error;
    NSArray *arrayOfContents = [CVExtractedObject extraObjects:&error];
    XCTAssertTrue(arrayOfContents.count != 0);
}

@end
