//
//  AppUtilityTests.m
//  AdjustHomeTaskTests
//
//  Created by Sekhar Dudhi, Soma on 20/11/21.
//

#import <XCTest/XCTest.h>
#import "AppUtility.h"

@interface AppUtilityTests : XCTestCase

@end

@implementation AppUtilityTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGetFormattedDateStringFromDate_Success {
    
    NSString * formattedStr = [AppUtility getFormattedDateStringFromDate:[NSDate dateWithTimeIntervalSince1970:100] withFormat:@"ss"];
    NSString *expectedOutput = @"40";
    XCTAssertTrue([formattedStr isEqualToString:expectedOutput]);
}
// testing various negative scenarios
- (void)testGetFormattedDateStringFromDate_nil {
    
    NSDate * date;
    NSString * formattedStr = [AppUtility getFormattedDateStringFromDate:date withFormat:@"ss"];
    XCTAssertTrue([formattedStr isEqualToString:@""]);
    
    NSString * formattedStr1 = [AppUtility getFormattedDateStringFromDate:[NSDate dateWithTimeIntervalSince1970:100] withFormat:@"--"];
    XCTAssertTrue([formattedStr1 isEqualToString:@"--"]);
    
    NSString * formattedStr2 = [AppUtility getFormattedDateStringFromDate:[NSDate dateWithTimeIntervalSince1970:100] withFormat:@"   "];
    XCTAssertTrue([formattedStr2 isEqualToString:@""]);
    
    NSString *nilStr;
    NSString * formattedStr3 = [AppUtility getFormattedDateStringFromDate:[NSDate dateWithTimeIntervalSince1970:100] withFormat:nilStr];
    XCTAssertTrue([formattedStr3 isEqualToString:@""]);
}

- (void)testIsNull {
    NSDate *date;
    XCTAssertTrue([AppUtility isNull:date]);
    NSDate *date1 = [NSDate date];
    XCTAssertFalse([AppUtility isNull:date1]);
}
//  Helper method
//- (NSDate*)createDateFromDay:(int)day week
@end
