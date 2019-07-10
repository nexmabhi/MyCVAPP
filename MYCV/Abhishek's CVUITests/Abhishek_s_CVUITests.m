//
//  Abhishek_s_CVUITests.m
//  Abhishek's CVUITests
//
//  Created by Dsilva on 10/07/19.
//  Copyright © 2019 Abhishek Dsilva. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Abhishek_s_CVUITests : XCTestCase

@end

@implementation Abhishek_s_CVUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testSwipeLoad {
    [[[XCUIApplication alloc] init].tables/*@START_MENU_TOKEN@*/.staticTexts[@"Electronics and Telecommunication Engineering Diploma"]/*[[".cells.staticTexts[@\"Electronics and Telecommunication Engineering Diploma\"]",".staticTexts[@\"Electronics and Telecommunication Engineering Diploma\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeLeft];
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"Nov 11"]/*[[".cells.staticTexts[@\"Nov 11\"]",".staticTexts[@\"Nov 11\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeLeft];
    
    XCUIElement *element2 = [[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textView = [[[element2 childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView swipeLeft];
    [textView swipeLeft];
    
    XCUIElement *element = [[[element2 childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    [element swipeUp];
    [element swipeUp];
    
    XCUIElement *textView2 = [element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView2 swipeDown];
    [textView2 tap];
    [textView swipeLeft];
    [element swipeLeft];
    
    XCUIElementQuery *collectionViewsQuery = app.collectionViews;
    XCUIElement *amitElement = [collectionViewsQuery.cells.otherElements containingType:XCUIElementTypeImage identifier:@"amit"].element;
    [amitElement swipeUp];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"My mentor at Reliance, under his mentoring the app reached a stagerring 10 milion users"]/*[[".cells.staticTexts[@\"My mentor at Reliance, under his mentoring the app reached a stagerring 10 milion users\"]",".staticTexts[@\"My mentor at Reliance, under his mentoring the app reached a stagerring 10 milion users\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeDown];
    [amitElement swipeUp];
    
    [self waitForElementToAppear:amitElement withTimeout:5];
}

- (void)waitForElementToAppear:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout
{
    NSUInteger line = __LINE__;
    NSString *file = [NSString stringWithUTF8String:__FILE__];
    NSPredicate *existsPredicate = [NSPredicate predicateWithFormat:@"exists == true"];
    
    [self expectationForPredicate:existsPredicate evaluatedWithObject:element handler:nil];
    
    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSString *message = [NSString stringWithFormat:@"Failed to find %@ after %f seconds",element,timeout];
            [self recordFailureWithDescription:message inFile:file atLine:line expected:YES];
        }
    }];
}

@end
